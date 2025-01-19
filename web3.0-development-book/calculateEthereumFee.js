//Ethereumのプロバイダーに接続し、現在のガス料金を取得し、EIP-1559のトランザクション手数料を計算する

// ① ethersライブラリをインポートする
const { ethers } = require("ethers");

// ② JsonRpcProviderを使い、Ethereumノードに接続するプロバイダを設定する
const provider = new ethers.providers.JsonRpcProvider("プロバイダーのエンドポイントURL");

// ③ ガス料金の計算を行う
async function calculateFee() {
    // 現在のガス料金データを取得する
    const feeData = await provider.getFeeData();
    // 基本ガス料金を取得する
    const lastBaseFeePerGas = feeData.lastBaseFeePerGas;
    // 最大ガス料金を取得する
    const maxFeePerGas = feeData.maxFeePerGas;
    // 最大優先度ガス料金を取得する（最大優先度ガス料金：トランザクションを迅速に処理してもらうためにマイナーに支払う追加の料金）
    const maxPriorityFeePerGas = feeData.maxPriorityFeePerGas;

    // ガス価格を計算する
    let gasPrice = null;
    // 基本ガス料金と最大ガス料金の合計が最大ガス料金を超える場合、ガス価格を最大ガス料金に設定する
    if((lastBaseFeePerGas + maxPriorityFeePerGas) > maxFeePerGas) {
        gasPrice = maxFeePerGas;
    }
    else {
        gasPrice = lastBaseFeePerGas + maxPriorityFeePerGas;
    }

    // ガス量の設定手数料を計算する（21000は一般的なトランザクションのガス量）
    const estimateGas = ethers.BigNumber.from(21000);
    // トランザクション全体のガス料金の手数料を計算する。例えばestimatedGasが21,000ガスで、gasPriceが100 Gweilだった場合、トランザクション手数料は21,000 * 100 Gweiになる
    const gasFee = estimatedGas.mul(gasPrice);
    console.log(`EIP-1559 Transaction Fee: ${ethers.utils.formatEther(gasFee)} ETH`);
}

calculateFree();