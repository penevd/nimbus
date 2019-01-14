import
  json, os, stint, eth_trie/db, byteutils, eth_common,
  ../nimbus/db/[db_chain], chronicles, ../nimbus/vm_state,
  ../nimbus/p2p/executor, premixcore, prestate, ../nimbus/tracer

proc prepareBlockEnv(node: JsonNode, memoryDB: TrieDatabaseRef) =
  let state = node["state"]

  for k, v in state:
    let key = hexToSeqByte(k)
    let value = hexToSeqByte(v.getStr())
    memoryDB.put(key, value)

proc executeBlock(blockEnv: JsonNode, memoryDB: TrieDatabaseRef, blockNumber: Uint256) =
  let
    parentNumber = blockNumber - 1
    chainDB = newBaseChainDB(memoryDB, false)
    parent = chainDB.getBlockHeader(parentNumber)
    header = chainDB.getBlockHeader(blockNumber)
    body   = chainDB.getBlockBody(header.blockHash)

  let
    vmState = newBaseVMState(parent, chainDB)
    validationResult = processBlock(chainDB, parent, header, body, vmState)

  if validationResult != ValidationResult.OK:
    error "block validation error", validationResult
  else:
    info "block validation success", validationResult, blockNumber

  dumpDebuggingMetaData(chainDB, header, body, vmState.receipts, false)
  let
    fileName = "debug" & $blockNumber & ".json"
    nimbus   = json.parseFile(fileName)
    geth     = blockEnv["geth"]

  processNimbusData(nimbus)

  # premix data goes to report page
  generatePremixData(nimbus, geth)

  # prestate data goes to debug tool and contains data
  # needed to execute single block
  generatePrestate(nimbus, geth, blockNumber, parent, header, body)

proc main() =
  if paramCount() == 0:
    echo "usage: debug blockxxx.json"
    quit(QuitFailure)

  let
    blockEnv = json.parseFile(paramStr(1))
    memoryDB = newMemoryDB()
    blockNumber = UInt256.fromHex(blockEnv["blockNumber"].getStr())

  prepareBlockEnv(blockEnv, memoryDB)
  executeBlock(blockEnv, memoryDB, blockNumber)

main()
