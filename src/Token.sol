// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {
    error InsufficientAllowance();
    error InsufficientAmount();
    error Unauthorized();
    error MaxSupply();
    error MinSupply();

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    uint256 currentSupply = 0;
    address _owner;

    mapping(address sponsor => mapping(address spender => uint256 amount)) private _allowance;
    mapping(address onwer => uint256 amount) private _balances;
    //  | lucas | 10 |
    //  | marcos | 102 |
    //  | eduardo | 40 |
    //  | eduardoadp | 60 |

    constructor() {
        _owner = msg.sender;
    }

    function name() public pure returns (string memory) {
        return "LUZ Community";
    }

    function symbol() public pure returns (string memory) {
        return "LUZ";
    }

    function decimals() public pure returns (uint8) {
        // | 100 == 1,00 | 1000 == 10,00
        return 2;
    }

    function totalSupply() public pure returns (uint256) {
        // 1 mi
        return 1_000_000_00;
    }

    function balanceOf(address owner) public view returns (uint256) {
        // buscar no storage o saldo do `address`
        return _balances[owner];
    }

    // @ quantos tokens seus alguém pode gastar
    function allowance(address sponsor, address spender) public view returns (uint256 amount) {
        //   * sponsor: address | quem tem os tokens
        //   * spender: address | quem recebeu approve para gastar tokens do sponsor
        //   * returns(amount): uint256 | quantos tokens o spender pode gastar do sponsor
        amount = _allowance[sponsor][spender];
    }

    // transfer
    // @ transfere tokens do dono para alguém (somente o dono pode chamar)
    function tranfer(address to, uint256 amount) public returns (bool) {
        address from = msg.sender;

        if (_balances[from] < amount) {
            revert InsufficientAmount();
        }

        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }

    // approve
    // @ vc aprova que alguém gaste seus tokens (somente o dono pode chamar)
    function approve(address spender, uint256 amount) public returns (bool) {
        address from = msg.sender;

        _allowance[from][spender] = amount;

        emit Approval(from, spender, amount);

        return true;
    }

    // transferFrom
    // @ alguém gasta o dinheiro de alguém
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        address spender = msg.sender;

        if (_balances[from] < amount) {
            revert InsufficientAmount();
        }
        if (_allowance[from][spender] < amount) {
            revert InsufficientAllowance();
        }

        _allowance[from][spender] -= amount;

        // 10 -= 50;
        // 0 -= 40;
        // uint256.max -= 39;
        // 115792089237316195423570985008687907853269984665640564039457584007913129639896
        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }

    function _onlyOwner() internal view {
        address caller = msg.sender;
        if (caller != _owner) {
            revert Unauthorized();
        }
    }

    // @ cria tokens para o usuário passado como parametro (apenas o dono do contrato)
    function mint(address owner, uint256 amount) public returns (bool) {
        _onlyOwner();

        if (currentSupply + amount >= totalSupply()) {
            revert MaxSupply();
        }

        _balances[owner] += amount;
        currentSupply += amount;

        emit Transfer(address(0x0), owner, amount);

        return true;
    }

    // @ queimar tokens do usuário passado como parametro
    function burn(uint256 amount) public returns (bool) {
        if (currentSupply - amount < 0) {
            revert MinSupply();
        }

        _balances[msg.sender] -= amount;
        currentSupply -= amount;

        emit Transfer(msg.sender, address(0x0), amount);

        return true;
    }
}
