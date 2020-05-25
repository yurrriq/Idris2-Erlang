module Compiler.Erlang.ErlExpr

import Data.List
import Control.Monad.State

import Compiler.Erlang.AbstractFormat
import Compiler.Erlang.ErlBuffer
import Compiler.Erlang.Utils


%default total


-- LOCAL VARIABLES

namespace LocalVars
  public export
  record LocalVars where
    constructor MkLocalVars
    varPrefix : String
    nextIndex : Int

  public export
  record LocalVar where
    constructor MkLocalVar
    varPrefix : String
    index : Int

  export
  initLocalVars : String -> LocalVars
  initLocalVars varPrefix = MkLocalVars varPrefix 0

  export
  addLocalVar : State LocalVars LocalVar
  addLocalVar = do
    MkLocalVars varPrefix nextIndex <- get
    put $ MkLocalVars varPrefix (nextIndex + 1)
    pure $ MkLocalVar varPrefix nextIndex

  export
  Show LocalVar where
    show (MkLocalVar varPrefix index) = varPrefix ++ show index


-- EXPRESSIONS

-- Notes:
-- * Erlang case expressions are represented using function expressions, because pattern variables
--   in case expressions can't be shadowed.
-- * Erlang let expressions are represented using function expressions, because let variables can't
--   be shadowed.
-- * EConstCase and EMatcherCase are restricted versions of Erlang case expressions.

public export
data IdrisConstant
  = IInt Int
  | IInteger Integer
  | IString String
  | IChar Char
  | IDouble Double
  | IWorldVal
  | IIntType
  | IIntegerType
  | IStringType
  | ICharType
  | IDoubleType
  | IWorldType

mutual
  public export
  data ErlExpr : Type where
    ELocal : Line -> LocalVar -> ErlExpr
    ERef : Line -> (modName : ErlExpr) -> (fnName : ErlExpr) -> ErlExpr
    ELam : Line -> (args : List LocalVar) -> ErlExpr -> ErlExpr
    EApp : Line -> ErlExpr -> List ErlExpr -> ErlExpr
    EOp : Line -> (op : String) -> (lhs : ErlExpr) -> (rhs : ErlExpr) -> ErlExpr
    ECon : Line -> (name : String) -> List ErlExpr -> ErlExpr
    EConstCase : Line -> (sc : ErlExpr) -> List ErlConstAlt -> (def : ErlExpr) -> ErlExpr
    EMatcherCase : Line -> (sc : ErlExpr) -> List ErlMatcher -> (def : ErlExpr) -> ErlExpr
    EReceive : Line -> List ErlMatcher -> (timeout : ErlExpr) -> (def : ErlExpr) -> ErlExpr
    ETryCatch : Line -> ErlExpr -> (okVar : LocalVar) -> ErlExpr -> (errorVar : LocalVar) -> ErlExpr -> ErlExpr

    EIdrisConstant : Line -> IdrisConstant -> ErlExpr
    EAtom : Line -> String -> ErlExpr
    EChar : Line -> Char -> ErlExpr
    EFloat : Line -> Double -> ErlExpr
    EInteger : Line -> Integer -> ErlExpr
    ECharlist : Line -> String -> ErlExpr
    EBinary : Line -> String -> ErlExpr
    ENil : Line -> ErlExpr
    ECons : Line -> ErlExpr -> ErlExpr -> ErlExpr
    ETuple : Line -> List ErlExpr -> ErlExpr
    EMap : Line -> List (ErlExpr, ErlExpr) -> ErlExpr

    EBufferNew       : Line -> (size : ErlExpr) -> ErlExpr
    EBufferSetByte   : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> (value : ErlExpr) -> ErlExpr
    EBufferGetByte   : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> ErlExpr
    EBufferSetInt    : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> (value : ErlExpr) -> ErlExpr
    EBufferGetInt    : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> ErlExpr
    EBufferSetDouble : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> (value : ErlExpr) -> ErlExpr
    EBufferGetDouble : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> ErlExpr
    EBufferSetString : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> (value : ErlExpr) -> ErlExpr
    EBufferGetString : Line -> (bin : ErlExpr) -> (loc : ErlExpr) -> (len : ErlExpr) -> ErlExpr

  public export
  data ErlConstAlt : Type where
    MkConstAlt : IdrisConstant -> ErlExpr -> ErlConstAlt

  public export
  data ErlMatcher : Type where
    MExact        : ErlExpr -> ErlMatcher
    MAny          : ErlMatcher
    MCodepoint    : ErlMatcher
    MInteger      : ErlMatcher
    MFloat        : ErlMatcher
    MAtom         : ErlMatcher
    MBinary       : ErlMatcher
    MMap          : ErlMatcher
    MPid          : ErlMatcher
    MRef          : ErlMatcher
    MPort         : ErlMatcher
    MAnyList      : ErlMatcher
    MNil          : ErlMatcher
    MCons         : ErlMatcher -> ErlMatcher -> (hdVar : LocalVar) -> (tlVar : LocalVar) -> ErlExpr -> ErlMatcher
    MList         : ErlMatchers -> ErlExpr -> ErlMatcher
    MTuple        : ErlMatchers -> ErlExpr -> ErlMatcher
    MTaggedTuple  : String -> ErlMatchers -> ErlExpr -> ErlMatcher
    MMapSubset    : {args : List LocalVar} -> ErlMapEntryMatchers -> ErlExpr -> ErlMatcher
    MFun          : (arity : Nat) -> ErlMatcher
    MTransform    : ErlMatcher -> (newVar : LocalVar) -> ErlExpr -> ErlMatcher
    MConst        : ErlMatcher -> ErlExpr -> ErlMatcher

  namespace ErlMatchers
    public export
    data ErlMatchers : Type where
      Nil : ErlMatchers
      (::) : {newVar : LocalVar} -> ErlMatcher -> ErlMatchers -> ErlMatchers

  namespace ErlMapEntryMatchers
    public export
    data ErlMapEntryMatchers : Type where
      Nil : ErlMapEntryMatchers
      (::) : {newVar : LocalVar} -> (ErlExpr, ErlMatcher) -> ErlMapEntryMatchers -> ErlMapEntryMatchers

