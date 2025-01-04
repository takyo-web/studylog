pragma solidity ^0.4.19;

import "./zombiefactory.sol";

// 餌の詳細情報を取得するための宣言
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

    address ckAddress = ;

    // KittyInterfaceをckAddressで初期化する
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna、 string memory _species) public {
        // この関数を呼び出したアドレスがゾンビの所有者であることを確認する
        require(msg.sender == zombieToOwner[_zombieId]);

        // _zombieIdに対応するゾンビを取得する
        Zombie storage myZombie = zombies[_zombieId];

        // ターゲットDNAが16桁に収まるようにする
        _targetDna = _targetDna % dnaModulus;

        // 人間のDNAを足して2で割ることで新しいDNAを生成する
        uint newDna = (myZombie.dna + _targeteDna) / 2;

        // 
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }

        // "NoName"をデフォルト名とする新しいゾンビを生成する
        _createZombie("NoName", newDna);
    }

    // 特定のゾンビに特定のKittyを食べさせる
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        // KittyのDNAを取得する。DNAのみ取得したいので、10番目の戻り値のみ取得する。カンマで区切ることで他の戻り値を無視する
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // ゾンビのDNAとKittyのDNAを組み合わせて新しいゾンビを作成するための関数を呼び出す
        feedAndMultiply(_zombieId, kittyDna);
    }
}