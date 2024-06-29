/*Создайте смарт-контракт, который хранит числовое значение и позволяет его
изменять.
Добавьте функцию для чтения этого значения.
Убедитесь, что типы данных и доступ к переменным корректно объявлены.*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleStorage {
    uint private storeData;

    function set(uint x) public {
        storeData = x;
    }

    function get() public view returns (uint) {
        return storeData;
    }
}