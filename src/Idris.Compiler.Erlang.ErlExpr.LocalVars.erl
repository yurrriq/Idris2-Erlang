-module('Idris.Compiler.Erlang.ErlExpr.LocalVars').

-compile(no_auto_import).

-export(['case--newLocalVar-604'/1, 'dn--un--show_Show__LocalVar'/1, 'dn--un--showPrec_Show__LocalVar'/2, 'dn--un--__Impl_Show_LocalVar'/0, 'un--newLocalVar'/1, 'un--initLocalVars'/1]).

'case--newLocalVar-604'(V0) ->
    case V0 of
      {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVars', E0, E1} -> fun (V1, V2) -> fun (V3) -> 'Idris.Control.Monad.State':'dn--un-->>=_Monad__((StateT $stateType) $m)'(erased, erased, erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V4) -> fun (V5) -> fun (V6) -> fun (V7) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V6, V7) end end end end, fun (V8) -> fun (V9) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V9) end end, fun (V10) -> fun (V11) -> fun (V12) -> fun (V13) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V12, V13) end end end end}, fun (V14) -> fun (V15) -> fun (V16) -> fun (V17) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V16, V17) end end end end, fun (V18) -> fun (V19) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V19) end end}, fun (V20) -> 'Idris.Control.Monad.State':'dn--un--put_MonadState__$stateType_((StateT $stateType) $m)'(erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V21) -> fun (V22) -> fun (V23) -> fun (V24) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V23, V24) end end end end, fun (V25) -> fun (V26) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V26) end end, fun (V27) -> fun (V28) -> fun (V29) -> fun (V30) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V29, V30) end end end end}, fun (V31) -> fun (V32) -> fun (V33) -> fun (V34) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V33, V34) end end end end, fun (V35) -> fun (V36) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V36) end end}, {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVars', V1, (V2 + 1) rem 9223372036854775808}, V20) end, fun (V37) -> fun (V38) -> 'Idris.Control.Monad.State':'dn--un--pure_Applicative__((StateT $stateType) $f)'(erased, erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V39) -> fun (V40) -> fun (V41) -> fun (V42) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V41, V42) end end end end, fun (V43) -> fun (V44) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V44) end end, fun (V45) -> fun (V46) -> fun (V47) -> fun (V48) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V47, V48) end end end end}, fun (V49) -> fun (V50) -> fun (V51) -> fun (V52) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V51, V52) end end end end, fun (V53) -> fun (V54) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V54) end end}, {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVar', V1, V2}, V38) end end, V3) end end(E0, E1);
      _ -> erlang:throw("Error: Unreachable branch")
    end.

'dn--un--show_Show__LocalVar'(V0) ->
    case V0 of
      {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVar', E0, E1} -> fun (V1, V2) -> 'Idris.Prelude.Strings':'un--++'(V1, 'Idris.Prelude':'dn--un--show_Show__Int'(V2)) end(E0, E1);
      _ -> erlang:throw("Error: Unreachable branch")
    end.

'dn--un--showPrec_Show__LocalVar'(V0, V1) -> 'dn--un--show_Show__LocalVar'(V1).

'dn--un--__Impl_Show_LocalVar'() -> {'Idris.Prelude.dn--un--__mkShow', fun (V0) -> 'dn--un--show_Show__LocalVar'(V0) end, fun (V1) -> fun (V2) -> 'dn--un--showPrec_Show__LocalVar'(V1, V2) end end}.

'un--newLocalVar'(V0) ->
    'Idris.Control.Monad.State':'dn--un-->>=_Monad__((StateT $stateType) $m)'(erased, erased, erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V1) -> fun (V2) -> fun (V3) -> fun (V4) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V3, V4) end end end end, fun (V5) -> fun (V6) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V6) end end, fun (V7) -> fun (V8) -> fun (V9) -> fun (V10) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V9, V10) end end end end}, fun (V11) -> fun (V12) -> fun (V13) -> fun (V14) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V13, V14) end end end end, fun (V15) -> fun (V16) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V16) end end}, fun (V17) -> 'Idris.Control.Monad.State':'dn--un--get_MonadState__$stateType_((StateT $stateType) $m)'(erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V18) -> fun (V19) -> fun (V20) -> fun (V21) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V20, V21) end end end end, fun (V22) -> fun (V23) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V23) end end, fun (V24) -> fun (V25) -> fun (V26) -> fun (V27) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V26, V27) end end end end}, fun (V28) -> fun (V29) -> fun (V30) -> fun (V31) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V30, V31) end end end end, fun (V32) -> fun (V33) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V33) end end}, V17) end,
									      fun (V34) ->
										      case V34 of
											{'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVars', E0, E1} -> fun (V35, V36) -> fun (V37) -> 'Idris.Control.Monad.State':'dn--un-->>=_Monad__((StateT $stateType) $m)'(erased, erased, erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V38) -> fun (V39) -> fun (V40) -> fun (V41) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V40, V41) end end end end, fun (V42) -> fun (V43) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V43) end end, fun (V44) -> fun (V45) -> fun (V46) -> fun (V47) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V46, V47) end end end end}, fun (V48) -> fun (V49) -> fun (V50) -> fun (V51) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V50, V51) end end end end, fun (V52) -> fun (V53) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V53) end end}, fun (V54) -> 'Idris.Control.Monad.State':'dn--un--put_MonadState__$stateType_((StateT $stateType) $m)'(erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V55) -> fun (V56) -> fun (V57) -> fun (V58) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V57, V58) end end end end, fun (V59) -> fun (V60) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V60) end end, fun (V61) -> fun (V62) -> fun (V63) -> fun (V64) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V63, V64) end end end end}, fun (V65) -> fun (V66) -> fun (V67) -> fun (V68) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V67, V68) end end end end, fun (V69) -> fun (V70) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V70) end end}, {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVars', V35, (V36 + 1) rem 9223372036854775808}, V54) end, fun (V71) -> fun (V72) -> 'Idris.Control.Monad.State':'dn--un--pure_Applicative__((StateT $stateType) $f)'(erased, erased, erased, {'Idris.Prelude.dn--un--__mkMonad', {'Idris.Prelude.dn--un--__mkApplicative', fun (V73) -> fun (V74) -> fun (V75) -> fun (V76) -> 'Idris.Control.Monad.Identity':'dn--un--map_Functor__Identity'(erased, erased, V75, V76) end end end end, fun (V77) -> fun (V78) -> 'Idris.Control.Monad.Identity':'dn--un--pure_Applicative__Identity'(erased, V78) end end, fun (V79) -> fun (V80) -> fun (V81) -> fun (V82) -> 'Idris.Control.Monad.Identity':'dn--un--<*>_Applicative__Identity'(erased, erased, V81, V82) end end end end}, fun (V83) -> fun (V84) -> fun (V85) -> fun (V86) -> 'Idris.Control.Monad.Identity':'dn--un-->>=_Monad__Identity'(erased, erased, V85, V86) end end end end, fun (V87) -> fun (V88) -> 'Idris.Control.Monad.Identity':'dn--un--join_Monad__Identity'(erased, V88) end end}, {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVar', V35, V36}, V72) end end, V37) end end(E0, E1);
											_ -> erlang:throw("Error: Unreachable branch")
										      end
									      end,
									      V0).

'un--initLocalVars'(V0) -> {'Idris.Compiler.Erlang.ErlExpr.LocalVars.MkLocalVars', V0, 0}.