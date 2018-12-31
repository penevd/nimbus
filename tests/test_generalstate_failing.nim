# Nimbus
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# XXX: when all but a relative few dozen, say, GeneralStateTests run, remove this,
# but for now, this enables some CI use before that to prevent regressions. In the
# separate file here because it would otherwise just distract. Could use all sorts
# of O(1) or O(log n) lookup structures, or be more careful to only initialize the
# table once, but notion's that it should shrink reasonable quickly and disappear,
# being mostly used for short-term regression prevention.
func allowedFailingGeneralStateTest*(folder, name: string): bool =
  let allowedFailingGeneralStateTests = @[
    "ContractCreationSpam.json",
    "CrashingTransaction.json",
    "callcall_00.json",
    "callcode_checkPC.json",
    "callcodecallcode_11_OOGE.json",
    "callcallcallcode_001.json",
    "callcallcallcode_001_OOGE.json",
    "callcallcallcode_001_OOGMAfter.json",
    "callcallcallcode_ABCB_RECURSIVE.json",
    "callcallcodecall_010_OOGMAfter.json",
    "callcallcodecall_ABCB_RECURSIVE.json",
    "callcallcodecallcode_ABCB_RECURSIVE.json",
    "callcodecallcall_100_OOGMAfter.json",
    "callcodecallcall_ABCB_RECURSIVE.json",
    "callcodecallcallcode_101_OOGMAfter.json",
    "callcodecallcallcode_ABCB_RECURSIVE.json",
    "callcodecallcodecall_110_OOGMAfter.json",
    "callcodecallcodecall_ABCB_RECURSIVE.json",
    "callcodecallcodecallcode_111_OOGMAfter.json",
    "callcodecallcodecallcode_ABCB_RECURSIVE.json",
    "callcallcallcode_001.json",
    "callcallcallcode_001_OOGE.json",
    "callcallcallcode_001_OOGMAfter.json",
    "callcallcallcode_001_OOGMBefore.json",
    "callcallcallcode_001_SuicideEnd.json",
    "callcallcallcode_001_SuicideMiddle.json",
    "callcallcallcode_ABCB_RECURSIVE.json",
    "callcallcode_01.json",
    "callcallcode_01_OOGE.json",
    "callcallcode_01_SuicideEnd.json",
    "callcallcodecall_010.json",
    "callcallcodecall_010_OOGE.json",
    "callcallcodecall_010_OOGMAfter.json",
    "callcallcodecall_010_OOGMBefore.json",
    "callcallcodecall_010_SuicideEnd.json",
    "callcallcodecall_010_SuicideMiddle.json",
    "callcallcodecall_ABCB_RECURSIVE.json",
    "callcallcodecallcode_011.json",
    "callcallcodecallcode_011_OOGE.json",
    "callcallcodecallcode_011_OOGMAfter.json",
    "callcallcodecallcode_011_OOGMBefore.json",
    "callcallcodecallcode_011_SuicideEnd.json",
    "callcallcodecallcode_011_SuicideMiddle.json",
    "callcallcodecallcode_ABCB_RECURSIVE.json",
    "callcodecall_10.json",
    "callcodecall_10_OOGE.json",
    "callcodecall_10_SuicideEnd.json",
    "callcodecallcall_100.json",
    "callcodecallcall_100_OOGE.json",
    "callcodecallcall_100_OOGMAfter.json",
    "callcodecallcall_100_OOGMBefore.json",
    "callcodecallcall_100_SuicideEnd.json",
    "callcodecallcall_100_SuicideMiddle.json",
    "callcodecallcall_ABCB_RECURSIVE.json",
    "callcodecallcallcode_101.json",
    "callcodecallcallcode_101_OOGE.json",
    "callcodecallcallcode_101_OOGMAfter.json",
    "callcodecallcallcode_101_OOGMBefore.json",
    "callcodecallcallcode_101_SuicideEnd.json",
    "callcodecallcallcode_101_SuicideMiddle.json",
    "callcodecallcallcode_ABCB_RECURSIVE.json",
    "callcodecallcode_11.json",
    "callcodecallcode_11_OOGE.json",
    "callcodecallcode_11_SuicideEnd.json",
    "callcodecallcodecall_110.json",
    "callcodecallcodecall_110_OOGE.json",
    "callcodecallcodecall_110_OOGMAfter.json",
    "callcodecallcodecall_110_OOGMBefore.json",
    "callcodecallcodecall_110_SuicideEnd.json",
    "callcodecallcodecall_110_SuicideMiddle.json",
    "callcodecallcodecall_ABCB_RECURSIVE.json",
    "callcodecallcodecallcode_111.json",
    "callcodecallcodecallcode_111_OOGE.json",
    "callcodecallcodecallcode_111_OOGMAfter.json",
    "callcodecallcodecallcode_111_OOGMBefore.json",
    "callcodecallcodecallcode_111_SuicideEnd.json",
    "callcodecallcodecallcode_111_SuicideMiddle.json",
    "callcodecallcodecallcode_ABCB_RECURSIVE.json",
    "Call1024PreCalls.json",
    "Callcode1024BalanceTooLow.json",
    "callcallcall_000_OOGMAfter.json",
    "callcallcallcode_001_OOGMAfter_1.json",
    "callcallcallcode_001_OOGMAfter_2.json",
    "callcallcallcode_001_OOGMAfter_3.json",
    "callcallcodecall_010_OOGMAfter_1.json",
    "callcallcodecall_010_OOGMAfter_2.json",
    "callcallcodecall_010_OOGMAfter_3.json",
    "callcallcodecallcode_011_OOGMAfter_1.json",
    "callcallcodecallcode_011_OOGMAfter_2.json",
    "callcodecallcall_100_OOGMAfter_2.json",
    "callcodecallcall_100_OOGMAfter_3.json",
    "callcodecallcallcode_101_OOGMAfter_1.json",
    "callcodecallcallcode_101_OOGMAfter_2.json",
    "callcodecallcallcode_101_OOGMAfter_3.json",
    "callcodecallcodecall_110_OOGMAfter_1.json",
    "callcodecallcodecall_110_OOGMAfter_2.json",
    "callcodecallcodecall_110_OOGMAfter_3.json",
    "callcodecallcodecallcode_111_OOGMAfter.json",
    "callcodecallcodecallcode_111_OOGMAfter_1.json",
    "callcodecallcodecallcode_111_OOGMAfter_2.json",
    "callcodecallcodecallcode_111_OOGMAfter_3.json",
    "createInitFail_OOGduringInit.json",
    "CREATE_AcreateB_BSuicide_BStore.json",
    "CREATE_ContractSuicideDuringInit.json",
    "CREATE_ContractSuicideDuringInit_ThenStoreThenReturn.json",
    "CREATE_ContractSuicideDuringInit_WithValue.json",
    "CREATE_ContractSuicideDuringInit_WithValueToItself.json",
    "CREATE_EContractCreateEContractInInit_Tr.json",
    "CREATE_EContractCreateNEContractInInitOOG_Tr.json",
    "CREATE_EContractCreateNEContractInInit_Tr.json",
    "CREATE_EContract_ThenCALLToNonExistentAcc.json",
    "CREATE_EmptyContract.json",
    "CREATE_EmptyContractAndCallIt_0wei.json",
    "CREATE_EmptyContractAndCallIt_1wei.json",
    "CREATE_EmptyContractWithBalance.json",
    "CREATE_EmptyContractWithStorage.json",
    "CREATE_EmptyContractWithStorageAndCallIt_0wei.json",
    "CREATE_EmptyContractWithStorageAndCallIt_1wei.json",
    "CREATE_empty000CreateinInitCode_Transaction.json",
    "CreateCollisionToEmpty.json",
    "TransactionCollisionToEmptyButCode.json",
    "TransactionCollisionToEmptyButNonce.json",
    "Call1024OOG.json",
    "Call1024PreCalls.json",
    "CallLoseGasOOG.json",
    "CallRecursiveBombPreCall.json",
    "CallcodeLoseGasOOG.json",
    "Delegatecall1024.json",
    "Delegatecall1024OOG.json",
    "callOutput1.json",
    "callOutput2.json",
    "callOutput3.json",
    "callOutput3Fail.json",
    "callOutput3partial.json",
    "callOutput3partialFail.json",
    "callcodeOutput1.json",
    "callcodeOutput2.json",
    "callcodeOutput3.json",
    "callcodeOutput3Fail.json",
    "callcodeOutput3partial.json",
    "callcodeOutput3partialFail.json",
    "deleagateCallAfterValueTransfer.json",
    "delegatecallBasic.json",
    "delegatecallEmptycontract.json",
    "delegatecallInInitcodeToEmptyContract.json",
    "delegatecallInInitcodeToExistingContract.json",
    "delegatecallOOGinCall.json",
    "delegatecallSenderCheck.json",
    "delegatecallValueCheck.json",
    "delegatecodeDynamicCode.json",
    "delegatecodeDynamicCode2SelfCall.json",
    "NewGasPriceForCodes.json",
    "RawCallCodeGas.json",
    "RawCallCodeGasMemory.json",
    "RawCallCodeGasValueTransfer.json",
    "RawCallCodeGasValueTransferMemory.json",
    "RawCallGas.json",
    "RawCallGasValueTransfer.json",
    "RawCallGasValueTransferMemory.json",
    "RawCallMemoryGas.json",
    "RawCreateFailGasValueTransfer2.json",
    "RawCreateGas.json",
    "RawCreateGasMemory.json",
    "RawCreateGasValueTransfer.json",
    "RawCreateGasValueTransferMemory.json",
    "RawDelegateCallGas.json",
    "RawDelegateCallGasMemory.json",
    "contractCreationOOGdontLeaveEmptyContract.json",
    "createContractViaContract.json",
    "createContractViaContractOOGInitCode.json",
    "createContractViaTransactionCost53000.json",
    "CallContractToCreateContractAndCallItOOG.json",
    "CallContractToCreateContractNoCash.json",
    "CallContractToCreateContractOOG.json",
    "CallContractToCreateContractOOGBonusGas.json",
    "CallContractToCreateContractWhichWouldCreateContractIfCalled.json",
    "CallContractToCreateContractWhichWouldCreateContractInInitCode.json",
    "CallRecursiveContract.json",
    "CallTheContractToCreateEmptyContract.json",
    "OutOfGasContractCreation.json",
    "OutOfGasPrefundedContractCreation.json",
    "ReturnTest.json",
    "ReturnTest2.json",
    "TransactionCreateAutoSuicideContract.json",
    "log0_emptyMem.json",
    "log0_logMemStartTooHigh.json",
    "log0_logMemsizeTooHigh.json",
    "log0_logMemsizeZero.json",
    "log0_nonEmptyMem.json",
    "log0_nonEmptyMem_logMemSize1.json",
    "log0_nonEmptyMem_logMemSize1_logMemStart31.json",
    "log1_Caller.json",
    "log1_MaxTopic.json",
    "log1_emptyMem.json",
    "log1_logMemStartTooHigh.json",
    "log1_logMemsizeTooHigh.json",
    "log1_logMemsizeZero.json",
    "log1_nonEmptyMem.json",
    "log1_nonEmptyMem_logMemSize1.json",
    "log1_nonEmptyMem_logMemSize1_logMemStart31.json",
    "log2_Caller.json",
    "log2_MaxTopic.json",
    "log2_emptyMem.json",
    "log2_logMemStartTooHigh.json",
    "log2_logMemsizeTooHigh.json",
    "log2_logMemsizeZero.json",
    "log2_nonEmptyMem.json",
    "log2_nonEmptyMem_logMemSize1.json",
    "log2_nonEmptyMem_logMemSize1_logMemStart31.json",
    "log3_Caller.json",
    "log3_MaxTopic.json",
    "log3_PC.json",
    "log3_emptyMem.json",
    "log3_logMemStartTooHigh.json",
    "log3_logMemsizeTooHigh.json",
    "log3_logMemsizeZero.json",
    "log3_nonEmptyMem.json",
    "log3_nonEmptyMem_logMemSize1.json",
    "log3_nonEmptyMem_logMemSize1_logMemStart31.json",
    "log4_Caller.json",
    "log4_MaxTopic.json",
    "log4_PC.json",
    "log4_emptyMem.json",
    "log4_logMemStartTooHigh.json",
    "log4_logMemsizeTooHigh.json",
    "log4_logMemsizeZero.json",
    "log4_nonEmptyMem.json",
    "log4_nonEmptyMem_logMemSize1.json",
    "log4_nonEmptyMem_logMemSize1_logMemStart31.json",
    "logInOOG_Call.json",
    "CallAskMoreGasOnDepth2ThenTransactionHasWithMemExpandingCalls.json",
    "CreateAndGasInsideCreateWithMemExpandingCalls.json",
    "NewGasPriceForCodesWithMemExpandingCalls.json",
    "callDataCopyOffset.json",
    "codeCopyOffset.json",
    "NonZeroValue_CALL.json",
    "NonZeroValue_CALLCODE.json",
    "NonZeroValue_CALLCODE_ToEmpty.json",
    "NonZeroValue_CALLCODE_ToNonNonZeroBalance.json",
    "NonZeroValue_CALLCODE_ToOneStorageKey.json",
    "NonZeroValue_CALL_ToEmpty.json",
    "NonZeroValue_CALL_ToNonNonZeroBalance.json",
    "NonZeroValue_CALL_ToOneStorageKey.json",
    "CALLCODEEcrecover0.json",
    "CALLCODEEcrecover0_0input.json",
    "CALLCODEEcrecover0_Gas2999.json",
    "CALLCODEEcrecover0_NoGas.json",
    "CALLCODEEcrecover0_completeReturnValue.json",
    "CALLCODEEcrecover0_gas3000.json",
    "CALLCODEEcrecover0_overlappingInputOutput.json",
    "CALLCODEEcrecover1.json",
    "CALLCODEEcrecover2.json",
    "CALLCODEEcrecover3.json",
    "CALLCODEEcrecover80.json",
    "CALLCODEEcrecoverH_prefixed0.json",
    "CALLCODEEcrecoverR_prefixed0.json",
    "CALLCODEEcrecoverS_prefixed0.json",
    "CALLCODEEcrecoverV_prefixed0.json",
    "CALLCODEEcrecoverV_prefixedf0.json",
    "CALLCODEIdentitiy_0.json",
    "CALLCODEIdentitiy_1.json",
    "CALLCODEIdentity_1_nonzeroValue.json",
    "CALLCODEIdentity_2.json",
    "CALLCODEIdentity_3.json",
    "CALLCODEIdentity_4.json",
    "CALLCODEIdentity_4_gas17.json",
    "CALLCODEIdentity_4_gas18.json",
    "CALLCODEIdentity_5.json",
    "CALLCODERipemd160_0.json",
    "CALLCODERipemd160_1.json",
    "CALLCODERipemd160_2.json",
    "CALLCODERipemd160_3.json",
    "CALLCODERipemd160_3_postfixed0.json",
    "CALLCODERipemd160_3_prefixed0.json",
    "CALLCODERipemd160_4.json",
    "CALLCODERipemd160_4_gas719.json",
    "CALLCODERipemd160_5.json",
    "CALLCODESha256_0.json",
    "CALLCODESha256_1.json",
    "CALLCODESha256_1_nonzeroValue.json",
    "CALLCODESha256_2.json",
    "CALLCODESha256_3.json",
    "CALLCODESha256_3_postfix0.json",
    "CALLCODESha256_3_prefix0.json",
    "CALLCODESha256_4.json",
    "CALLCODESha256_4_gas99.json",
    "CALLCODESha256_5.json",
    "CallEcrecover0.json",
    "CallEcrecover0_0input.json",
    "CallEcrecover0_Gas2999.json",
    "CallEcrecover0_NoGas.json",
    "CallEcrecover0_completeReturnValue.json",
    "CallEcrecover0_gas3000.json",
    "CallEcrecover0_overlappingInputOutput.json",
    "CallEcrecover1.json",
    "CallEcrecover2.json",
    "CallEcrecover3.json",
    "CallEcrecover80.json",
    "CallEcrecoverCheckLength.json",
    "CallEcrecoverCheckLengthWrongV.json",
    "CallEcrecoverH_prefixed0.json",
    "CallEcrecoverR_prefixed0.json",
    "CallEcrecoverS_prefixed0.json",
    "CallEcrecoverV_prefixed0.json",
    "CallIdentitiy_0.json",
    "CallIdentitiy_1.json",
    "CallIdentity_1_nonzeroValue.json",
    "CallIdentity_2.json",
    "CallIdentity_3.json",
    "CallIdentity_4.json",
    "CallIdentity_4_gas17.json",
    "CallIdentity_4_gas18.json",
    "CallIdentity_5.json",
    "CallRipemd160_0.json",
    "CallRipemd160_1.json",
    "CallRipemd160_2.json",
    "CallRipemd160_3.json",
    "CallRipemd160_3_postfixed0.json",
    "CallRipemd160_3_prefixed0.json",
    "CallRipemd160_4.json",
    "CallRipemd160_4_gas719.json",
    "CallRipemd160_5.json",
    "CallSha256_0.json",
    "CallSha256_1.json",
    "CallSha256_1_nonzeroValue.json",
    "CallSha256_2.json",
    "CallSha256_3.json",
    "CallSha256_3_postfix0.json",
    "CallSha256_3_prefix0.json",
    "CallSha256_4.json",
    "CallSha256_4_gas99.json",
    "CallSha256_5.json",
    "randomStatetest100.json",
    "randomStatetest138.json",
    "randomStatetest14.json",
    "randomStatetest146.json",
    "randomStatetest150.json",
    "randomStatetest154.json",
    "randomStatetest159.json",
    "randomStatetest178.json",
    "randomStatetest184.json",
    "randomStatetest205.json",
    "randomStatetest248.json",
    "randomStatetest306.json",
    "randomStatetest307.json",
    "randomStatetest368.json",
    "randomStatetest48.json",
    "randomStatetest85.json",
    "randomStatetest417.json",
    "randomStatetest458.json",
    "randomStatetest467.json",
    "randomStatetest498.json",
    "randomStatetest554.json",
    "randomStatetest579.json",
    "randomStatetest618.json",
    "randomStatetest627.json",
    "randomStatetest632.json",
    "randomStatetest636.json",
    "randomStatetest639.json",
    "randomStatetest642.json",
    "randomStatetest643.json",
    "randomStatetest644.json",
    "randomStatetest645.json",
    "randomStatetest646.json",
    "recursiveCreate.json",
    "recursiveCreateReturnValue.json",
    "refundSuicide50procentCap.json",
    "refund_CallA.json",
    "refund_CallA_notEnoughGasInCall.json",
    "refund_CallToSuicideNoStorage.json",
    "refund_CallToSuicideStorage.json",
    "refund_CallToSuicideTwice.json",
    "refund_multimpleSuicide.json",
    "refund_singleSuicide.json",
    "LoopCallsThenRevert.json",
    "NashatyrevSuicideRevert.json",
    "RevertDepthCreateAddressCollision.json",
    "RevertDepthCreateOOG.json",
    "RevertOpcodeCalls.json",
    "RevertOpcodeCreate.json",
    "RevertOpcodeDirectCall.json",
    "RevertOpcodeInCallsOnNonEmptyReturnData.json",
    "RevertOpcodeInInit.json",
    "RevertOpcodeMultipleSubCalls.json",
    "RevertOpcodeReturn.json",
    "RevertOpcodeWithBigOutputInInit.json",
    "RevertPrefound.json",
    "RevertPrefoundCall.json",
    "RevertPrefoundEmpty.json",
    "RevertPrefoundEmptyCall.json",
    "RevertPrefoundEmptyOOG.json",
    "RevertPrefoundOOG.json",
    "RevertRemoteSubCallStorageOOG.json",
    "RevertRemoteSubCallStorageOOG2.json",
    "TouchToEmptyAccountRevert2.json",
    "TouchToEmptyAccountRevert3.json",
    "CallLowLevelCreatesSolidity.json",
    "ContractInheritance.json",
    "CreateContractFromMethod.json",
    "RecursiveCreateContracts.json",
    "RecursiveCreateContractsCreate4Contracts.json",
    "TestContractInteraction.json",
    "TestContractSuicide.json",
    "TestCryptographicFunctions.json",
    "JUMPDEST_Attack.json",
    "JUMPDEST_AttackwithJump.json",
    "tx_e1c174e2.json",
    "ABAcalls0.json",
    "ABAcalls1.json",
    "ABAcalls2.json",
    "ABAcalls3.json",
    "ABAcallsSuicide0.json",
    "ABAcallsSuicide1.json",
    "Call10.json",
    "CallRecursiveBomb0.json",
    "CallRecursiveBomb0_OOG_atMaxCallDepth.json",
    "CallRecursiveBomb1.json",
    "CallRecursiveBomb2.json",
    "CallRecursiveBombLog.json",
    "CallRecursiveBombLog2.json",
    "CallToNameRegistrator0.json",
    "CallToNameRegistratorAddressTooBigLeft.json",
    "CallToNameRegistratorAddressTooBigRight.json",
    "CallToNameRegistratorNotMuchMemory0.json",
    "CallToNameRegistratorNotMuchMemory1.json",
    "CallToNameRegistratorOutOfGas.json",
    "CallToNameRegistratorZeorSizeMemExpansion.json",
    "CallToReturn1.json",
    "CalltoReturn2.json",
    "CreateHashCollision.json",
    "PostToReturn1.json",
    "callcodeTo0.json",
    "callcodeToNameRegistrator0.json",
    "callcodeToNameRegistratorAddresTooBigLeft.json",
    "callcodeToNameRegistratorAddresTooBigRight.json",
    "callcodeToNameRegistratorZeroMemExpanion.json",
    "callcodeToReturn1.json",
    "createNameRegistrator.json",
    "createNameRegistratorOutOfMemoryBonds0.json",
    "createNameRegistratorValueTooHigh.json",
    "createNameRegistratorZeroMem.json",
    "createNameRegistratorZeroMem2.json",
    "createNameRegistratorZeroMemExpansion.json",
    "createWithInvalidOpcode.json",
    "suicideCoinbase.json",
    "suicideSendEtherPostDeath.json",
    "testRandomTest.json",
    "CreateMessageSuccess.json",
    "EmptyTransaction2.json",
    "EmptyTransaction3.json",
    "InternalCallHittingGasLimitSuccess.json",
    "InternlCallStoreClearsOOG.json",
    "InternlCallStoreClearsSucces.json",
    "Opcodes_TransactionInit.json",
    "StoreClearsAndInternlCallStoreClearsOOG.json",
    "StoreClearsAndInternlCallStoreClearsSuccess.json",
    "StoreGasOnCreate.json",
    "SuicidesAndInternlCallSuicidesBonusGasAtCall.json",
    "SuicidesAndInternlCallSuicidesBonusGasAtCallFailed.json",
    "SuicidesAndInternlCallSuicidesSuccess.json",
    "SuicidesMixingCoinbase.json",
    "TransactionFromCoinbaseHittingBlockGasLimit1.json",
    "TransactionSendingToEmpty.json",
    "createNameRegistratorPerTxsNotEnoughGasAfter.json",
    "createNameRegistratorPerTxsNotEnoughGasAt.json",
    "createNameRegistratorPerTxsNotEnoughGasBefore.json",
    "delegatecallAfterTransition.json",
    "delegatecallAtTransition.json",
    "delegatecallBeforeTransition.json",
    "walletConfirm.json",
    "ZeroValue_CALL.json",
    "pairingTest.json",
    "pointAdd.json",
    "pointAddTrunc.json",
    "pointMulAdd.json",
    "pointMulAdd2.json",
    "Call1024BalanceTooLow.json",
    # 2018-12-07:
    "delegatecallAndOOGatTxLevel.json",
    "delegatecallInInitcodeToExistingContractOOG.json",
    "RawCallCodeGasAsk.json",
    "RawCallCodeGasMemoryAsk.json",
    "RawCallGasAsk.json",
    "RawCallMemoryGasAsk.json",
    "RawDelegateCallGasAsk.json",
    "RawDelegateCallGasMemoryAsk.json",
    "CallAndCallcodeConsumeMoreGasThenTransactionHasWithMemExpandingCalls.json",
    "CallGoesOOGOnSecondLevel2WithMemExpandingCalls.json",
    "CallGoesOOGOnSecondLevelWithMemExpandingCalls.json",
    "DelegateCallOnEIPWithMemExpandingCalls.json",
    "ExecuteCallThatAskMoreGasThenTransactionHasWithMemExpandingCalls.json",
    "RETURN_Bounds.json",
    "NonZeroValue_DELEGATECALL.json",
    "NonZeroValue_DELEGATECALL_ToEmpty.json",
    "NonZeroValue_DELEGATECALL_ToNonNonZeroBalance.json",
    "NonZeroValue_DELEGATECALL_ToOneStorageKey.json",
    "call_outsize_then_create_successful_then_returndatasize.json",
    "call_then_create_successful_then_returndatasize.json",
    "create_callprecompile_returndatasize.json",
    "returndatacopy_0_0_following_successful_create.json",
    "returndatacopy_following_create.json",
    "returndatacopy_following_revert_in_create.json",
    "returndatacopy_following_successful_create.json",
    "returndatasize_following_successful_create.json",
    "LoopCallsDepthThenRevert.json",
    "LoopDelegateCallsDepthThenRevert.json",
    "RevertDepth2.json",
    "RevertOpcodeInCreateReturns.json",
    "CallRecursiveBomb3.json",
    "doubleSelfdestructTest.json",
    "doubleSelfdestructTest2.json",
    "ZeroValue_CALLCODE.json",
    "ZeroValue_CALLCODE_ToEmpty.json",
    "ZeroValue_CALLCODE_ToNonZeroBalance.json",
    "ZeroValue_CALLCODE_ToOneStorageKey.json",
    "ZeroValue_CALL_ToEmpty.json",
    "ZeroValue_CALL_ToNonZeroBalance.json",
    "ZeroValue_CALL_ToOneStorageKey.json",
    "ZeroValue_DELEGATECALL.json",
    "ZeroValue_DELEGATECALL_ToEmpty.json",
    "ZeroValue_DELEGATECALL_ToNonZeroBalance.json",
    "ZeroValue_DELEGATECALL_ToOneStorageKey.json",
  ]
  result = name in allowedFailingGeneralStateTests

