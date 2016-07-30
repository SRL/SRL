library slacktree;
{==============================================================================]
  Copyright (c) 2016, Jarl `slacky` Holta
  Project: SlackTree
  License: GNU Lesser GPL (http://www.gnu.org/licenses/lgpl.html)
[==============================================================================}
{$mode objfpc}{$H+}
{$macro on}
{$inline on}

{$DEFINE callconv :=
  {$IFDEF WINDOWS}{$IFDEF CPU32}cdecl;{$ELSE}{$ENDIF}{$ENDIF}
  {$IFDEF LINUX}{$IFDEF CPU32}cdecl;{$ELSE}{$ENDIF}{$ENDIF}
}

uses
  SysUtils,
  Math,
  tree;


{$I SimbaPlugin.inc}


function GetPluginABIVersion: Integer; callconv export;
begin
  Result := 2;
end;

procedure SetPluginMemManager(MemMgr : TMemoryManager); callconv export;
begin
  if memisset then
    exit;
  GetMemoryManager(OldMemoryManager);
  SetMemoryManager(MemMgr);
  memisset := True;
end;


procedure OnDetach; callconv export;
begin
  SetMemoryManager(OldMemoryManager);
end;


function GetFunctionCount: Integer; callconv export;
begin
  if not MethodsLoaded then LoadExports;
  Result := Length(Methods);
end;

function GetFunctionInfo(x: Integer; var ProcAddr: Pointer; var ProcDef: PChar): Integer; callconv export;
begin
  Result := x;
  if (x > -1) and InRange(x, 0, High(Methods)) then
  begin
    ProcAddr := Methods[x].procAddr;
    StrPCopy(ProcDef, Methods[x].ProcDef);
    if (x = High(Methods)) then FreeMethods;
  end;
end;



function GetTypeCount: Integer; callconv export;
begin
  if not TypesLoaded then LoadExports;
  Result := Length(TypeDefs);
end;

function GetTypeInfo(x: Integer; var TypeName, TypeDef: PChar): Integer; callconv export;
begin
  Result := x;
  if (x > -1) and InRange(x, 0, High(TypeDefs)) then
  begin
    StrPCopy(TypeName, TypeDefs[x].TypeName);
    StrPCopy(TypeDef,  TypeDefs[x].TypeDef);
    if (x = High(TypeDefs)) then FreeTypes;
  end;
end;


exports GetPluginABIVersion;
exports SetPluginMemManager;
exports GetTypeCount;
exports GetTypeInfo;
exports GetFunctionCount;
exports GetFunctionInfo;
exports OnDetach;

begin
end.
