library libasyncmouse;

{$mode objfpc}{$H+}

uses
  {$IFDEF LINUX}
  cmem, cthreads,
  {$ENDIF}
  classes, sysutils,
  libasyncmouse.asyncmouse, libasyncmouse.threadpool;

{$i simbaplugin.inc}

procedure OnAttach(Data: Pointer); cdecl;
begin
  SimbaThreadPool := TSimbaThreadPool.Create();
end;

procedure OnDetach; cdecl;
begin
  SimbaThreadPool.Free();
end;

exports OnAttach, OnDetach;

type
  PPoint = ^TPoint;

procedure Lape_ASyncMouse_Create(const Params: PParamArray; const Result: Pointer); cdecl;
begin
  PASyncMouse(Result)^ := TASyncMouse.Create(Pointer(Params^[0]^), Pointer(Params^[1]^));
end;

procedure Lape_ASyncMouse_Free(const Params: PParamArray); cdecl;
begin
  PASyncMouse(Params^[0])^.Free();
end;

procedure Lape_ASyncMouse_Move(const Params: PParamArray); cdecl;
begin
  PASyncMouse(Params^[0])^.Move(PPoint(Params^[1])^, PDouble(Params^[2])^, PDouble(Params^[3])^, PDouble(Params^[4])^, PDouble(Params^[5])^, PDouble(Params^[6])^, PDouble(Params^[7])^, PDouble(Params^[8])^);
end;

procedure Lape_ASyncMouse_ChangeDestination(const Params: PParamArray); cdecl;
begin
  PASyncMouse(Params^[0])^.Destination := PPoint(Params^[1])^;
end;

procedure Lape_ASyncMouse_IsMoving(const Params: PParamArray; const Result: Pointer); cdecl;
begin
  PBoolean(Result)^ := PASyncMouse(Params^[0])^.Moving;
end;

procedure Lape_ASyncMouse_Stop(const Params: PParamArray); cdecl;
begin
  PASyncMouse(Params^[0])^.Moving := False;
end;

begin
  addGlobalType('type Pointer', 'TASyncMouse');

  addGlobalFunc('function TASyncMouse.Create(constref MoveMouse, GetMousePosition): TASyncMouse; static; native;', @Lape_ASyncMouse_Create);
  addGlobalFunc('procedure TASyncMouse.Free; native;', @Lape_ASyncMouse_Free);
  addGlobalFunc('procedure TASyncMouse.Move(Destination: TPoint; Accuracy: Double = 1); overload; native;', nil); // Helper for Simba's code completion
  addGlobalFunc('procedure TASyncMouse.Move(Destination: TPoint; Gravity, Wind, MinWait, WaxWait, MaxStep, TargetArea, Accuracy: Double); overload; native;', @Lape_ASyncMouse_Move);
  addGlobalFunc('procedure TASyncMouse.ChangeDestination(Destination: TPoint); native;', @Lape_ASyncMouse_ChangeDestination);
  addGlobalFunc('procedure TASyncMouse.Stop; native;', @Lape_ASyncMouse_Stop);
  addGlobalFunc('function TASyncMouse.IsMoving: Boolean; native;', @Lape_ASyncMouse_IsMoving);

  addCode('procedure TASyncMouse.__MoveMouse(X, Y: Int32); static;'                                                                + LineEnding +
          'begin'                                                                                                                  + LineEnding +
          '  MoveMouse(X, Y);'                                                                                                     + LineEnding +
          'end;'                                                                                                                   + LineEnding +
          ''                                                                                                                       + LineEnding +
          'procedure TASyncMouse.__GetMousePosition(var X, Y: Int32); static;'                                                     + LineEnding +
          'begin'                                                                                                                  + LineEnding +
          '  GetMousePos(X, Y);'                                                                                                   + LineEnding +
          'end;'                                                                                                                   + LineEnding +
          ''                                                                                                                       + LineEnding +
          'procedure TASyncMouse.Move(Destination: TPoint; Accuracy: Double = 1); override;'                                       + LineEnding +
          'var'                                                                                                                    + LineEnding +
          '  Speed: Double := (Random(Mouse.Speed) / 2.0 + Mouse.Speed) / 10.0;'                                                   + LineEnding +
          'begin'                                                                                                                  + LineEnding +
          '  Self.Move(Destination, Mouse.Gravity, Mouse.Wind, 10.0 / Speed, 15.0 / Speed, 10.0 * Speed, 10.0 * Speed, Accuracy);' + LineEnding +
          'end;'                                                                                                                   + LineEnding +
          ''                                                                                                                       + LineEnding +
          'var'                                                                                                                    + LineEnding +
          '  ASyncMouse: TASyncMouse := TASyncMouse.Create('                                                                       + LineEnding +
          '                               Natify(@TASyncMouse.__MoveMouse),'                                                       + LineEnding +
          '                               Natify(@TASyncMouse.__GetMousePosition)'                                                 + LineEnding +
          '                             );'                                                                                        + LineEnding +
          ''                                                                                                                       + LineEnding +
          'begin'                                                                                                                  + LineEnding +
          '  AddOnTerminateAlways(@ASyncMouse.Free);'                                                                              + LineEnding +
          'end;'                                                                                                                   + LineEnding
         );
end.
