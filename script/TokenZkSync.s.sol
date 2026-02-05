// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenZkSyncScript is Script {
    function run() public {
        bytes32 salt = keccak256("LUZ_TOKEN_2025");

        vm.startBroadcast();
        Token zk = new Token{salt: salt}();
        vm.stopBroadcast();
        console.log("zkSync:", address(zk));
    }
}
