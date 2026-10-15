// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {EzekingToken} from "../src/EzekingToken.sol";

contract DeployEzekingToken is Script {
    string internal constant NAME = "Ezeking Token";
    string internal constant SYMBOL = "EZK";
    uint256 internal constant INITIAL_SUPPLY = 1_000_000; // whole tokens

    function run() external returns (EzekingToken token) {
        vm.startBroadcast();
        token = new EzekingToken(NAME, SYMBOL, INITIAL_SUPPLY);
        vm.stopBroadcast();

        console.log("EzekingToken deployed at:", address(token));
        console.log("Owner:", token.owner());
        console.log("Total supply (wei):", token.totalSupply());
    }
}
