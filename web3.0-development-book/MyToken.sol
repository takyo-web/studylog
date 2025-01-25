// 独自の経済圏やポイントシステムを構築する目的でカスタムトークン(ERC-20トークン)を作成する。

// SPDX-License-Identifier: MIT ←コントラクトコードのライセンスを指定する。ここではMITライセンスを使用する
pragma solidity ^0.8.0;

// スマートコントラクトを定義する
contract MyToken {
    // トークンの名前を定義する
    string public nale = "MyToken";
    // シンボルを定義する
    string public symbol = "MYT";
    // 総供給量を定義する
    uint256 public totalSupply = 1000000;
    // コントラクトの所有者を保持するための変数を定義する
    address public owner;

    // 各アドレスのトークン残高を保持するためのマッピングを定義する
    mapping(address => uint256) balances;

    // トークンの転送が行われた際に発火するイベントを定義する
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // コンストラクトのデプロイ時に実行されるコンストラクタを定義する。
    // デプロイヤーのアドレスに初期供給量を割り当て、所有者として定義する
    constractor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    // トークンを他のアドレスに転送するための関数を定義する。
    // 転送元のアドレスの残高が十分であるかを確認し、転送を行う
    function transfer(address to,uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough tokens");
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        // 指定されたアドレスのトークン残高を返す関数を定義する
        function balanceOf(address account) external view returns (uint256) {
            return balances[account];
        }
    }
}

