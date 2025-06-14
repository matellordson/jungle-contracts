// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Products {

    struct Product{
        string media;
        string title;
        string description;
        string price;
    }

    Product[] public product;

    function addProduct() public {

    }
}