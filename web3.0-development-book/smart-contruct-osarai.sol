// pragma指令（Solidityのコンパイラバージョンを指定する）
pragma solidity ^0.8.0;

// コントラクトを定義する
contract HelloWorld {
    // string型の状態変数を定義する。public修飾子によりゲッター関数が生成される
    string public message;
    // コンストラクタがデプロイされた時に実行されるコンストラクタを定義する
    constructor(string memory initialMessage) {
        message = initialMessage;
    }
    // メッセージを更新する。setMessage関数を呼び出すことで自動でメッセージが更新されてブロックチェーンに記録される
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
    // メッセージを取得する。message変数をpublicとして定義することで透明性を担保する
    function getMessage() public view returns (string memory) {
        return message;
    }
}