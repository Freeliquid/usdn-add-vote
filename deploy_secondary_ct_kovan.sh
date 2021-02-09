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


MCD_DEPLOY="0x3a3C4427F9e54FC6eba965f6146Cf9Ff8d31795F"

USDNDAI_GEM="0xA778bc72bF31953555b6E094503792BA66cc8d72"
USDNUSDC_GEM="0x30DaBEd27aF8Bdeec71D8b0CeEa0f6C954E1E060"



VAT=$(seth call "$MCD_DEPLOY" 'vat()(address)')
FLIP_FAB=$(seth call "$MCD_DEPLOY" 'flipFab()(address)')



echo VAT=$VAT
echo FLIP_FAB=$FLIP_FAB


ILK_USDNDAI="USDNDAI-A"
ILK32_USDNDAI=$(seth --to-bytes32 "$(seth --from-ascii "$ILK_USDNDAI")")
echo ILK32_USDNDAI=$ILK32_USDNDAI
seth send "$FLIP_FAB" 'newFlip(address,bytes32)(address)' "$VAT" "$ILK32_USDNDAI"

ILK_USDNUSDC="USDNUSDC-A"
ILK32_USDNUSDC=$(seth --to-bytes32 "$(seth --from-ascii "$ILK_USDNUSDC")")
echo ILK32_USDNUSDC=$ILK32_USDNUSDC
seth send "$FLIP_FAB" 'newFlip(address,bytes32)(address)' "$VAT" "$ILK32_USDNUSDC"

JOIN_USDNUSDC=$(seth send --create out/GemJoin.bin 'GemJoin(address,bytes32,address)' "$VAT" "$ILK32_USDNUSDC" "$USDNUSDC_GEM")
JOIN_USDNDAI=$(seth send --create out/GemJoin.bin 'GemJoin(address,bytes32,address)' "$VAT" "$ILK32_USDNDAI" "$USDNDAI_GEM")

echo JOIN_USDNUSDC=$JOIN_USDNUSDC
echo JOIN_USDNDAI=$JOIN_USDNDAI

date