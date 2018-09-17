library libasyncmouse;

{$mode objfpc}{$H+}

uses
  classes, sysutils, math, windows;

{$i simbaplugin.inc}

procedure SetMousePosition(Window: HWND; X, Y: Int32);
var
  R: TRect;
begin
  GetWindowRect(Window, R);
  SetCursorPos(R.Left + X, R.Top + Y);
end;

function GetMousePosition(Window: HWND): TPoint;
var
  R: TRect;
  P: TPoint;
begin
  GetWindowRect(Window, R);
  GetCursorPos(P);

  Result.X := P.X - R.Left;
  Result.Y := P.Y - R.Top;
end;

// BenLand100's WindMouse.
function WindMouse(Handle: HWND; dyn: PPoint; xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea, accuracy: Double): Boolean;
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
    if (dyn^.x <> xe) or (dyn^.y <> ye) then
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

    SetMousePosition(Handle, Round(xs), Round(ys));

    Sleep(Round((maxWait - minWait) * (step / maxStep) + minWait));
  end;

  if (accuracy = 1) then
    SetMousePosition(Handle, Round(xs), Round(ys));

  Exit(True);
end;

type
  TWindMouseThread = class(TThread)
  protected
    FWindow: HWND;
    FDestination: PPoint;
    FGravity: Double;
    FWind: Double;
    FMinWait: Double;
    FMaxWait: Double;
    FMaxStep: Double;
    FTargetArea: Double;
    FAccuracy: Double;

    procedure Execute; override;
  public
    constructor Create(Window: HWND; Destination: PPoint; Gravity, Wind, MinWait, MaxWait, MaxStep, TargetArea, Accuracy: Double);
  end;

procedure TWindMouseThread.Execute;
var
  From: TPoint;
begin
  repeat
    if (FDestination^.X = $FFFFFF) and (FDestination^.Y = $FFFFFF) then
      Break;

    From := GetMousePosition(FWindow);
  until WindMouse(FWindow, FDestination, From.X, From.Y, FDestination^.X, FDestination^.Y, FGravity, FWind, FMinWait, FMaxWait, FMaxStep, FTargetArea, FAccuracy);

  FDestination^.X := $FFFFFF;
  FDestination^.Y := $FFFFFF;
end;

constructor TWindMouseThread.Create(Window: HWND; Destination: PPoint; Gravity, Wind, MinWait, MaxWait, MaxStep, TargetArea, Accuracy: Double);
begin
  inherited Create(False, 256);

  FreeOnTerminate := True;

  FWindow := Window;
  FDestination := Destination;
  FGravity := Gravity;
  FWind := Wind;
  FMinWait := MinWait;
  FMaxWait := MaxWait;
  FMaxStep := MaxStep;
  FTargetArea := TargetArea;
  FAccuracy := Accuracy;
end;

procedure Lape_ASyncMouse_WindMouse(const Params: PParamArray); cdecl;
begin
  if PPointer(Params^[0])^ = nil then
    PPointer(Params^[0])^ := GetMem(SizeOf(TPoint)); // leaking eight bytes once, oh no!
  PPoint(PPointer(Params^[0])^)^ := PPoint(Params^[2])^;

  TWindMouseThread.Create(PPtrUInt(Params^[1])^, PPointer(Params^[0])^, PDouble(Params^[3])^, PDouble(Params^[4])^, PDouble(Params^[5])^, PDouble(Params^[6])^, PDouble(Params^[7])^, PDouble(Params^[8])^, PDouble(Params^[9])^);
end;

begin
  addGlobalType('type Pointer', 'TASyncMouse');
  addGlobalFunc('procedure TASyncMouse.WindMouse(Target: PtrUInt; Destination: TPoint; Gravity, Wind, MinWait, WaxWait, MaxStep, TargetArea, Accuracy: Double); native;', @Lape_ASyncMouse_WindMouse);
  addCode('procedure TASyncMouse.Move(Destination: TPoint; Accuracy: Double = 1);'                                                                         + LineEnding +
          'var'                                                                                                                                            + LineEnding +
          '  Speed: Double;'                                                                                                                               + LineEnding +
          'begin'                                                                                                                                          + LineEnding +
          '  Speed := (Random(Mouse.Speed) / 2.0 + Mouse.Speed) / 10.0;'                                                                                   + LineEnding +
          ''                                                                                                                                               + LineEnding +
          '  Self.WindMouse(GetNativeWindow(), Destination, Mouse.Gravity, Mouse.Wind, 10.0 / Speed, 15.0 / Speed, 10.0 * Speed, 10.0 * Speed, Accuracy);' + LineEnding +
          'end;'                                                                                                                                           + LineEnding +
          ''                                                                                                                                               + LineEnding +
          'function TASyncMouse.Moving: Boolean;'                                                                                                          + LineEnding +
          'begin'                                                                                                                                          + LineEnding +
          '  Result := TPoint(Self^) <> [$FFFFFF, $FFFFFF];'                                                                                               + LineEnding +
          'end;'                                                                                                                                           + LineEnding +
          ''                                                                                                                                               + LineEnding +
          'function TASyncMouse.Stop: Boolean;'                                                                                                            + LineEnding +
          'begin'                                                                                                                                          + LineEnding +
          '  Result := TPoint(Self^) = [$FFFFFF, $FFFFFF];'                                                                                                + LineEnding +
          'end;'                                                                                                                                           + LineEnding +
          ''                                                                                                                                               + LineEnding +
          'procedure TASyncMouse.ChangeDestination(Destination: TPoint);'                                                                                  + LineEnding +
          'begin'                                                                                                                                          + LineEnding +
          '  if TPoint(Self^) <> [$FFFFFF, $FFFFFF] then'                                                                                                  + LineEnding +
          '    TPoint(Self^) := Destination;'                                                                                                              + LineEnding +
          'end;'                                                                                                                                           + LineEnding +
          ''                                                                                                                                               + LineEnding +
          'var'                                                                                                                                            + LineEnding +
          '  ASyncMouse: TASyncMouse;'                                                                                                                     + LineEnding
         );
end.
