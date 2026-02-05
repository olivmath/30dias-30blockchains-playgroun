// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    function run() public {
        bytes32 salt = keccak256("LUZ_TOKEN_2025");

        // === Ethereum Sepolia ===
        vm.createSelectFork("sepolia");
        vm.startBroadcast();
        Token sepolia = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("Sepolia:", address(sepolia));

        // === BNB Chain ===
        vm.createSelectFork("bnb");
        vm.startBroadcast();
        Token bnb = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("BNB Chain:", address(bnb));

        // === Arbitrum ===
        vm.createSelectFork("arbitrum");
        vm.startBroadcast();
        Token arb = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("Arbitrum:", address(arb));

        // === Optimism ===
        vm.createSelectFork("optimism");
        vm.startBroadcast();
        Token op = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("Optimism:", address(op));

        // === zkSync ===
        vm.createSelectFork("zksync");
        vm.startBroadcast();
        Token zk = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("zkSync:", address(zk));

        // === Polygon ===
        vm.createSelectFork("polygon");
        vm.startBroadcast();
        Token poly = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("Polygon:", address(poly));

        // === Base ===
        vm.createSelectFork("base");
        vm.startBroadcast();
        Token baseToken = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("Base:", address(baseToken));
    }
}
