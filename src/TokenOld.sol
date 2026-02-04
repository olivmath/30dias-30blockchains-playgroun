// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {
    // [32bytes] name;
    // [32bytes] symbol;
    // [32bytes] [ 0, 0, 0, 0, ...., X,  X ]
    // [32bytes] [ X ]

    string public name;
    string public symbol;
    uint8 public decimals;
    uint8 public decimals12;
    uint256 public totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowance;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        // buscar no storage o saldo do `address`
        return _balances[owner];
    }

    // @ quantos tokens seus alguém pode gastar
    function allowance(address owner, address spender) public view returns (uint256 amount) {
        //   * owner: address | quem tem os tokens
        //   * spender: address | quem recebeu approve para gastar tokens do owner
        //   * returns(amount): uint256 | quantos tokens o spender pode gastar do owner
        amount = _allowance[owner][spender];
    }
}
