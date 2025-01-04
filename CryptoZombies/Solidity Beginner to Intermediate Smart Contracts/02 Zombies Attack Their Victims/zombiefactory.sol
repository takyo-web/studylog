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

    // マッピングを定義して、どのゾンビがどのユーザー（ウォレットアドレス）に属しているかを追跡する
    mapping (uint => address) public zombieToOwner;

    // マッピングを定義して、各ユーザーが何体のゾンビを持っているかを管理する
    mapping (address => unit) ownerZombieCount;

    // 関数定義。private関数にする
    function _createZombie(string _name, uint _dna) internal {
        // ゾンビ新規作成時にイベントを発生させる
        unit id = zombies.push(Zombie(_name, _dna)) - 1;

        // 作成したゾンビのオーナーをトランザクションを実行したアカウントに設定する
        zombieToOwner[id] = msg.sender;

        // オーナーが持つゾンビの数を1増やす
        ownerZombieCount[msg.sender]++;
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
        //  呼び出し元のアカウント（msg.sender）がまだゾンビを1体も所有していないことを確認する
        require(ownerZombieCount[msg.sender] == 0);
        // _generateRandomDna関数を呼び出し、_nameを基にランダムなDNAを生成する
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}

// ZombieFactoryを継承し、ゾンビに餌を与えるためのコントラクトを作成する
contract ZombieFeeding is ZombieFactory {
    function
}