public export
data ErlModuleName : Type where
  MkModuleName : Line -> (name : String) -> ErlModuleName

public export
data ErlAttribute : Type where
  NoAutoImport : Line -> ErlAttribute
  Inline       : Line -> ErlAttribute
  InlineSize   : Line -> Nat -> ErlAttribute

public export
data ErlVisibility = Private | Public

export
Eq ErlVisibility where
  Private == Private = True
  Public == Public = True
  _ == _ = False

public export
data ErlFunDecl : Type where
  MkFunDecl : Line -> (visibility : ErlVisibility) -> (name : String) -> (vars : List LocalVar) -> ErlExpr -> ErlFunDecl

public export
record ErlModule where
  constructor MkModule
  name : ErlModuleName
  attributes : List ErlAttribute
  funDecls : List ErlFunDecl


-- HELPER FUNCTIONS

varsToVarNames : (vars : List LocalVar) -> Vect (length vars) String
varsToVarNames [] = []
varsToVarNames (x :: xs) = show x :: varsToVarNames xs

toNonEmptyFunClauses : (clauses : List (FunClause arity)) -> (def : FunClause arity) -> Vect (S (length clauses)) (FunClause arity)
toNonEmptyFunClauses [] def = [def]
toNonEmptyFunClauses (x :: xs) def = x :: toNonEmptyFunClauses xs def

trueGuard : Line -> Guard
trueGuard l = AGLiteral (ALAtom l "true")

record MatcherClause where
  constructor MkMatcherClause
  pattern : Pattern
  guard : Guard
  body : Expr
  globals : List (LocalVar, Expr)

wrapImmediatelyInvokedFunExpr : Line -> Expr -> Expr
wrapImmediatelyInvokedFunExpr l body =
  AEFunCall l (AEFun l 0 [MkFunClause l [] [] [body]]) []

