pragma solidity ^0.4.19; // スマートコントラクトのコンパイラバージョンを指定する

// コントラクトを作成する
contract ZombieFactory { 
    // ゾンビ新規作成時に生成されたゾンビを表示させるためのイベントを宣言する
    event  NewZombie(unit zombieId, string name, uint dna);
    // 状態変数（コントラクト内に永遠に保管される＝ブロックチェーン上に記載される）の設定。今回は16桁に指定
    uint dnaDigits = 16; 

    // データ型を作る
    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // 関数定義。private関数にする
    function _createZombie(string _name, uint _dna) private{
        // ゾンビ新規作成時にイベントを発生させる
        unit id = zombies.push(Zombie(_name, _dna)) - 1;
        zombies.push(Zombie(_name, _dna));
    }

    // DNAランダム生成用の関数定義。こちらは読み専にする
    function _generateRandomDna(string _str) private view return (uint) {
        // _strのkeccak256ハッシュを取得しuint型で格納する
        uint rand = uint(keccak256(_str));
        // DNA番号は16桁にするため、剰余を返す
        return rand % dnaModulus;
    }

    // ゾンビ生成用の関数定義
    function createRandomZombie(string _name) public{
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}