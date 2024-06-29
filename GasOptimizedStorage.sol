/*Создайте контракт для хранения массива чисел.
Реализуйте функцию добавления элемента в массив с учётом оптимизации газа.
Добавьте функцию для просмотра всего массива*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract GasOptimizedStorage {
    uint[] public numbers;

    function addNumber(uint number) public {
        numbers.push(number);
    }

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }
}