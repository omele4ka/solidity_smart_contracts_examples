/*Создайте смарт-контракт с закрытой переменной и функцией для её изменения.
Добавьте модификатор, который разрешает изменение переменной только
владельцем контракта.*/

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;


contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}