{==============================================================================]
  Copyright (c) 2016, Jarl `slacky` Holta
  Project: SlackTree
  License: GNU Lesser GPL (http://www.gnu.org/licenses/lgpl.html)
[==============================================================================}
var
  Methods: array of record procAddr: Pointer; ProcDef:PChar; end;
  TypeDefs: array of record TypeName, TypeDef:PChar; end;
  TypesLoaded: Boolean = False;
  MethodsLoaded: Boolean = False;
  
  OldMemoryManager: TMemoryManager;
  MemIsset: Boolean = False;


procedure AddMethod(ProcAddr: Pointer; ProcDef: PChar);
var L: Integer;
begin
  L := Length(Methods);
  SetLength(Methods, L + 1);
  Methods[l].ProcAddr := ProcAddr;
  Methods[l].ProcDef := ProcDef;
end;

procedure AddType(TypeName, TypeDef: PChar);
var L: Integer;
begin
  L := Length(TypeDefs);
  SetLength(TypeDefs, L + 1);
  TypeDefs[l].TypeName := TypeName;
  TypeDefs[l].TypeDef := TypeDef;
end;

procedure LoadExports;
begin
  AddType('TSlackNode', 'packed record split: TPoint; l,r: Int32; hidden: Boolean; end;');
  AddType('PSlackNode', '^TSlackNode');
  AddType('TSlackArray', 'array of TSlackNode;');
  AddType('TSlackRefArray', 'array of PSlackNode;');
  AddType('TSlackTree', 'packed record data: TSlackArray; size: Int32; end;');
  
  AddMethod(@TSlackTree_Init,          'procedure TSlackTree.Init(TPA:TPointArray);');
  AddMethod(@TSlackTree_Free,          'procedure TSlackTree.Free();');
  AddMethod(@TSlackTree_IndexOf,       'function TSlackTree.IndexOf(pt:TPoint): Int32;');
  AddMethod(@TSlackTree_Find,          'function TSlackTree.Find(pt:TPoint): PSlackNode;');
  AddMethod(@TSlackTree_HideNode,      'procedure TSlackTree.Hide(idx:Int32);');
  AddMethod(@TSlackTree_HideNode2,     'function TSlackTree.Hide(pt:TPoint): LongBool; overload;');
  AddMethod(@TSlackTree_RawNearest,    'function TSlackTree.Nearest_N(pt:TPoint; notEqual:LongBool=False): PSlackNode;');
  AddMethod(@TSlackTree_Nearest,       'function TSlackTree.Nearest(pt:TPoint; notEqual:LongBool=False): TPoint;');
  AddMethod(@TSlackTree_RawKNearest,   'function TSlackTree.RawKNearest(pt:TPoint; k:Int32; notEqual:LongBool=False): TSlackRefArray;');
  AddMethod(@TSlackTree_KNearest,      'function TSlackTree.KNearest(pt:TPoint; k:Int32; notEqual:LongBool=False): TPointArray;');
  AddMethod(@TSlackTree_RawRangeQuery, 'function TSlackTree.RawRangeQuery(B:TBox): TSlackRefArray;');
  AddMethod(@TSlackTree_RangeQuery,    'function TSlackTree.RangeQuery(B:TBox; hide:LongBool=False): TPointArray;');
  AddMethod(@TSlackTree_RangeQueryEx,  'function TSlackTree.RangeQueryEx(query:TPoint; xRad,yRad:Double; hide:LongBool=False): TPointArray; overload;');
  AddMethod(@TSlackTree_RangeQueryEx2, 'function TSlackTree.RangeQueryEx(query:TPoint; xmin,ymin,xmax,ymax:double; hide:LongBool=False): TPointArray; overload;');
  AddMethod(@TSlackTree_RefArray,      'function TSlackTree.RefArray: TSlackRefArray;');

  MethodsLoaded := True;
  TypesLoaded := True;
end;

procedure FreeMethods;
begin
  SetLength(Methods, 0);
  MethodsLoaded := False;
end;


procedure FreeTypes;
begin
  SetLength(TypeDefs, 0);
  TypesLoaded := False;
end;
