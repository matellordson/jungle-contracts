// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Products {

    struct Product{
        address publisher;
        string media;
        string title;
        string description;
        string price;
    }

    Product[] public product;

    function addProduct(address _publisher ,string memory _media, string memory _title, string memory _description, string memory _price) public {
        product.push(Product({ 
            publisher: _publisher,
            media: _media,
            title: _title,
            description: _description,
            price: _price
        }));
    }

    function getProduct() public view returns ( Product[] memory) {
        return product;
    }
}