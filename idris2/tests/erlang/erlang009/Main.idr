module Main

import Erlang


-- Wrapper functions around Erlang functions

getValidCharlists : IO (List ErlTerm)
getValidCharlists =
  erlUnsafeCall (List ErlTerm) "test_support" "get_valid_charlists" []

getInvalidCharlists : IO (List ErlTerm)
getInvalidCharlists =
  erlUnsafeCall (List ErlTerm) "test_support" "get_invalid_charlists" []

getValidIOLists : IO (List ErlTerm)
getValidIOLists =
  erlUnsafeCall (List ErlTerm) "test_support" "get_valid_io_lists" []

getInvalidIOLists : IO (List ErlTerm)
getInvalidIOLists =
  erlUnsafeCall (List ErlTerm) "test_support" "get_invalid_io_lists" []


-- Helper functions

ioDataToString : ErlTerm -> String
ioDataToString x = unsafePerformIO $ do
  str <- erlUnsafeCall String "unicode" "characters_to_binary" [x]
  pure str


-- Tests

testCharlists : IO ()
testCharlists = do
  putStrLn "testCharlists"
  validList <- getValidCharlists
  printLn (map (erlDecodeMay charlist) validList)
  invalidList <- getInvalidCharlists
  printLn (map (erlDecodeMay charlist) invalidList)

testIOLists : IO ()
testIOLists = do
  putStrLn "testIOLists"
  validList <- getValidIOLists
  printLn (map (map ioDataToString . erlDecodeMay ioData) validList)
  invalidList <- getInvalidIOLists
  printLn (map (map ioDataToString . erlDecodeMay ioData) invalidList)

main : IO ()
main = do
  testCharlists
  testIOLists
