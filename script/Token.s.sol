// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;

    function setUp() public {}

    function run() public {
        // optimism
        // arbitrum
        // polygon
        // zksync
        // ... L2


        // === CONFIGURAÇÃO ===
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        bytes32 salt = keccak256("MEU_SALT_UNICO_2025"); // ← mude para algo único seu

        // Se o construtor tiver argumentos, ajuste aqui
        bytes memory initCode = type(MeuContrato).creationCode; // sem args
        // Exemplo com args: bytes memory initCode = abi.encodePacked(
        //     type(MeuContrato).creationCode,
        //     abi.encode(arg1, arg2)
        // );

        // === Rede 1 ===
        vm.createSelectFork("sepolia");
        address predicted = vm.computeCreate2Address(salt, initCode, deployer);
        console.log("Endereço previsto Sepolia:", predicted);

        vm.startBroadcast();
        new MeuContrato{salt: salt}();        // ← aqui usa CREATE2
        vm.stopBroadcast();

        // === Rede 2 ===
        vm.createSelectFork("base-sepolia");
        predicted = vm.computeCreate2Address(salt, initCode, deployer);
        console.log("Endereço previsto Base Sepolia:", predicted);

        vm.startBroadcast();
        new MeuContrato{salt: salt}();
        vm.stopBroadcast();
    }
}
