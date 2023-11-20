// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    struct Item {
        string name;
        uint256 percentage;
    }

    Item[] public chestItems;
    mapping(address => string[]) public userInventory;

    //items in the loot chest
    constructor() ERC20("Degen", "DGN") {
        chestItems.push(Item("Awp Asiimov", 2));
        chestItems.push(Item("Butterfly Knife", 2)); 
        chestItems.push(Item("Glock Scrabble", 51));
        chestItems.push(Item("AK47 Elite", 60));
    }

    //code for opening a chest
    function openChest() public {
        require(balanceOf(msg.sender) >= 140, "Insufficient tokens to open chest");
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 100; 

        uint256 totalPercentage = 0;

        //total percentage
        for (uint256 i = 0; i < chestItems.length; i++) {
            totalPercentage += chestItems[i].percentage;
        }

        //randomized value
        uint256 randomValue = randomNumber % totalPercentage;
        uint256 cumulativePercentage = 0;
        string memory chosenItem;

        //determines what item you get from chest
        for (uint256 i = 0; i < chestItems.length; i++) {
            cumulativePercentage += chestItems[i].percentage;
            if (randomValue < cumulativePercentage) {
                chosenItem = chestItems[i].name;
                break;
            }
        }

        //consume balance after opening chest
        userInventory[msg.sender].push(chosenItem);
        _burn(msg.sender, 140);
    }

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
}

