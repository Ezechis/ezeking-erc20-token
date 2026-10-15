// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {EzekingToken} from "../src/EzekingToken.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

contract EzekingTokenTest is Test {
    EzekingToken internal token;

    address internal owner = address(this);
    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    uint256 internal constant INITIAL_SUPPLY = 1_000_000; // whole tokens
    uint256 internal unit;
    uint256 internal expectedSupply;

    function setUp() public {
        token = new EzekingToken("Ezeking Token", "EZK", INITIAL_SUPPLY);
        unit = 10 ** token.decimals();
        expectedSupply = INITIAL_SUPPLY * unit;
    }

    // --- deployment ---

    function test_Metadata() public view {
        assertEq(token.name(), "Ezeking Token");
        assertEq(token.symbol(), "EZK");
        assertEq(token.decimals(), 18);
    }

    function test_InitialSupplyGoesToOwner() public view {
        assertEq(token.totalSupply(), expectedSupply);
        assertEq(token.balanceOf(owner), expectedSupply);
        assertEq(token.owner(), owner);
    }

    // --- transfer ---

    function test_TransferBetweenWallets() public {
        uint256 amount = 1_000 * unit;
        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount);
        assertEq(token.balanceOf(owner), expectedSupply - amount);
    }

    function test_TransferRevertsOnInsufficientBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 1);
    }

    function testFuzz_Transfer(uint256 amount) public {
        amount = bound(amount, 0, expectedSupply);
        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount);
        assertEq(token.balanceOf(owner), expectedSupply - amount);
        assertEq(token.totalSupply(), expectedSupply);
    }

    // --- mint ---

    function test_OwnerCanMint() public {
        uint256 amount = 500 * unit;
        token.mint(alice, amount);
        assertEq(token.balanceOf(alice), amount);
        assertEq(token.totalSupply(), expectedSupply + amount);
    }

    function test_NonOwnerCannotMint() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice));
        token.mint(alice, 1);
    }

    // --- pause / unpause ---

    function test_PauseBlocksTransfers() public {
        token.pause();
        vm.expectRevert(Pausable.EnforcedPause.selector);
        token.transfer(alice, 1);
    }

    function test_UnpauseAllowsTransfers() public {
        token.pause();
        token.unpause();
        token.transfer(alice, 100 * unit);
        assertEq(token.balanceOf(alice), 100 * unit);
    }

    function test_NonOwnerCannotPause() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice));
        token.pause();
    }

    // --- burn ---

    function test_BurnReducesSupply() public {
        uint256 amount = 250 * unit;
        token.burn(amount);
        assertEq(token.totalSupply(), expectedSupply - amount);
        assertEq(token.balanceOf(owner), expectedSupply - amount);
    }

    function test_HolderCanBurnOwnTokens() public {
        token.transfer(alice, 10 * unit);
        vm.prank(alice);
        token.burn(4 * unit);
        assertEq(token.balanceOf(alice), 6 * unit);
        assertEq(token.totalSupply(), expectedSupply - 4 * unit);
    }
}
