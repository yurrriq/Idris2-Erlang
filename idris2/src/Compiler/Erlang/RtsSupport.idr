module Compiler.Erlang.RtsSupport

import Data.List
import Data.NameMap
import Data.Stream
import Data.Vect
import Core.Core
import Core.TT
import Compiler.Erlang.Name
import Compiler.Erlang.ErlExpr


%default total


-- LOCAL VARIABLES

export
data LV : Type where

export
newLocalVar : {auto lv : Ref LV LocalVars} -> Core LocalVar
newLocalVar = do
  MkLocalVars varPrefix nextIndex <- get LV
  put LV $ MkLocalVars varPrefix (nextIndex + 1)
  pure $ MkLocalVar varPrefix nextIndex

export
newLocalVars : {auto lv : Ref LV LocalVars} -> (count : Nat) -> Core (List LocalVar)
newLocalVars Z = pure []
newLocalVars (S k) = do
  newVar <- newLocalVar
  vars <- newLocalVars k
  pure (newVar :: vars)

export
addLocalVar : {auto lv : Ref LV LocalVars} -> (varName : Name) -> NameMap LocalVar -> Core (NameMap LocalVar, LocalVar)
addLocalVar varName vs = do
  newVar <- newLocalVar
  pure (insert varName newVar vs, newVar)