wrapGlobal : Line -> (LocalVar, Expr) -> Expr -> Expr
wrapGlobal l (var, expr) acc =
  AEFunCall l (AEFun l 1 [MkFunClause l [APVar l (show var)] [] [acc]]) [expr]

genBinary : Line -> String -> Expr
genBinary l str =
  AEBitstring l [MkBitSegment l (AELiteral (ALCharlist l str)) ABSDefault (MkTSL Nothing Nothing (Just ABUtf8) Nothing)]


-- CODE GENERATION

genIdrisConstant : Line -> (String -> a) -> (Literal -> a) -> IdrisConstant -> a
genIdrisConstant l fromString fromLiteral constant =
  case constant of
    IInt x => fromLiteral (ALInteger l (cast x))
    IInteger x => fromLiteral (ALInteger l x)
    IString x => fromString x
    IChar x => fromLiteral (ALChar l x)
    IDouble x => fromLiteral (ALFloat l x)
    IWorldVal => fromLiteral (ALAtom l "world_val")
    IIntType => fromLiteral (ALAtom l "int_type")
    IIntegerType => fromLiteral (ALAtom l "integer_type")
    IStringType => fromLiteral (ALAtom l "string_type")
    ICharType => fromLiteral (ALAtom l "char_type")
    IDoubleType => fromLiteral (ALAtom l "double_type")
    IWorldType => fromLiteral (ALAtom l "world_type")

