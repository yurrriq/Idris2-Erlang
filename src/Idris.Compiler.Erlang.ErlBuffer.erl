-module('Idris.Compiler.Erlang.ErlBuffer').

-compile(no_auto_import).

-export(['un--zeroPaddedBinary'/2, 'un--zeroBinary'/1, 'un--genFunCall'/4, 'un--emptyBinary'/1, 'un--bufferSetUnsignedInt'/5, 'un--bufferSetString'/4, 'un--bufferSetSignedInt'/5, 'un--bufferSetGeneric'/6, 'un--bufferSetDouble'/4, 'un--bufferResize'/3, 'un--bufferNew'/2, 'un--bufferGetUnsignedInt'/4, 'un--bufferGetString'/4, 'un--bufferGetSignedInt'/4, 'un--bufferGetGeneric'/6, 'un--bufferGetDouble'/3, 'un--bufferFlatten'/3, 'un--binaryConcat'/3]).

'un--zeroPaddedBinary'(V0, V1) -> 'un--genFunCall'(V0, <<"binary"/utf8>>, <<"copy"/utf8>>, ['un--zeroBinary'(V0), V1]).

'un--zeroBinary'(V0) -> {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V0, 0}}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}}}]}.

'un--genFunCall'(V0, V1, V2, V3) -> {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, {'Idris.Compiler.Erlang.AbstractFormat.AERemoteRef', V0, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALAtom', V0, V1}}, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALAtom', V0, V2}}}, V3}.

'un--emptyBinary'(V0) -> {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, []}.

'un--bufferSetUnsignedInt'(V0, V1, V2, V3, V4) -> 'un--bufferSetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABUnsigned'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABInteger'}}, {'Idris.Prelude.Nothing'}}, V0, V1, V2, V3, V4).

'un--bufferSetString'(V0, V1, V2, V3) -> begin V4 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Padding"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V5 = {'Idris.Compiler.Erlang.AbstractFormat.APBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V0, <<"Start"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V0, <<"Loc"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V0}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V0, <<"Size"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V0, <<"End"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V6 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Start"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"End"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V7 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Size"/utf8>>}, 'un--genFunCall'(V0, <<"erlang"/utf8>>, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Value"/utf8>>}])}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Padding"/utf8>>}, 'un--zeroPaddedBinary'(V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Size"/utf8>>})}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, V5, V4}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [V6, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}}}}, begin V8 = {'Idris.Compiler.Erlang.AbstractFormat.AEOp', V0, <<"-"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Loc"/utf8>>}, 'un--genFunCall'(V0, <<"erlang"/utf8>>, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}])}, begin V9 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Padding"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V10 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Padding"/utf8>>}, 'un--zeroPaddedBinary'(V0, V8)}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [V9, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}}, begin V11 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V0, 1 + (1 + (1 + 0)), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V0, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V0, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Bin"/utf8>>}]}, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Loc"/utf8>>}}, {'Idris.Data.Vect.Nil'}}], V10}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [], V7}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, V11, [V1, V2, V3]} end end end end end end end end.

'un--bufferSetSignedInt'(V0, V1, V2, V3, V4) -> 'un--bufferSetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABSigned'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABInteger'}}, {'Idris.Prelude.Nothing'}}, V0, V1, V2, V3, V4).

