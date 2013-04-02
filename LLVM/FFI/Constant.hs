module LLVM.FFI.Constant 
       (Constant(),ConstantC(),
        constantGetAggregateElement,
        BlockAddress(),
        ConstantAggregateZero(),
        ConstantArray(),
        ConstantDataSequential(),
        ConstantDataArray(),
        ConstantDataVector(),
        ConstantExpr(),
        --constantExprGetAsInstruction,
        {-BinaryConstantExpr(),
        CompareConstantExpr(),
        ExtractElementConstantExpr(),
        ExtractValueConstantExpr(),
        GetElementPtrConstantExpr(),
        InsertElementConstantExpr(),
        SelectConstantExpr(),
        ShuffleVectorConstantExpr(),
        UnaryConstantExpr(),-}
        ConstantFP(),
        constantFPGetValueAPF,
        ConstantInt(),
        constantIntGetValue,
        ConstantPointerNull(),
        ConstantStruct(),
        ConstantVector(),
        GlobalValue(),
        GlobalValueC(),
        GlobalAlias(),
        GlobalVariable(),
        globalVariableIsConstant,
        globalVariableIsThreadLocal,
        globalVariableGetInitializer,
        UndefValue(),
#if HS_LLVM_VERSION > 301
        isNullValue,
        canTrap,
        isThreadDependent,
        isConstantUsed
#endif
       ) where

import LLVM.FFI.Interface
import LLVM.FFI.OOP
import LLVM.FFI.Value
import LLVM.FFI.User
import LLVM.FFI.Type
import LLVM.FFI.IPList

import Foreign
import Foreign.C

#include "Helper.h"

constantGetAggregateElement :: ConstantC t => Ptr t -> Integer -> IO (Ptr Constant)
constantGetAggregateElement ptr idx = constantGetAggregateElement_ ptr (fromInteger idx)

TYPE(Constant)
SUBTYPE2(Value,User,Constant)
TYPE_LEAF(BlockAddress)
SUBTYPE3(Value,User,Constant,BlockAddress)
TYPE_LEAF(ConstantAggregateZero)
SUBTYPE3(Value,User,Constant,ConstantAggregateZero)
TYPE_LEAF(ConstantArray)
SUBTYPE3(Value,User,Constant,ConstantArray)
TYPE(ConstantDataSequential)
SUBTYPE3(Value,User,Constant,ConstantDataSequential)
TYPE_LEAF(ConstantDataArray)
SUBTYPE4(Value,User,Constant,ConstantDataSequential,ConstantDataArray)
TYPE_LEAF(ConstantDataVector)
SUBTYPE4(Value,User,Constant,ConstantDataSequential,ConstantDataVector)
TYPE(ConstantExpr)
SUBTYPE3(Value,User,Constant,ConstantExpr)
{-TYPE_LEAF(BinaryConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,BinaryConstantExpr)
TYPE_LEAF(CompareConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,CompareConstantExpr)
TYPE_LEAF(ExtractElementConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,ExtractElementConstantExpr)
TYPE_LEAF(ExtractValueConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,ExtractValueConstantExpr)
TYPE_LEAF(GetElementPtrConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,GetElementPtrConstantExpr)
TYPE_LEAF(InsertElementConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,InsertElementConstantExpr)
TYPE_LEAF(SelectConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,SelectConstantExpr)
TYPE_LEAF(ShuffleVectorConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,ShuffleVectorConstantExpr)
TYPE_LEAF(UnaryConstantExpr)
SUBTYPE4(Value,User,Constant,ConstantExpr,UnaryConstantExpr)-}
TYPE_LEAF(ConstantFP)
SUBTYPE3(Value,User,Constant,ConstantFP)
TYPE_LEAF(ConstantInt)
SUBTYPE3(Value,User,Constant,ConstantInt)
TYPE_LEAF(ConstantPointerNull)
SUBTYPE3(Value,User,Constant,ConstantPointerNull)
TYPE_LEAF(ConstantStruct)
SUBTYPE3(Value,User,Constant,ConstantStruct)
TYPE_LEAF(ConstantVector)
SUBTYPE3(Value,User,Constant,ConstantVector)
TYPE(GlobalValue)
SUBTYPE3(Value,User,Constant,GlobalValue)
TYPE_LEAF(Function)
SUBTYPE4(Value,User,Constant,GlobalValue,Function)
TYPE_LEAF(GlobalAlias)
SUBTYPE4(Value,User,Constant,GlobalValue,GlobalAlias)
TYPE_LEAF(GlobalVariable)
SUBTYPE4(Value,User,Constant,GlobalValue,GlobalVariable)
TYPE_LEAF(UndefValue)
SUBTYPE3(Value,User,Constant,UndefValue)

GETTYPE(Constant)
GETTYPE(BlockAddress)
GETTYPE(ConstantAggregateZero)

instance GetType ConstantArray where
  type TypeOfValue ConstantArray = ArrayType
  getType = constantArrayGetType

instance GetType ConstantDataSequential where
  type TypeOfValue ConstantDataSequential = SequentialType
  getType = constantDataSequentialGetType

instance GetType ConstantDataArray where
  type TypeOfValue ConstantDataArray = ArrayType
  getType = constantDataArrayGetType

instance GetType ConstantDataVector where
  type TypeOfValue ConstantDataVector = VectorType
  getType = constantDataVectorGetType

GETTYPE(ConstantExpr)
{-GETTYPE(BinaryConstantExpr)
GETTYPE(CompareConstantExpr)
GETTYPE(ExtractElementConstantExpr)
GETTYPE(ExtractValueConstantExpr)
GETTYPE(GetElementPtrConstantExpr)
GETTYPE(InsertElementConstantExpr)
GETTYPE(SelectConstantExpr)
GETTYPE(ShuffleVectorConstantExpr)
GETTYPE(UnaryConstantExpr)-}
GETTYPE(ConstantFP)

instance GetType ConstantInt where
  type TypeOfValue ConstantInt = IntegerType
  getType = constantIntGetType

instance GetType ConstantPointerNull where
  type TypeOfValue ConstantPointerNull = PointerType
  getType = constantPointerNullGetType

instance GetType ConstantStruct where
  type TypeOfValue ConstantStruct = StructType
  getType = constantStructGetType

instance GetType ConstantVector where
  type TypeOfValue ConstantVector = VectorType
  getType = constantVectorGetType

instance GetType GlobalValue where
  type TypeOfValue GlobalValue = PointerType
  getType = globalValueGetType

instance GetType Function where
  type TypeOfValue Function = PointerType
  getType = globalValueGetType

instance GetType GlobalAlias where
  type TypeOfValue GlobalAlias = PointerType
  getType = globalValueGetType

instance GetType GlobalVariable where
  type TypeOfValue GlobalVariable = PointerType
  getType = globalValueGetType

GETTYPE(UndefValue)

SPECIALIZE_IPLIST(GlobalVariable,capi)