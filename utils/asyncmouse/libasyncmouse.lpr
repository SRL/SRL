library libasyncmouse;

{$mode objfpc}{$H+}

uses
  {$IFDEF LINUX}
  cmem, cthreads,
  {$ENDIF}
  classes, sysutils, math;

{$i simbaplugin.inc}

type
  TASyncMouse = packed record Destination: TPoint; Moving: Boolean; end;

type
  TTarget = record
    Target: Pointer;

    GetTargetDim:   procedure(Target: Pointer; var w, h: Int32); stdcall;
    GetTargetPos:   procedure(Target: Pointer; var top, left: Int32); stdcall;
    GetColor:       function(Target: Pointer; X, Y: Int32): Int32; stdcall;
    ReturnData:     function(Target: Pointer; X, Y, Width, Height: Int32): Pointer; stdcall;
    FreeReturnData: procedure(Target: Pointer); stdcall;

    GetMousePos:       procedure(Target: Pointer; var X, Y: Int32); stdcall;
    MoveMouse:         procedure(Target: Pointer; X, Y: Int32); stdcall;
    ScrollMouse:       procedure(Target: Pointer; X, Y: Int32; Lines: Int32); stdcall;
    HoldMouse:         procedure(Target: Pointer; X, Y: Int32; Left: Boolean); stdcall;
    ReleaseMouse:      procedure(Target: Pointer; X, Y: Int32; Left: Boolean); stdcall;
    IsMouseButtonHeld: function(Target: Pointer; Left: Boolean) : Boolean; stdcall;

    SendString: procedure(Target: Pointer; Str: PChar; KeyWait, KeyModWait: Int32); stdcall;
    HoldKey:    procedure(Target: Pointer; Key: Int32); stdcall;
    ReleaseKey: procedure(Target: Pointer; Key: Int32); stdcall;
    IsKeyHeld:  function (Target: Pointer; Key: Int32): Boolean; stdcall;
    GetKeyCode: function (Target: Pointer; C: Char): Int32; stdcall;
  end;

type
  TWindMouseThread = class(TThread)
  protected
    function WindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea, accuracy: Double): Boolean;

    procedure Execute; override;
  public
    FMouse: ^TASyncMouse;
    FGravity: Double;
    FWind: Double;
    FMinWait: Double;
    FMaxWait: Double;
    FMaxStep: Double;
    FTargetArea: Double;
    FAccuracy: Double;
    FClient: TTarget;
  end;

// BenLand100's WindMouse
// Returns false if mouse destination changes.
function TWindMouseThread.WindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea, accuracy: Double): Boolean;
var
  veloX, veloY, windX, windY, veloMag, dist, randomDist, step: Double;
  sqrt2, sqrt3, sqrt5: Double;
begin
  sqrt2 := sqrt(2);
  sqrt3 := sqrt(3);
  sqrt5 := sqrt(5);

  windX := 0;
  windY := 0;
  veloX := 0;
  veloY := 0;

  while True do
  begin
    if (FMouse^.Destination.X <> xe) or (FMouse^.Destination.Y <> ye) then
      Exit(False); // go again!

    dist := Hypot(xs - xe, ys - ye);
    if (dist <= accuracy) then
      Break;

    wind := Math.Min(wind, dist);

    if dist >= targetArea then
    begin
      windX := windX / sqrt3 + (Random(Round(wind) * 2 + 1) - wind) / sqrt5;
      windY := windY / sqrt3 + (Random(Round(wind) * 2 + 1) - wind) / sqrt5;
    end else
    begin
      windX := windX / sqrt2;
      windY := windY / sqrt2;

      if (maxStep < 3) then
        maxStep := Random(3) + 3.0
      else
        maxStep := maxStep / sqrt5;
    end;

    veloX := veloX + windX;
    veloY := veloY + windY;
    veloX := veloX + gravity * (xe - xs) / dist;
    veloY := veloY + gravity * (ye - ys) / dist;

    if (Hypot(veloX, veloY) > maxStep) then
    begin
      randomDist := maxStep / 2.0 + Random(round(maxStep) div 2);

      veloMag := sqrt(veloX * veloX + veloY * veloY);
      veloX := (veloX / veloMag) * randomDist;
      veloY := (veloY / veloMag) * randomDist;
    end;

    xs := xs + veloX;
    ys := ys + veloY;
    step := Hypot(xs - (xs - veloX), ys - (ys - veloY));

    FClient.MoveMouse(FClient.Target, Round(xs), Round(ys));

    Sleep(Round((maxWait - minWait) * (step / maxStep) + minWait));
  end;

  if (accuracy = 1) then
    FClient.MoveMouse(FClient.Target, Round(xe), Round(ye));

  Exit(True);
