module LLVM.FFI.Type
       ( -- * Types
         Type() 
        ,TypeC()
        ,typeGetContext
        ,isVoidType
        ,isHalfType
        ,isFloatType
        ,isDoubleType
        ,isX86_FP80Type
        ,isFP128Type
        ,isPPC_FP128Type
        ,isFloatingPointType
        ,isX86_MMXType
        ,isLabelType
        ,typeDump 
         -- ** Integer Type
        ,IntegerType()
        ,getBitWidth
        ,getIntegerType
         -- ** Function Type
        ,FunctionType()
        ,newFunctionType
        ,functionTypeIsVarArg
        ,functionTypeGetReturnType
        ,functionTypeGetNumParams
        ,functionTypeGetParamType
         -- ** Composite Types
        ,CompositeType()
        ,CompositeTypeC()
        ,compositeTypeGetTypeAtIndex
        ,compositeTypeIndexValid
         -- *** Struct Type
        ,StructType()
        ,newStructType
        ,structTypeIsPacked
        ,structTypeHasName
        ,structTypeGetName
        ,structTypeGetNumElements
        ,structTypeGetElementType
         -- *** Sequential Types
        ,SequentialType()
        ,SequentialTypeC()
        ,sequentialTypeGetElementType
         -- **** Array Type
        ,ArrayType()
        ,arrayTypeGetNumElements
         -- **** Pointer Type
        ,PointerType()
        ,pointerTypeGet
        ,pointerTypeGetAddressSpace
         -- **** Vector Type
        ,VectorType()
        ,vectorTypeGet
        ,vectorTypeGetNumElements
        ) where

import LLVM.FFI.OOP
import LLVM.FFI.Context
import LLVM.FFI.ArrayRef
import LLVM.FFI.Interface

import Foreign
import Foreign.C

#include "Helper.h"

TYPE(Type)
TYPE_LEAF(IntegerType)
SUBTYPE(Type,IntegerType)
TYPE_LEAF(FunctionType)
SUBTYPE(Type,FunctionType)
TYPE(CompositeType)
SUBTYPE(Type,CompositeType)
TYPE_LEAF(StructType)
SUBTYPE2(Type,CompositeType,StructType)
TYPE(SequentialType)
SUBTYPE2(Type,CompositeType,SequentialType)
TYPE_LEAF(ArrayType)
SUBTYPE3(Type,CompositeType,SequentialType,ArrayType)
TYPE_LEAF(PointerType)
SUBTYPE3(Type,CompositeType,SequentialType,PointerType)
TYPE_LEAF(VectorType)
SUBTYPE3(Type,CompositeType,SequentialType,VectorType)

SPECIALIZE_ARRAYREF(Type,capi)

typeDump :: TypeC t => Ptr t -> IO ()
typeDump = typeDump_

typeGetContext :: TypeC t => Ptr t -> IO (Ptr LLVMContext)
typeGetContext = typeGetContext_

getBitWidth :: Ptr IntegerType -> IO Integer
getBitWidth ptr = fmap fromIntegral (getBitWidth_ ptr)

getIntegerType :: Ptr LLVMContext -> Integer -> IO (Ptr IntegerType)
getIntegerType ctx bw = getIntegerType_ ctx (fromIntegral bw)

functionTypeGetNumParams :: Ptr FunctionType -> IO Integer
functionTypeGetNumParams ptr = fmap fromIntegral (functionTypeGetNumParams_ ptr)

functionTypeGetParamType :: Ptr FunctionType -> Integer -> IO (Ptr Type)
functionTypeGetParamType ptr i = functionTypeGetParamType_ ptr (fromIntegral i)

newFunctionType :: TypeC rtp => Ptr rtp -> Ptr (ArrayRef (Ptr Type)) -> Bool -> IO (Ptr FunctionType)
newFunctionType = newFunctionType_

isVoidType :: TypeC t => Ptr t -> Bool
isVoidType = isVoidTy_

isHalfType :: TypeC t => Ptr t -> Bool
isHalfType = isHalfTy_

isFloatType :: TypeC t => Ptr t -> Bool
isFloatType = isFloatTy_

isDoubleType :: TypeC t => Ptr t -> Bool
isDoubleType = isDoubleTy_

isX86_FP80Type :: TypeC t => Ptr t -> Bool
isX86_FP80Type = isX86_FP80Ty_

isFP128Type :: TypeC t => Ptr t -> Bool
isFP128Type = isFP128Ty_

isPPC_FP128Type :: TypeC t => Ptr t -> Bool
isPPC_FP128Type = isPPC_FP128Ty_

isFloatingPointType :: TypeC t => Ptr t -> Bool
isFloatingPointType = isFloatingPointTy_

isX86_MMXType :: TypeC t => Ptr t -> Bool
isX86_MMXType = isX86_MMXTy_

isLabelType :: TypeC t => Ptr t -> Bool
isLabelType = isLabelTy_

structTypeGetNumElements :: Ptr StructType -> IO Integer
structTypeGetNumElements ptr = fmap toInteger $ structTypeGetNumElements_ ptr

structTypeGetElementType :: Ptr StructType -> Integer -> IO (Ptr Type)
structTypeGetElementType ptr idx = structTypeGetElementType_ ptr (fromInteger idx)

pointerTypeGetAddressSpace :: Ptr PointerType -> IO Integer
pointerTypeGetAddressSpace ptr = fmap toInteger (pointerTypeGetAddressSpace_ ptr)

pointerTypeGet :: TypeC t => Ptr t -> Integer -> IO (Ptr PointerType)
pointerTypeGet ptr addr = pointerTypeGet_ ptr (fromInteger addr)

sequentialTypeGetElementType :: SequentialTypeC t => Ptr t -> IO (Ptr Type)
sequentialTypeGetElementType = sequentialTypeGetElementType_

arrayTypeGetNumElements :: Ptr ArrayType -> IO Integer
arrayTypeGetNumElements ptr = fmap toInteger $ arrayTypeGetNumElements_ ptr

compositeTypeGetTypeAtIndex :: CompositeTypeC t => Ptr t -> Integer -> IO (Ptr Type)
compositeTypeGetTypeAtIndex ptr idx = compositeTypeGetTypeAtIndex_ ptr (fromInteger idx)

compositeTypeIndexValid :: CompositeTypeC t => Ptr t -> Integer -> IO Bool
compositeTypeIndexValid ptr idx = compositeTypeIndexValid_ ptr (fromInteger idx)

vectorTypeGetNumElements :: Ptr VectorType -> IO Integer
vectorTypeGetNumElements ptr = fmap toInteger (vectorTypeGetNumElements_ ptr)

vectorTypeGet :: TypeC t => Ptr t -> Integer -> IO (Ptr VectorType)
vectorTypeGet tp num = vectorTypeGet_ tp (fromInteger num)