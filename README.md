# DegenToken Smart Contract

## Overview

The "DegenToken" smart contract is an ERC-20 token that extends the functionality of the OpenZeppelin ERC20 and Ownable contracts. It introduces a unique feature—a loot chest mechanism that allows users to open chests and receive random items based on predefined percentages. The token is named "Degen" with the symbol "DGN."

## Loot Chest Mechanism

The smart contract includes a loot chest mechanism, allowing users to open chests and receive random items. Each item has a defined percentage chance of being obtained. The chestItems array contains the items available in the loot chest, along with their respective percentages.

```solidity
struct Item {
    string name;
    uint256 percentage;
}

Item[] public chestItems;
```

## User Inventory

The contract maintains a userInventory mapping, associating each user with a list of items they have obtained from opening chests.

```solidity
mapping(address => string[]) public userInventory;
```

## Opening a Chest

Users can open a chest by calling the `openChest` function. The function checks if the user has a sufficient token balance to open the chest and uses a random number generation mechanism to determine the item obtained.

```solidity
function openChest() public {
    // ...
}
```

## Token Operations

The contract includes standard ERC-20 token operations, such as minting, burning, and transferring.

- The owner can mint new tokens using the `mint` function.
- Token holders can burn their own tokens using the `burn` function.
- The `transfer` function allows users to transfer tokens to other addresses.

```solidity
function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
}

function burn(uint256 amount) public {
    _burn(msg.sender, amount);
}

function transfer(address to, uint256 amount) public override returns (bool) {
    _transfer(_msgSender(), to, amount);
    return true;
}
```

## Security and Considerations

- The contract utilizes the Ownable pattern to ensure that only the owner can perform certain critical functions.
- Users should exercise caution and thoroughly test the loot chest mechanism and token operations before deploying the contract on the blockchain.

## License

This smart contract is released under the MIT License. See [LICENSE](LICENSE) for more details.

---

**Note:** This README provides a brief overview of the DegenToken smart contract. For more detailed information, review the contract code and comments directly.