'un--bufferSetGeneric'(V0, V1, V2, V3, V4, V5) -> begin V6 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V2, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Padding"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V7 = {'Idris.Compiler.Erlang.AbstractFormat.APBitstring', V2, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V2, <<"Start"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V2, <<"Loc"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V2}, {'Idris.Compiler.Erlang.AbstractFormat.ABSInteger', V2, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}, V0}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V2, <<"End"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V8 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V2, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Start"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSInteger', V2, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}, V0}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"End"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V9 = {'Idris.Compiler.Erlang.AbstractFormat.AEOp', V2, <<"div"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V2, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}}, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V2, 8}}}, begin V10 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V2, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Padding"/utf8>>}, 'un--zeroPaddedBinary'(V2, V9)}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V2, V7, V6}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V2, [V8, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}}}, begin V11 = {'Idris.Compiler.Erlang.AbstractFormat.AEOp', V2, <<"-"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Loc"/utf8>>}, 'un--genFunCall'(V2, <<"erlang"/utf8>>, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Bin"/utf8>>}])}, begin V12 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V2, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Padding"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V2, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSInteger', V2, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}, V0}]}, begin V13 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V2, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Padding"/utf8>>}, 'un--zeroPaddedBinary'(V2, V11)}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V2, [V12, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V2, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}}, begin V14 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V2, 1 + (1 + (1 + 0)), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V2, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V2, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V2, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V2, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V2, <<"Bin"/utf8>>}]}, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V2, <<"Loc"/utf8>>}}, {'Idris.Data.Vect.Nil'}}], V13}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V2, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V2, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V2, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [], V10}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V2, V14, [V3, V4, V5]} end end end end end end end end end.

'un--bufferSetDouble'(V0, V1, V2, V3) -> 'un--bufferSetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABFloat'}}, {'Idris.Prelude.Nothing'}}, 64, V0, V1, V2, V3).

'un--bufferResize'(V0, V1, V2) -> begin V3 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"NewSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}, begin V4 = 'un--genFunCall'(V0, <<"binary"/utf8>>, <<"part"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V0, 0}}, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"NewSize"/utf8>>}]), begin V5 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [V4, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"NewSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}, begin V6 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V0, 1 + (1 + 0), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"NewSize"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V0, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V0, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Bin"/utf8>>}]}, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"NewSize"/utf8>>}}, {'Idris.Data.Vect.Nil'}}], V3}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"NewSize"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [], V5}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, V6, [V1, V2]} end end end end.

'un--bufferNew'(V0, V1) -> {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, ['un--emptyBinary'(V0), V1]}.

'un--bufferGetUnsignedInt'(V0, V1, V2, V3) -> 'un--bufferGetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABUnsigned'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABInteger'}}, {'Idris.Prelude.Nothing'}}, V0, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V1, 0}}, V1, V2, V3).

'un--bufferGetString'(V0, V1, V2, V3) -> begin V4 = {'Idris.Compiler.Erlang.AbstractFormat.APBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V0}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V0, <<"Loc"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V0, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V0, <<"Len"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V0}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V5 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, V4, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, begin V6 = {'Idris.Data.Vect.::', 'un--zeroPaddedBinary'(V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Len"/utf8>>}), {'Idris.Data.Vect.Nil'}}, begin V7 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V0, 1 + (1 + (1 + 0)), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Len"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V0, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V0, <<"+"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Loc"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Len"/utf8>>}}, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V0, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Bin"/utf8>>}]}}, {'Idris.Data.Vect.Nil'}}], V5}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Loc"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Len"/utf8>>}, {'Idris.Data.Vect.Nil'}}}}, [], V6}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, V7, [V1, V2, V3]} end end end end.

'un--bufferGetSignedInt'(V0, V1, V2, V3) -> 'un--bufferGetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABSigned'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABInteger'}}, {'Idris.Prelude.Nothing'}}, V0, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V1, 0}}, V1, V2, V3).

'un--bufferGetGeneric'(V0, V1, V2, V3, V4, V5) -> begin V6 = {'Idris.Compiler.Erlang.AbstractFormat.APBitstring', V3, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V3, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V3}, {'Idris.Compiler.Erlang.AbstractFormat.ABSVar', V3, <<"Loc"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V3, {'Idris.Compiler.Erlang.AbstractFormat.ABPVar', V3, <<"Value"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSInteger', V3, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}, V0}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V3, {'Idris.Compiler.Erlang.AbstractFormat.ABPUniversal', V3}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V7 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V3, V6, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V3, <<"Bin"/utf8>>}}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V3, <<"Value"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, begin V8 = {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V3, <<"div"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGLiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V3, 'Idris.Prelude':'dn--un--cast_Cast__Int_Integer'(V1)}}, {'Idris.Compiler.Erlang.AbstractFormat.AGLiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V3, 8}}}, begin V9 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V3, 1 + (1 + 0), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V3, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V3, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"Loc"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V3, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V3, <<"+"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V3, <<"Loc"/utf8>>}, V8}, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V3, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V3, <<"Bin"/utf8>>}]}}, {'Idris.Data.Vect.Nil'}}], V7}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V3, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V3, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V3, <<"Loc"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [], {'Idris.Data.Vect.::', V2, {'Idris.Data.Vect.Nil'}}}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V3, V9, [V4, V5]} end end end end.

