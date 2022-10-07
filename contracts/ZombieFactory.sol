// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    constructor() {
    }

    struct Zombie {
        string name;
        uint dna;
    }

    event NewZombie (
        uint zombieId,
        string name,
        uint dna
    );

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;


    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length -1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        console.log (id, _name, _dna);
        emit NewZombie(id, _name, _dna);

    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require (ownerZombieCount[msg.sender] == 0, "It is only allowed one zombie per address");
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}