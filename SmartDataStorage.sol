/*Создать смарт-контракт под названием SmartDataStorage, который будет
использоваться для хранения, обновления и извлечения данных различных типов.
Контракт должен включать следующие функции:
● storeNumber(uint number): добавляет числовое значение в массив.
Должна учитывать оптимизацию газа.
● retrieveNumbers(): возвращает массив всех сохранённых чисел.
● storeString(string memory text): хранит строку. Доступ к этой функции
должен быть ограничен только владельцем контракта.
● retrieveString(): возвращает последнюю сохранённую строку.
● changeOwnership(address newOwner): позволяет текущему владельцу
передать права новому владельцу. Должна использовать модификатор
доступа.
Управление доступом: только владелец контракта может добавлять или изменять
строки.
Оптимизация газа: убедитесь, что операции с массивами и строками эффективно
используют газ.*/

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;


contract SmartDataStorage {
    uint[] private numbers;
    string private storedString;
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function storeNumber(uint number) public {
        numbers.push(number);
    }

    function retrieveNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    function storeString(string memory text) public {
        require(msg.sender == owner, "Only contract owner can store string");
        storedString = text;
    }

    function  retrieveString() public view returns (string memory) {
        return storedString;
    }

    function changeOwnership(address newOwner) public {
        require(msg.sender == owner, "Only contract owner can change ownership");
        owner = newOwner;
    }
}