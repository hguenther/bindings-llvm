{-# OPTIONS -cpp -pgmPcpphs -optP--cpp #-}
module LLVM.FFI.Value
       (Value(),ValueC(),
        Argument(),
        argumentGetParent,
        argumentGetArgNo,
        InlineAsm(),
        MDNode(),
        MDString(),
        PseudoSourceValue(),
        FixedStackPseudoSourceValue(),
        GetType(..),
        deleteValue,
        valueDump,
        valueGetType,
        hasName,
        getName,
        getNameString)
        where

import LLVM.FFI.Interface
import LLVM.FFI.Type
import LLVM.FFI.OOP
import LLVM.FFI.StringRef

import Foreign
import Foreign.C

argumentGetArgNo :: Ptr Argument -> IO Integer
argumentGetArgNo ptr = fmap toInteger (argumentGetArgNo_ ptr)

#include "Helper.h"

TYPE(Value)
TYPE_LEAF(Argument)
SUBTYPE(Value,Argument)
TYPE_LEAF(InlineAsm)
SUBTYPE(Value,InlineAsm)
TYPE_LEAF(MDNode)
SUBTYPE(Value,MDNode)
TYPE_LEAF(MDString)
SUBTYPE(Value,MDString)
TYPE(PseudoSourceValue)
SUBTYPE(Value,PseudoSourceValue)
TYPE_LEAF(FixedStackPseudoSourceValue)
SUBTYPE2(Value,PseudoSourceValue,FixedStackPseudoSourceValue)

class GetType value where
  type TypeOfValue value
  getType :: Ptr value -> IO (Ptr (TypeOfValue value))

GETTYPE(Value)
GETTYPE(Argument)
GETTYPE(InlineAsm)
GETTYPE(MDNode)
GETTYPE(MDString)
GETTYPE(PseudoSourceValue)
GETTYPE(FixedStackPseudoSourceValue)

deleteValue :: ValueC t => Ptr t -> IO ()
deleteValue = deleteValue_

valueDump :: ValueC t => Ptr t -> IO ()
valueDump = valueDump_

valueGetType :: ValueC t => Ptr t -> IO (Ptr Type)
valueGetType = valueGetType_

hasName :: ValueC t => Ptr t -> IO Bool
hasName = hasName_

getName :: ValueC t => Ptr t -> IO (Ptr StringRef)
getName = getName_

getNameString :: ValueC t => Ptr t -> IO String
getNameString ptr = do
  str <- getName ptr
  res <- stringRefData str
  deleteStringRef str
  return res