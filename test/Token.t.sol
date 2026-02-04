// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");
    address public charlie = makeAddr("charlie");

    function setUp() public {
        // vm.prank(alice);
        token = new Token();
    }

    // ========================================
    // TESTE PARA VOCÊ IMPLEMENTAR
    // ========================================

    /// @notice Teste: transferFrom deve reverter quando o owner não tem saldo suficiente
    /// @dev Mesmo que o spender tenha allowance suficiente, se o owner não tiver
    ///      saldo suficiente, a transação deve falhar (underflow).
    ///      Dica: Use _setBalance para dar um saldo menor que o amount,
    ///            mas dê um allowance maior que o amount.
    function test_TransferFrom_RevertsWhenOwnerHasInsufficientBalance() public {
        // TODO: Implementar este teste
        // 1. Dar saldo de 10 para alice
        _setBalance(alice, 10);
        // 2. Alice aprova bob para gastar 100
        vm.prank(alice);
        token.approve(bob, 100);
        // 3. Bob tenta transferir 50 de alice para charlie
        vm.prank(bob);
        // 4. Deve reverter (panic arithmetic underflow)
        vm.expectRevert(Token.InsufficientAmount.selector);
        token.transferFrom(alice, charlie, 50);
    }

    // ========================================
    // Testes de Metadata
    // ========================================

    function test_Name() public view {
        assertEq(token.name(), "LUZ Community");
    }

    function test_Symbol() public view {
        assertEq(token.symbol(), "LUZ");
    }

    function test_Decimals() public view {
        assertEq(token.decimals(), 2);
    }

    function test_TotalSupply() public view {
        assertEq(token.totalSupply(), 1_000_000_00);
    }

    // ========================================
    // Testes de balanceOf
    // ========================================

    function test_BalanceOf_ReturnsZeroForNewAddress() public view {
        assertEq(token.balanceOf(alice), 0);
    }

    // ========================================
    // Testes de allowance
    // ========================================

    function test_Allowance_ReturnsZeroByDefault() public view {
        assertEq(token.allowance(alice, bob), 0);
    }

    // ========================================
    // Testes de approve
    // ========================================

    function test_Approve_SetsAllowance() public {
        vm.prank(alice);
        bool success = token.approve(bob, 100);

        assertTrue(success);
        assertEq(token.allowance(alice, bob), 100);
    }

    function test_Approve_EmitsApprovalEvent() public {
        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Token.Approval(alice, bob, 100);

        token.approve(bob, 100);
    }

    function test_Approve_CanOverwriteExistingAllowance() public {
        vm.startPrank(alice);
        token.approve(bob, 100);
        token.approve(bob, 50);
        vm.stopPrank();

        assertEq(token.allowance(alice, bob), 50);
    }

    // ========================================
    // Testes de transfer (typo: tranfer)
    // ========================================

    function test_Transfer_Success() public {
        // Dar saldo para alice usando vm.store
        _setBalance(alice, 100);

        vm.prank(alice);
        bool success = token.tranfer(bob, 50);

        assertTrue(success);
        assertEq(token.balanceOf(alice), 50);
        assertEq(token.balanceOf(bob), 50);
    }

    function test_Transfer_EmitsTransferEvent() public {
        _setBalance(alice, 100);

        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Token.Transfer(alice, bob, 50);

        token.tranfer(bob, 50);
    }

    function test_Transfer_RevertsWhenInsufficientBalance() public {
        // Alice não tem saldo
        vm.prank(alice);
        vm.expectRevert(Token.InsufficientAmount.selector);
        token.tranfer(bob, 100);
    }

    function test_Transfer_CanTransferEntireBalance() public {
        _setBalance(alice, 100);

        vm.prank(alice);
        token.tranfer(bob, 100);

        assertEq(token.balanceOf(alice), 0);
        assertEq(token.balanceOf(bob), 100);
    }

    function test_Transfer_CanTransferZeroAmount() public {
        vm.prank(alice);
        bool success = token.tranfer(bob, 0);

        assertTrue(success);
    }

    // ========================================
    // Testes de transferFrom
    // ========================================

    function test_TransferFrom_Success() public {
        _setBalance(alice, 100);

        // Alice aprova Bob para gastar 50 tokens
        vm.prank(alice);
        token.approve(bob, 50);

        // Bob transfere tokens de Alice para Charlie
        vm.prank(bob);
        bool success = token.transferFrom(alice, charlie, 50);

        assertTrue(success);
        assertEq(token.balanceOf(alice), 50);
        assertEq(token.balanceOf(charlie), 50);
        assertEq(token.allowance(alice, bob), 0);
    }

    function test_TransferFrom_EmitsTransferEvent() public {
        _setBalance(alice, 100);

        vm.prank(alice);
        token.approve(bob, 50);

        vm.prank(bob);
        vm.expectEmit(true, true, false, true);
        emit Token.Transfer(alice, charlie, 50);

        token.transferFrom(alice, charlie, 50);
    }

    function test_TransferFrom_DecreasesAllowance() public {
        _setBalance(alice, 100);

        vm.prank(alice);
        token.approve(bob, 100);

        vm.prank(bob);
        token.transferFrom(alice, charlie, 30);

        assertEq(token.allowance(alice, bob), 70);
    }

    function test_TransferFrom_RevertsWhenInsufficientAllowance() public {
        _setBalance(alice, 100);

        vm.prank(alice);
        token.approve(bob, 10);

        vm.prank(bob);
        vm.expectRevert(Token.InsufficientAllowance.selector);
        token.transferFrom(alice, charlie, 50);
    }

    // ========================================
    // Testes de mint
    // ========================================

    /// @notice TESTE PARA VOCÊ IMPLEMENTAR
    /// @dev Dica: o owner do contrato é address(this) (quem fez deploy no setUp)
    ///      1. Chame token.mint(alice, amount)
    ///      2. Verifique que retorna true
    ///      3. Verifique o balanceOf de alice
    function test_Mint_Success() public {
        vm.prank(address(this));
        bool result = token.mint(alice, 1500);

        assertEq(result, true);
        assertEq(token.balanceOf(alice), 1500);
    }

    function test_Mint_RevertsWhenCallerIsNotOwner() public {
        vm.prank(alice);
        vm.expectRevert(Token.Unauthorized.selector);
        token.mint(alice, 100);
    }

    function test_Mint_RevertsWhenExceedsMaxSupply() public {
        // off-by-one: >= impede mintar exatamente totalSupply()
        uint256 maxSupply = token.totalSupply();
        vm.expectRevert(Token.MaxSupply.selector);
        token.mint(alice, maxSupply);
    }

    function test_Mint_EmitsTransferEvent() public {
        vm.expectEmit(true, true, false, true);
        emit Token.Transfer(address(0), alice, 100);

        token.mint(alice, 100);
    }

    // ========================================
    // Testes de burn
    // ========================================

    function test_Burn_Success() public {
        token.mint(alice, 100);

        vm.prank(alice);
        bool success = token.burn(50);

        assertTrue(success);
        assertEq(token.balanceOf(alice), 50);
    }

    function test_Burn_EntireBalance() public {
        token.mint(alice, 100);

        vm.prank(alice);
        token.burn(100);

        assertEq(token.balanceOf(alice), 0);
    }

    function test_Burn_RevertsWhenInsufficientBalance() public {
        token.mint(alice, 10);

        vm.prank(alice);
        vm.expectRevert(); // panic: arithmetic underflow (sem check de saldo no contrato)
        token.burn(50);
    }

    function test_Burn_EmitsTransferEvent() public {
        token.mint(alice, 100);

        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Token.Transfer(alice, address(0), 50);

        token.burn(50);
    }

    // ========================================
    // Helper Functions
    // ========================================

    function _setBalance(address account, uint256 amount) internal {
        // Slot 3 é o mapping _balances (0=currentSupply, 1=_owner, 2=_allowance, 3=_balances)
        bytes32 slot = keccak256(abi.encode(account, uint256(3)));
        vm.store(address(token), slot, bytes32(amount));
    }
}
