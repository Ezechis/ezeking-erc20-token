// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title Ezeking Token (EZK)
/// @notice Customised ERC-20: burnable by holders, mintable and pausable by the owner.
contract EzekingToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    /// @param name_ Token name, e.g. "Ezeking Token".
    /// @param symbol_ Token symbol, e.g. "EZK".
    /// @param initialSupply Initial supply in whole tokens (scaled by decimals() internally).
    constructor(string memory name_, string memory symbol_, uint256 initialSupply)
        ERC20(name_, symbol_)
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    /// @notice Mint new tokens. Owner only.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /// @notice Freeze all transfers, mints and burns. Owner only.
    function pause() external onlyOwner {
        _pause();
    }

    /// @notice Resume transfers. Owner only.
    function unpause() external onlyOwner {
        _unpause();
    }

    // Required override: ERC20 and ERC20Pausable both define _update.
    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}