mutual
  genErlExpr : ErlExpr -> State LocalVars Expr
  genErlExpr (ELocal l var) =
    pure $ AEVar l (show var)
  genErlExpr (ERef l modName fnName) =
    pure $ AERemoteRef l !(genErlExpr modName) !(genErlExpr fnName)
  genErlExpr (ELam l args body) = do
    let varNames = varsToVarNames args
    body' <- genErlExpr body
    pure $ AEFun l (length args) [MkFunClause l (map (APVar l) varNames) [] [body']]
  genErlExpr (EApp l expr args) = do
    expr' <- genErlExpr expr
    args' <- assert_total $ traverse genErlExpr args
    pure $ AEFunCall l expr' args'
  genErlExpr (EOp l opName x y) =
    pure $ AEOp l opName !(genErlExpr x) !(genErlExpr y)
  genErlExpr (ECon l name exprs) = do
    exprs' <- assert_total $ traverse genErlExpr exprs
    pure $ AETuple l (AELiteral (ALAtom l name) :: exprs')
  genErlExpr (EConstCase l sc clauses def) = do
    let defClause = MkFunClause l [APUniversal l] [] [!(genErlExpr def)]
    generatedClauses <- assert_total $ traverse (genErlConstAlt l) clauses
    let caseExpr = AEFun l 1 (toNonEmptyFunClauses generatedClauses defClause)
    pure $  AEFunCall l caseExpr [!(genErlExpr sc)]
  genErlExpr (EMatcherCase l sc matchers def) = do
    let defClause = MkFunClause l [APUniversal l] [] [!(genErlExpr def)]
    generatedClauses <- assert_total (traverse (genErlMatcher l) matchers)
    let caseExpr = AEFun l 1 (toNonEmptyFunClauses (map fst generatedClauses) defClause)
    pure $ foldr (wrapGlobal l) (AEFunCall l caseExpr [!(genErlExpr sc)]) (concat (map snd generatedClauses))
  -- EReceive generates the following code. This is necessary to avoid leaking variables from the case clauses.
  --
  -- If matchers contain `MExact` or `MMapSubset`, the below expression is wrapped in immediately invoked function
  -- expressions to put new variables in scope.
  --
  -- ```
  -- fun() ->
  --   receive
  --     `matchers`
  --   after
  --     `timeout` ->
  --       `def`
  --   end
  -- end()
  -- ```
  genErlExpr (EReceive l matchers timeout def) = do
    let defClause = TimeoutAfter !(genErlExpr timeout) [!(genErlExpr def)]
    generatedClauses <- assert_total (traverse (genErlMatcherCaseClause l) matchers)
    let receiveExpr = wrapImmediatelyInvokedFunExpr l $ AEReceive l (map fst generatedClauses) defClause
    pure $ foldr (wrapGlobal l) receiveExpr (concat (map snd generatedClauses))
  -- ETryCatch generates the following code. This is necessary to avoid leaking variables from the case/catch clauses.
  --
  -- ```
  -- fun
  --   ({ok, Value}) -> `okFun`(Value);
  --   ({error, Error}) -> `errorFun`(Error)
  -- end(
  --   fun() ->
  --     try `expr` of
  --       Value -> {ok, Value}
  --     catch
  --       Class:Reason:Stacktrace -> {error, {Class, Reason, Stacktrace}}
  --     end
  --   end()
  -- )
  -- ```
  genErlExpr (ETryCatch l expr okVar okFun errorVar errorFun) = do
    let tryCaseClause = MkCaseClause l (APVar l "Value") [] [AETuple l [AELiteral (ALAtom l "ok"), AEVar l "Value"]]
    let tryCatchClause = MkCatchClause l (APVar l "Class") (APVar l "Reason") (APVar l "Stacktrace") [] [AETuple l [AELiteral (ALAtom l "error"), AETuple l [AEVar l "Class", AEVar l "Reason", AEVar l "Stacktrace"]]]
    let tryResult = wrapImmediatelyInvokedFunExpr l $ AETry l [!(genErlExpr expr)] [tryCaseClause] [tryCatchClause] []
    let okBody = AEFun l 1 [MkFunClause l [APVar l (show okVar)] [] [!(genErlExpr okFun)]]
    let errorBody = AEFun l 1 [MkFunClause l [APVar l (show errorVar)] [] [!(genErlExpr errorFun)]]
    let okClause = MkFunClause l [APTuple l [APLiteral (ALAtom l "ok"), APVar l "Value"]] [] [AEFunCall l okBody [AEVar l "Value"]]
    let errorClause = MkFunClause l [APTuple l [APLiteral (ALAtom l "error"), APVar l "Error"]] [] [AEFunCall l errorBody [AEVar l "Error"]]
    pure $ AEFunCall l (AEFun l 1 [okClause, errorClause]) [tryResult]
  genErlExpr (EIdrisConstant l x) =
    pure $ genIdrisConstant l (genBinary l) AELiteral x
  genErlExpr (EAtom l x) =
    pure $ AELiteral (ALAtom l x)
  genErlExpr (EChar l x) =
    pure $ AELiteral (ALChar l x)
  genErlExpr (EFloat l x) =
    pure $ AELiteral (ALFloat l x)
  genErlExpr (EInteger l x) =
    pure $ AELiteral (ALInteger l x)
  genErlExpr (ECharlist l x) =
    pure $ AELiteral (ALCharlist l x)
  genErlExpr (EBinary l x) =
    pure $ genBinary l x
  genErlExpr (ENil l) =
    pure $ AENil l
  genErlExpr (ECons l x y) =
    pure $ AECons l !(genErlExpr x) !(genErlExpr y)
  genErlExpr (ETuple l elems) = do
    elems' <- assert_total $ traverse genErlExpr elems
    pure $ AETuple l elems'
  genErlExpr (EMap l entries) = do
    entries' <- assert_total $ traverse (\(key, value) => pure $ MkAssoc l !(genErlExpr key) !(genErlExpr value)) entries
    pure $ AEMapNew l entries'
  genErlExpr (EBufferNew l size) =
    pure $ bufferNew l !(genErlExpr size)
  genErlExpr (EBufferSetByte l bin loc value) =
    pure $ bufferSetByte l !(genErlExpr bin) !(genErlExpr loc) !(genErlExpr value)
  genErlExpr (EBufferGetByte l bin loc) =
    pure $ bufferGetByte l !(genErlExpr bin) !(genErlExpr loc)
  genErlExpr (EBufferSetInt l bin loc value) =
    pure $ bufferSetInt l !(genErlExpr bin) !(genErlExpr loc) !(genErlExpr value)
  genErlExpr (EBufferGetInt l bin loc) =
    pure $ bufferGetInt l !(genErlExpr bin) !(genErlExpr loc)
  genErlExpr (EBufferSetDouble l bin loc value) =
    pure $ bufferSetDouble l !(genErlExpr bin) !(genErlExpr loc) !(genErlExpr value)
  genErlExpr (EBufferGetDouble l bin loc) =
    pure $ bufferGetDouble l !(genErlExpr bin) !(genErlExpr loc)
  genErlExpr (EBufferSetString l bin loc value) =
    pure $ bufferSetString l !(genErlExpr bin) !(genErlExpr loc) !(genErlExpr value)
  genErlExpr (EBufferGetString l bin loc len) =
    pure $ bufferGetString l !(genErlExpr bin) !(genErlExpr loc) !(genErlExpr len)

  genErlConstAlt : Line -> ErlConstAlt -> State LocalVars (FunClause 1)
  genErlConstAlt l (MkConstAlt constant body) = do
    let pattern = genIdrisConstant l stringPattern APLiteral constant
    pure $ MkFunClause l [pattern] [] [!(genErlExpr body)]
  where
    stringPattern : String -> Pattern
    stringPattern str = APBitstring l [MkBitSegment l (ABPCharlist l str) ABSDefault (MkTSL Nothing Nothing (Just ABUtf8) Nothing)]

  genErlMatcher : Line -> ErlMatcher -> State LocalVars (FunClause 1, List (LocalVar, Expr))
  genErlMatcher l matcher = do
    clause <- readErlMatcher l matcher
    pure (MkFunClause l [pattern clause] [MkGuardAlt [guard clause]] [body clause], globals clause)

  genErlMatcherCaseClause : Line -> ErlMatcher -> State LocalVars (CaseClause, List (LocalVar, Expr))
  genErlMatcherCaseClause l matcher = do
    clause <- readErlMatcher l matcher
    pure (MkCaseClause l (pattern clause) [MkGuardAlt [guard clause]] [body clause], globals clause)

  readErlMatcher : Line -> ErlMatcher -> State LocalVars MatcherClause
  readErlMatcher l (MExact expr) = do
    localVar <- addLocalVar
    matchExactVar <- addLocalVar
    matchExactValue <- genErlExpr expr
    let pattern = APVar l (show localVar)
    let guard = AGOp l "=:=" (AGVar l (show localVar)) (AGVar l (show matchExactVar))
    let body = AEVar l (show localVar)
    pure $ MkMatcherClause pattern guard body [(matchExactVar, matchExactValue)]
  readErlMatcher l MAny = do
    localVar <- addLocalVar
    let pattern = APVar l (show localVar)
    let guard = trueGuard l
    let body = AEVar l (show localVar)
    pure $ MkMatcherClause pattern guard body []
  readErlMatcher l MCodepoint = do
    localVar <- addLocalVar
    let pattern = APVar l (show localVar)
    let guardVar = AGVar l (show localVar)
    let isIntegerGuard = AGFunCall l "is_integer" [guardVar]
    let aboveMinValueGuard = AGOp l ">=" guardVar (AGLiteral (ALInteger l 0))
    let belowMaxValueGuard = AGOp l "=<" guardVar (AGLiteral (ALInteger l 1114111)) -- 0x10FFFF
    let guard = AGOp l "andalso" isIntegerGuard (AGOp l "andalso" aboveMinValueGuard belowMaxValueGuard)
    let body = AEVar l (show localVar)
    pure $ MkMatcherClause pattern guard body []
  readErlMatcher l MInteger = readSimpleGuardMatcherClause l "is_integer"
  readErlMatcher l MFloat = readSimpleGuardMatcherClause l "is_float"
  readErlMatcher l MAtom = readSimpleGuardMatcherClause l "is_atom"
  readErlMatcher l MBinary = readSimpleGuardMatcherClause l "is_binary"
  readErlMatcher l MMap = readSimpleGuardMatcherClause l "is_map"
  readErlMatcher l MPid = readSimpleGuardMatcherClause l "is_pid"
  readErlMatcher l MRef = readSimpleGuardMatcherClause l "is_reference"
  readErlMatcher l MPort = readSimpleGuardMatcherClause l "is_port"
  readErlMatcher l MAnyList = readSimpleGuardMatcherClause l "is_list"
  readErlMatcher l MNil = do
    let pattern = APNil l
    let guard = trueGuard l
    let body = AENil l
    pure $ MkMatcherClause pattern guard body []
  readErlMatcher l (MCons x y hdVar tlVar fun) = do
    xClause <- readErlMatcher l x
    yClause <- readErlMatcher l y
    let varNames = varsToVarNames [hdVar, tlVar]
    let wrappedFun = AEFun l 2 [MkFunClause l (map (APVar l) varNames) [] [!(genErlExpr fun)]]
    let pattern = APCons l (pattern xClause) (pattern yClause)
    let guard = AGOp l "andalso" (guard xClause) (guard yClause)
    let body = AEFunCall l wrappedFun [body xClause, body yClause]
    pure $ MkMatcherClause pattern guard body (globals xClause ++ globals yClause)
  readErlMatcher l (MList matchers fun) = do
    erlMatchers <- readErlMatchers l matchers
    let args = map fst erlMatchers
    let clauses = map snd erlMatchers
    let varNames = varsToVarNames args
    let wrappedFun = AEFun l (length args) [MkFunClause l (map (APVar l) varNames) [] [!(genErlExpr fun)]]
    let pattern = foldr (\clause, acc => APCons l (pattern clause) acc) (APNil l) clauses
    let guard = foldl (\acc, clause => AGOp l "andalso" (guard clause) acc) (trueGuard l) clauses
    let body = AEFunCall l wrappedFun (map body clauses)
    pure $ MkMatcherClause pattern guard body (concat (map globals clauses))
  readErlMatcher l (MTuple matchers fun) = do
    erlMatchers <- readErlMatchers l matchers
    let args = map fst erlMatchers
    let clauses = map snd erlMatchers
    let varNames = varsToVarNames args
    let wrappedFun = AEFun l (length args) [MkFunClause l (map (APVar l) varNames) [] [!(genErlExpr fun)]]
    let pattern = APTuple l (map pattern clauses)
    let guard = foldl (\acc, clause => AGOp l "andalso" (guard clause) acc) (trueGuard l) clauses
    let body = AEFunCall l wrappedFun (map body clauses)
    pure $ MkMatcherClause pattern guard body (concat (map globals clauses))
  readErlMatcher l (MTaggedTuple tag matchers fun) = do
    erlMatchers <- readErlMatchers l matchers
    let args = map fst erlMatchers
    let clauses = map snd erlMatchers
    let varNames = varsToVarNames args
    let wrappedFun = AEFun l (length args) [MkFunClause l (map (APVar l) varNames) [] [!(genErlExpr fun)]]
    let pattern = APTuple l (APLiteral (ALAtom l tag) :: map pattern clauses)
    let guard = foldl (\acc, clause => AGOp l "andalso" (guard clause) acc) (trueGuard l) clauses
    let body = AEFunCall l wrappedFun (map body clauses)
    pure $ MkMatcherClause pattern guard body (concat (map globals clauses))
  readErlMatcher l (MMapSubset {args} matchers fun) = do
    clauses <- readErlMapEntryMatchers l matchers
    let varNames = varsToVarNames args
    let wrappedFun = AEFun l (length args) [MkFunClause l (map (APVar l) varNames) [] [!(genErlExpr fun)]]
    let pattern = APMap l (map (\(keyVar, clause) => MkExact l (APVar l (show keyVar)) (pattern clause)) clauses)
    let guard = foldl (\acc, (keyVar, clause) => AGOp l "andalso" (guard clause) acc) (trueGuard l) clauses
    let body = AEFunCall l wrappedFun (map (\(keyVar, clause) => body clause) clauses)
    pure $ MkMatcherClause pattern guard body (concat (map (globals . snd) clauses))
  readErlMatcher l (MFun arity) = do
    localVar <- addLocalVar
    let pattern = APVar l (show localVar)
    let guard = AGFunCall l "is_function" [AGVar l (show localVar), AGLiteral (ALInteger l (cast arity))]
    let body = AEVar l (show localVar)
    pure $ MkMatcherClause pattern guard body []
  readErlMatcher l (MTransform x xVar fun) = do
    xClause <- readErlMatcher l x
    let pattern = pattern xClause
    let guard = guard xClause
    let funClause = MkFunClause l [APVar l (show xVar)] [] [!(genErlExpr fun)]
    let body = AEFunCall l (AEFun l 1 [funClause]) [body xClause]
    pure $ MkMatcherClause pattern guard body (globals xClause)
  readErlMatcher l (MConst x body) = do
    xClause <- readErlMatcher l x
    let pattern = pattern xClause
    let guard = guard xClause
    let body = !(genErlExpr body)
    pure $ MkMatcherClause pattern guard body (globals xClause)

  readSimpleGuardMatcherClause : Line -> (fnName : String) -> State LocalVars MatcherClause
  readSimpleGuardMatcherClause l fnName = do
    localVar <- addLocalVar
    let pattern = APVar l (show localVar)
    let guard = AGFunCall l fnName [AGVar l (show localVar)]
    let body = AEVar l (show localVar)
    pure $ MkMatcherClause pattern guard body []

  readErlMatchers : Line -> ErlMatchers -> State LocalVars (List (LocalVar, MatcherClause))
  readErlMatchers l [] =
    pure []
  readErlMatchers l ((::) {newVar} x xs) = do
    xClause <- readErlMatcher l x
    xsClauses <- readErlMatchers l xs
    pure ((newVar, xClause) :: xsClauses)

  readErlMapEntryMatchers : Line -> ErlMapEntryMatchers -> State LocalVars (List (LocalVar, MatcherClause))
  readErlMapEntryMatchers l [] =
    pure []
  readErlMapEntryMatchers l ((key, matcher) :: xs) = do
    keyVar <- addLocalVar
    keyValue <- genErlExpr key
    xClause <- readErlMatcher l matcher
    let xClause' = record { globals $= ((keyVar, keyValue) ::) } xClause
    xsClauses <- readErlMapEntryMatchers l xs
    pure ((keyVar, xClause') :: xsClauses)

genCompileAttr : Line -> PrimTerm -> Decl
genCompileAttr l primTerm = ADAttribute l "compile" primTerm

genAttribute : ErlAttribute -> Decl
genAttribute (NoAutoImport l) = genCompileAttr l (PAtom "no_auto_import")
genAttribute (Inline l) = genCompileAttr l (PAtom "inline")
genAttribute (InlineSize l size) = genCompileAttr l (PTuple [PAtom "inline_size", PInteger (cast size)])

export
genErlModule : Line -> ErlModule -> List Decl
genErlModule exportsLine mod =
  -- NOTE: The order of declarations are important!
  genModuleName (name mod) :: map genAttribute (attributes mod) ++ [genExports (funDecls mod)] ++ map genFunDef (funDecls mod)
  where
    genModuleName : ErlModuleName -> Decl
    genModuleName (MkModuleName l name) = ADModule l name
    genExports : List ErlFunDecl -> Decl
    genExports funDecls =
      let exports = mapMaybe (\(MkFunDecl l visibility name args body) => if visibility == Public then Just (name, length args) else Nothing) funDecls
      in ADExport exportsLine exports
    genFunDef : ErlFunDecl -> Decl
    genFunDef (MkFunDecl l visibility name args body) =
      let varNames = varsToVarNames args
          expr = evalState (genErlExpr body) (initLocalVars "E")
      in ADFunDef l name (length args) [MkFunClause l (map (APVar l) varNames) [] [expr]]