'un--bufferGetDouble'(V0, V1, V2) -> 'un--bufferGetGeneric'({'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABNative'}}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABFloat'}}, {'Idris.Prelude.Nothing'}}, 64, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALFloat', V0, 0.0}}, V0, V1, V2).

'un--bufferFlatten'(V0, V1, V2) -> begin V3 = {'Idris.Compiler.Erlang.AbstractFormat.AEOp', V0, <<"-"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"MaxBytes"/utf8>>}, 'un--genFunCall'(V0, <<"erlang"/utf8>>, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}])}, begin V4 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Padding"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V5 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AEMatch', V0, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Padding"/utf8>>}, 'un--zeroPaddedBinary'(V0, V3)}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [V4, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}}, begin V6 = 'un--genFunCall'(V0, <<"binary"/utf8>>, <<"part"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.AELiteral', {'Idris.Compiler.Erlang.AbstractFormat.ALInteger', V0, 0}}, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"BufSize"/utf8>>}]), begin V7 = {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AETuple', V0, [V6, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.Nil'}}, begin V8 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V0, 1 + (1 + 0), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"MaxBytes"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [{'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.AGOp', V0, <<"=<"/utf8>>, {'Idris.Compiler.Erlang.AbstractFormat.AGFunCall', V0, <<"byte_size"/utf8>>, [{'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"Bin"/utf8>>}]}, {'Idris.Compiler.Erlang.AbstractFormat.AGVar', V0, <<"MaxBytes"/utf8>>}}, {'Idris.Data.Vect.Nil'}}], V5}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APTuple', V0, [{'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"BufSize"/utf8>>}]}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"MaxBytes"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [], V7}, {'Idris.Data.Vect.Nil'}}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, V8, [V1, V2]} end end end end end end.

'un--binaryConcat'(V0, V1, V2) -> begin V3 = {'Idris.Compiler.Erlang.AbstractFormat.AEBitstring', V0, [{'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin1"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}, {'Idris.Compiler.Erlang.AbstractFormat.MkBitSegment', V0, {'Idris.Compiler.Erlang.AbstractFormat.AEVar', V0, <<"Bin2"/utf8>>}, {'Idris.Compiler.Erlang.AbstractFormat.ABSDefault'}, {'Idris.Compiler.Erlang.AbstractFormat.MkTSL', {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Nothing'}, {'Idris.Prelude.Just', {'Idris.Compiler.Erlang.AbstractFormat.ABBinary'}}, {'Idris.Prelude.Nothing'}}}]}, begin V4 = {'Idris.Compiler.Erlang.AbstractFormat.AEFun', V0, 1 + (1 + 0), {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.MkFunClause', V0, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin1"/utf8>>}, {'Idris.Data.Vect.::', {'Idris.Compiler.Erlang.AbstractFormat.APVar', V0, <<"Bin2"/utf8>>}, {'Idris.Data.Vect.Nil'}}}, [], {'Idris.Data.Vect.::', V3, {'Idris.Data.Vect.Nil'}}}, {'Idris.Data.Vect.Nil'}}}, {'Idris.Compiler.Erlang.AbstractFormat.AEFunCall', V0, V4, [V1, V2]} end end.