unit libasyncmouse.threadpool;

{$mode objfpc}{$H+}

interface

uses
  classes, sysutils, syncobjs;

type
  TSimbaThreadPool_Thread = class;
  TSimbaThreadPool_ThreadArray = array of TSimbaThreadPool_Thread;

  TSimbaThreadPool_Thread = class(TThread)
  protected
    FEvent: TEventObject;
    FMethod: TThreadMethod;
    FActive: Boolean;

    procedure Execute; override;
  public
    property Active: Boolean read FActive write FActive;

    procedure Run(Method: TThreadMethod);
    procedure Terminate;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TSimbaThreadPool = class
  protected
    FThreads: TSimbaThreadPool_ThreadArray;
    FLock: TCriticalSection;

    function GetAvailableThread: TSimbaThreadPool_Thread;
  public
    procedure Run(Method: TThreadMethod);

    constructor Create;
    destructor Destroy; override;
  end;

var
  SimbaThreadPool: TSimbaThreadPool;

implementation

procedure TSimbaThreadPool_Thread.Execute;
begin
  while (not Terminated) do
  begin
    FEvent.WaitFor(INFINITE);

    if (FMethod <> nil) then
    begin
      FMethod();
      FMethod := nil;
    end;

    FEvent.ResetEvent();

    FActive := False;
  end;
end;

procedure TSimbaThreadPool_Thread.Run(Method: TThreadMethod);
begin
  FMethod := Method;

  FEvent.SetEvent(); // begin execution
end;

procedure TSimbaThreadPool_Thread.Terminate;
begin
  inherited Terminate();

  FEvent.SetEvent(); // call event so execute loop can execute.
end;

constructor TSimbaThreadPool_Thread.Create;
begin
  FEvent := TEventObject.Create(nil, True, False, '');

  inherited Create(False, 1024 * 512);
end;

destructor TSimbaThreadPool_Thread.Destroy;
begin
  FEvent.Free();

  inherited Destroy;
end;

function TSimbaThreadPool.GetAvailableThread: TSimbaThreadPool_Thread;
var
  i: Int32;
begin
  FLock.Enter();

  try
    for i := 0 to High(FThreads) do
      if (not FThreads[i].Active) then
      begin
        Result := FThreads[i];
        Result.Active := True;

        Exit;
      end;

    WriteLn('[ASYNCMOUSE]: Creating thread ', Length(FThreads));

    Result := TSimbaThreadPool_Thread.Create();
    Result.Active := True;

    SetLength(FThreads, Length(FThreads) + 1);
    FThreads[High(FThreads)] := Result;
  finally
    FLock.Leave();
  end;
end;

constructor TSimbaThreadPool.Create;
begin
  inherited Create();

  FLock := TCriticalSection.Create();
end;

destructor TSimbaThreadPool.Destroy;
var
  i: Int32;
begin
  FLock.Enter();

  try
    for i := 0 to High(FThreads) do
    begin
      WriteLn('[ASYNCMOUSE]: Destroying thread ', i);

      while FThreads[i].Active do
        Sleep(1);

      FThreads[i].Terminate();
      FThreads[i].WaitFor();
      FThreads[i].Free();
    end;
  finally
    FLock.Leave();
  end;

  FLock.Free();

  inherited Destroy();
end;

procedure TSimbaThreadPool.Run(Method: TThreadMethod);
var
  Thread: TSimbaThreadPool_Thread;
begin
  Thread := Self.GetAvailableThread();
  Thread.Run(Method);
end;

end.