export
addLocalVars : {auto lv : Ref LV LocalVars} -> (args : List Name) -> NameMap LocalVar -> Core (NameMap LocalVar, List LocalVar)
addLocalVars [] vs = pure (vs, [])
addLocalVars (n :: ns) vs = do
  (vs', newVar) <- addLocalVar n vs
  (vs'', vars) <- addLocalVars ns vs'
  pure (vs'', newVar :: vars)


-- MISC

export
genFC : FC -> Line
genFC (MkFC fileName (startLine, startCol) (endLine, endCol)) = startLine
genFC EmptyFC = 1 -- TODO: What value should I put here?

export
genErased : Line -> ErlExpr
genErased l =
  EAtom l "erased"


-- DATA CONSTRUCTORS

export
genMkUnit : Line -> ErlExpr
genMkUnit l =
  ECon l (constructorName (NS ["Builtin"] (UN "MkUnit"))) []

export
genJust : Line -> ErlExpr -> ErlExpr
genJust l expr =
  ECon l (constructorName (NS ["Prelude"] (UN "Just"))) [expr]

export
genNothing : Line -> ErlExpr
genNothing l =
  ECon l (constructorName (NS ["Prelude"] (UN "Nothing"))) []

export
genRight : Line -> ErlExpr -> ErlExpr
genRight l expr =
  ECon l (constructorName (NS ["Prelude"] (UN "Right"))) [expr]

export
genLeft : Line -> ErlExpr -> ErlExpr
genLeft l expr =
  ECon l (constructorName (NS ["Prelude"] (UN "Left"))) [expr]

-- PrimIO.MkIORes : {0 a : Type} -> (result : a) -> (1 x : %World) -> IORes a
export
genMkIORes : Line -> ErlExpr -> ErlExpr
genMkIORes l expr =
  -- Newtype optimization removes the data constructor:
  -- ECon l (constructorName (NS ["PrimIO"] (UN "MkIORes"))) [expr, EIdrisConstant l IWorldVal]
  expr

-- PrimIO.MkIO : {0 a : Type} -> (1 fn : (1 x : %World) -> IORes a) -> IO a
export
genMkIO : Line -> (worldVar : LocalVar) -> ErlExpr -> ErlExpr
genMkIO l worldVar expr =
  let fn = ELam l [worldVar] (genMkIORes l expr)
  in -- Newtype optimization removes the data constructor:
     -- ECon l (constructorName (NS ["PrimIO"] (UN "MkIO"))) [fn]
     fn


-- HELPER FUNCTIONS

export
genRef : NamespaceInfo -> Line -> Name -> ErlExpr
genRef namespaceInfo l name =
  let (modName, fnName) = moduleNameFunctionName namespaceInfo name
  in if isNameInCurrentModule namespaceInfo name
    then EAtom l fnName
    else ERef l (EAtom l modName) (EAtom l fnName)

export
genUnsafePerformIO : NamespaceInfo -> Line -> ErlExpr -> ErlExpr
genUnsafePerformIO namespaceInfo l action =
  EApp l (genRef namespaceInfo l (NS ["PrimIO"] (UN "unsafePerformIO"))) [genErased l, action]

export
genFunCall : Line -> String -> String -> List ErlExpr -> ErlExpr
genFunCall l modName fnName args =
  EApp l (ERef l (EAtom l modName) (EAtom l fnName)) args

export
genList : Line -> List ErlExpr -> ErlExpr
genList l xs = foldr (\x, acc => ECons l x acc) (ENil l) xs

export
genThrow : Line -> String -> ErlExpr
genThrow l msg =
  genFunCall l "erlang" "throw" [ECharlist l msg]

export
genUnsafeStringToAtom : Line -> ErlExpr -> ErlExpr
genUnsafeStringToAtom l expr =
  let binary = genFunCall l "unicode" "characters_to_binary" [expr]
  in genFunCall l "erlang" "binary_to_atom" [binary, EAtom l "utf8"]

export
genAtomToString : Line -> ErlExpr -> ErlExpr
genAtomToString l expr =
  genFunCall l "erlang" "atom_to_binary" [expr, EAtom l "utf8"]

-- TODO: Replace with `map (ELocal l)`
export
genArgsToLocals : Line -> (args : List LocalVar) -> List ErlExpr
genArgsToLocals l [] = []
genArgsToLocals l (n :: ns) = ELocal l n :: genArgsToLocals l ns

export
genAppCurriedFun : Line -> (curriedFun : ErlExpr) -> List ErlExpr -> ErlExpr
genAppCurriedFun l body [] = body
genAppCurriedFun l body (x :: xs) = genAppCurriedFun l (EApp l body [x]) xs

-- Create a curried function from an uncurried function of a given arity.
-- The transform function is applied to the inner result.
--
-- In Erlang it is similar to:
-- ```
-- fun(V0) -> fun(V1) -> Transform(UncurriedFun(V0, V1)) end end
-- ```
export
genCurry : {auto lv : Ref LV LocalVars} -> Line -> (arity : Nat) -> (transform : ErlExpr -> ErlExpr) -> (uncurriedFun : ErlExpr) -> Core ErlExpr
genCurry l arity transform uncurriedFun = curry l arity transform uncurriedFun []
  where
    curry : Line -> (arity : Nat) -> (transform : ErlExpr -> ErlExpr) -> ErlExpr -> List ErlExpr -> Core ErlExpr
    curry l Z transform body args = pure $ transform (EApp l body (reverse args))
    curry l (S k) transform body args = do
      newVar <- newLocalVar
      pure $ ELam l [newVar] !(curry l k transform body (ELocal l newVar :: args))

-- Create an uncurried function from a curried function of a given arity.
-- The transform function is applied to the inner result.
--
-- In Erlang it is similar to:
-- ```
-- fun(V0, V1) -> Transform((CurriedFun(V0))(V1)) end
-- ```
export
genUncurry : {auto lv : Ref LV LocalVars} -> Line -> (arity : Nat) -> (transform : ErlExpr -> ErlExpr) -> (curriedFun : ErlExpr) -> Core ErlExpr
genUncurry l arity transform curriedFun = do
  vars <- newLocalVars arity
  pure $ ELam l vars (transform (genAppCurriedFun l curriedFun (genArgsToLocals l vars)))

export
genEscriptMain : Line -> (args : ErlExpr) -> (body : ErlExpr) -> ErlExpr
genEscriptMain l args body =
  let saveArgsCall = genFunCall l "persistent_term" "put" [EAtom l "$idris_rts_args", args]
      createEtsCall = genFunCall l "ets" "new" [EAtom l "$idris_rts_ets", genList l [EAtom l "public", EAtom l "named_table"]]
      setEncodingCall = genFunCall l "io" "setopts" [genList l [ETuple l [EAtom l "encoding", EAtom l "unicode"]]]
  in ESequence l
      [ saveArgsCall
      , createEtsCall
      , setEncodingCall
      , body
      ]

export
genErlMain : {auto lv : Ref LV LocalVars} -> Line -> (body : ErlExpr) -> Core ErlExpr
genErlMain l body = do
  let processFlagCall = genFunCall l "erlang" "process_flag" [EAtom l "trap_exit", EAtom l "false"]
  let getArgsCall = genFunCall l "init" "get_plain_arguments" []
  okVar <- newLocalVar
  errorVar <- newLocalVar
  let mainProgram = ESequence l
        [ processFlagCall
        , genEscriptMain l getArgsCall body
        , genHalt l 0
        ]
  pure $ ETryCatch l mainProgram okVar (ELocal l okVar) errorVar (ESequence l [genFunCall l "erlang" "display" [ELocal l errorVar], genHalt l 127])
  where
    genHalt : Line -> (errorCode : Integer) -> ErlExpr
    genHalt l errorCode = genFunCall l "erlang" "halt" [EInteger l errorCode]


-- BOOLEANS

export
genBoolToInt : Line -> ErlExpr -> ErlExpr
genBoolToInt l expr =
  EMatcherCase l
    expr
    [ MConst (MExact (EAtom l "false")) (EInteger l 0)
    ]
    (EInteger l 1)


-- ARITHMETIC

integerPower : Integer -> Nat -> Integer
integerPower base exp = product (take exp (repeat base))

genIntOp : (op : String) -> Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntOp op l bits x y = EOp l "rem" (EOp l op x y) (EInteger l (integerPower 2 bits))

export
genIntAdd : Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntAdd = genIntOp "+"

export
genIntSub : Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntSub = genIntOp "-"

export
genIntMult : Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntMult = genIntOp "*"

export
genIntDiv : Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntDiv = genIntOp "div"

export
genIntShiftL : Line -> (bits : Nat) -> ErlExpr -> ErlExpr -> ErlExpr
genIntShiftL = genIntOp "bsl"

genMod : Line -> ErlExpr -> ErlExpr -> ErlExpr
genMod l x y =
  EMatcherCase l
    (EOp l ">=" x (EInteger l 0))
    [ MConst (MExact (EAtom l "true")) (EOp l "rem" x y)
    ]
    (EOp l "rem" (EOp l "+" x y) y)


-- STRINGS

genUnicodeStringOp : (op : String) -> Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringOp op l x y =
  let xBinary = genFunCall l "unicode" "characters_to_binary" [x]
      yBinary = genFunCall l "unicode" "characters_to_binary" [y]
  in genBoolToInt l (EOp l op xBinary yBinary)

export
genUnicodeStringLT : Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringLT = genUnicodeStringOp "<"

export
genUnicodeStringLTE : Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringLTE = genUnicodeStringOp "=<"

export
genUnicodeStringEQ : Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringEQ = genUnicodeStringOp "=:="

export
genUnicodeStringGTE : Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringGTE = genUnicodeStringOp ">="

export
genUnicodeStringGT : Line -> ErlExpr -> ErlExpr -> ErlExpr
genUnicodeStringGT = genUnicodeStringOp ">"


-- NOTE: Must be total
export
genUnicodeStringLength : Line -> (str : ErlExpr) -> ErlExpr
genUnicodeStringLength l str =
  genFunCall l "string" "length" [str]

-- NOTE: Is allowed to be partial
export
genUnicodeStringHead : Line -> (str : ErlExpr) -> ErlExpr
genUnicodeStringHead l str =
  let nextGraphemeCall = genFunCall l "string" "next_grapheme" [str]
  in genFunCall l "erlang" "hd" [nextGraphemeCall]

-- NOTE: Is allowed to be partial
export
genUnicodeStringTail : Line -> (str : ErlExpr) -> ErlExpr
genUnicodeStringTail l str =
  let nextGraphemeCall = genFunCall l "string" "next_grapheme" [str]
  in genFunCall l "erlang" "tl" [nextGraphemeCall]

-- NOTE: Is allowed to be partial
export
genUnicodeStringIndex : Line -> (str : ErlExpr) -> (index : ErlExpr) -> ErlExpr
genUnicodeStringIndex l str index =
  let charStringCall = genFunCall l "string" "slice" [str, index, EInteger l 1]
      nextGraphemeCall = genFunCall l "string" "next_grapheme" [charStringCall]
  in genFunCall l "erlang" "hd" [nextGraphemeCall]

-- NOTE: Must be total
export
genUnicodeStringCons : Line -> (char : ErlExpr) -> (str : ErlExpr) -> ErlExpr
genUnicodeStringCons l char str =
  ECons l char str

-- NOTE: Must be total
export
genUnicodeStringAppend : Line -> (str1 : ErlExpr) -> (str2 : ErlExpr) -> ErlExpr
genUnicodeStringAppend l str1 str2 =
  ECons l str1 str2

-- NOTE: Must be total
export
genUnicodeStringReverse : Line -> (str : ErlExpr) -> ErlExpr
genUnicodeStringReverse l str =
  genFunCall l "string" "reverse" [str]

-- NOTE: Must be total
export
genUnicodeStringSubstr : Line -> (start : ErlExpr) -> (len : ErlExpr) -> (str : ErlExpr) -> ErlExpr
genUnicodeStringSubstr l start len str =
  genFunCall l "string" "substr" [str, start, len]


-- CAST: Integer -> *

export
genIntegerToInt : Line -> ErlExpr -> ErlExpr
genIntegerToInt l integer =
  integer

export
genIntegerToDouble : Line -> ErlExpr -> ErlExpr
genIntegerToDouble l integer =
  genFunCall l "erlang" "float" [integer]

export
genIntegerToString : Line -> ErlExpr -> ErlExpr
genIntegerToString l integer =
  genFunCall l "erlang" "integer_to_binary" [integer]

export
genIntegerToBits : Line -> (bits : Nat) -> ErlExpr -> ErlExpr
genIntegerToBits l bits integer =
  genMod l integer (EInteger l (integerPower 2 bits))


-- CAST: Int -> *

export
genIntToInteger : Line -> ErlExpr -> ErlExpr
genIntToInteger l int =
  int

export
genIntToDouble : Line -> ErlExpr -> ErlExpr
genIntToDouble l int =
  genFunCall l "erlang" "float" [int]

-- Char is an integer
export
genIntToChar : Line -> ErlExpr -> ErlExpr
genIntToChar l int =
  int

export
genIntToString : Line -> ErlExpr -> ErlExpr
genIntToString l int =
  genFunCall l "erlang" "integer_to_binary" [int]


-- CAST: Double -> *

export
genDoubleToInteger : Line -> ErlExpr -> ErlExpr
genDoubleToInteger l double =
  genFunCall l "erlang" "trunc" [double]

export
genDoubleToInt : Line -> ErlExpr -> ErlExpr
genDoubleToInt l double =
  genFunCall l "erlang" "trunc" [double]

export
genDoubleToString : Line -> ErlExpr -> ErlExpr
genDoubleToString l double =
  let opts = genList l [ETuple l [EAtom l "decimals", EInteger l 10], EAtom l "compact"]
  in genFunCall l "erlang" "float_to_binary" [double, opts]


-- CAST: Char -> *

-- A codepoint is represented by an integer between 0x0 and 0x10FFFF.
-- Return "replacement character" (0xFFFD) if character is not recognized.
-- https://en.wikipedia.org/wiki/Specials_(Unicode_block)
export
genCharToInteger : Line -> ErlExpr -> ErlExpr
genCharToInteger l char =
  EMatcherCase l char [MCodepoint] (EInteger l 65533)

export
genCharToInt : Line -> ErlExpr -> ErlExpr
genCharToInt l char =
  genCharToInteger l char

export
genCharToString : Line -> ErlExpr -> ErlExpr
genCharToString l char =
  genList l [char]


-- CAST: String -> *

export
genStringToInteger : {auto lv : Ref LV LocalVars} -> Line -> ErlExpr -> Core ErlExpr
genStringToInteger l str = do
  integerVar <- newLocalVar
  restVar <- newLocalVar
  let toIntegerCall = genFunCall l "string" "to_integer" [str]
  pure $ EMatcherCase l
      toIntegerCall
      [ MTuple [(integerVar, MInteger), (restVar, MAny)]
          (EMatcherCase l
            (genFunCall l "string" "is_empty" [ELocal l restVar])
            [ MConst (MExact (EAtom l "true")) (ELocal l integerVar)
            ]
            (EInteger l 0))
      ]
      (EInteger l 0)

export
genStringToInt : {auto lv : Ref LV LocalVars} -> Line -> ErlExpr -> Core ErlExpr
genStringToInt l str =
  genStringToInteger l str

-- Try to convert String to Double
-- If it fails; try to convert String to Integer to Double
export
genStringToDouble : {auto lv : Ref LV LocalVars} -> Line -> ErlExpr -> Core ErlExpr
genStringToDouble l str = do
  errorAtomVar <- newLocalVar
  noFloatAtomVar <- newLocalVar
  floatVar <- newLocalVar
  restVar <- newLocalVar
  let toFloatCall = genFunCall l "string" "to_float" [str]
  pure $ EMatcherCase l
      toFloatCall
      [ MTuple [(errorAtomVar, MExact (EAtom l "error")), (noFloatAtomVar, MExact (EAtom l "no_float"))]
          (genFunCall l "erlang" "float" [!(genStringToInteger l str)])
      , MTuple [(floatVar, MFloat), (restVar, MAny)]
          (EMatcherCase l
            (genFunCall l "string" "is_empty" [ELocal l restVar])
            [ MConst (MExact (EAtom l "true")) (ELocal l floatVar)
            ]
            (EFloat l 0))
      ]
      (EFloat l 0)


-- IO

export
genUnicodePutStr : Line -> ErlExpr -> ErlExpr
genUnicodePutStr l str =
  genFunCall l "io" "format" [ECharlist l "~ts", genList l [str]]

export
genUnicodeGetStr : Line -> ErlExpr -> ErlExpr
genUnicodeGetStr l prompt =
  let getLineCall = genFunCall l "io" "get_line" [prompt]
  in genFunCall l "string" "trim" [getLineCall, EAtom l "trailing", ECharlist l "\n"]