end;

procedure TWindMouseThread.Execute;
var
  From: TPoint;
begin
  repeat
    if (FMouse^.Destination.X = $FFFFFF) or (FMouse^.Destination.Y = $FFFFFF) then
      Break;

    FClient.GetMousePos(FClient.Target, From.X, From.Y);
  until WindMouse({%H-}From.X, {%H-}From.Y, FMouse^.Destination.X, FMouse^.Destination.Y, FGravity, FWind, FMinWait, FMaxWait, FMaxStep, FTargetArea, FAccuracy);

  FMouse^.Moving := False;
end;

procedure Lape_ASyncMouse_WindMouse(const Params: PParamArray); cdecl;
begin
  TASyncMouse(Params^[0]^).Moving := True;

  with TWindMouseThread.Create(True) do
  begin
    FreeOnTerminate := True;

    FMouse := Params^[0];
    FClient := TTarget(Params^[1]^);
    FGravity := PDouble(Params^[2])^;
    FWind := PDouble(Params^[3])^;
    FMinWait := PDouble(Params^[4])^;
    FMaxWait := PDouble(Params^[5])^;
    FMaxStep := PDouble(Params^[6])^;
    FTargetArea := PDouble(Params^[7])^;
    FAccuracy := PDouble(Params^[8])^;

    Start();
  end;
end;

begin
  addGlobalType('packed record Destination: TPoint; Moving: Boolean; end;', 'TASyncMouse');
  addGlobalFunc('procedure TASyncMouse.WindMouse(Target: TTarget_Exported; Gravity, Wind, MinWait, WaxWait, MaxStep, TargetArea, Accuracy: Double); native;', @Lape_ASyncMouse_WindMouse);
  addCode('procedure TASyncMouse.Move(Destination: TPoint; Accuracy: Double = 1);'                                                                 + LineEnding +
          'var'                                                                                                                                    + LineEnding +
          '  Speed: Double;'                                                                                                                       + LineEnding +
          'begin'                                                                                                                                  + LineEnding +
          '  Speed := (Random(Mouse.Speed) / 2.0 + Mouse.Speed) / 10.0;'                                                                           + LineEnding +
          ''                                                                                                                                       + LineEnding +
          '  Self.Destination := Destination;'                                                                                                     + LineEnding +
          '  Self.WindMouse(ExportKeyMouseTarget(), Mouse.Gravity, Mouse.Wind, 10.0 / Speed, 15.0 / Speed, 10.0 * Speed, 10.0 * Speed, Accuracy);' + LineEnding +
          'end;'                                                                                                                                   + LineEnding +
          ''                                                                                                                                       + LineEnding +
          'procedure TASyncMouse.Stop;'                                                                                                            + LineEnding +
          'begin'                                                                                                                                  + LineEnding +
          '  Self.Destination := [$FFFFFF, $FFFFFF];'                                                                                              + LineEnding +
          'end;'                                                                                                                                   + LineEnding +
          ''                                                                                                                                       + LineEnding +
          'procedure TASyncMouse.OnTerminate;'                                                                                                     + LineEnding +
          'begin'                                                                                                                                  + LineEnding +
          '  while Self.Moving do'                                                                                                                 + LineEnding +
          '    Wait(50);'                                                                                                                          + LineEnding +
          'end;'                                                                                                                                   + LineEnding +
          ''                                                                                                                                       + LineEnding +
          'var'                                                                                                                                    + LineEnding +
          '  ASyncMouse: TASyncMouse;'                                                                                                             + LineEnding +
          ''                                                                                                                                       + LineEnding +
          'begin'                                                                                                                                  + LineEnding +
          '  AddOnTerminateAlways(@ASyncMouse.OnTerminate);'                                                                                       + LineEnding +
          'end;'                                                                                                                                   + LineEnding
         );
end.
