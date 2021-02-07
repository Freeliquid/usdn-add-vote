#!/usr/bin/env bash
date
export BIN_DIR='bin'
export LIB_DIR='lib'
export LIBEXEC_DIR='libexec'
export CONFIG_DIR='config'
export DAPP_LIB='contracts'
export DAPP_SKIP_BUILD='yes'
export ETH_FROM=0xaaCE3a65C179667f53B01fB3F28Db10a0dce9629
export ETH_GAS_PRICE=65000000000
export ETH_GAS=7000000
export ETH_PASSWORD=../dss-deploy-scripts/password
export ETH_KEYSTORE=../dss-deploy-scripts/keys/keystore
export SETH_CHAIN=kovan
export ETH_RPC_URL=https://kovan.infura.io/v3/58073b4a32df4105906c702f167b91d2
# seth ls

export SETUP_LOG=$(seth send --create out/SetupChainlog.bin 'SetupChainlog()')
export CHANGE_LOG=$(seth send --create out/ChainLog.bin 'ChainLog()')

echo SETUP_LOG $SETUP_LOG
echo CHANGE_LOG $CHANGE_LOG

seth send "$CHANGE_LOG" 'rely(address)' "$SETUP_LOG"
seth send "$SETUP_LOG" 'setup(address)' "$CHANGE_LOG"

date