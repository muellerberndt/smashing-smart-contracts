pragma solidity ^0.4.13;

// UitwerpselenToken: The multi-user wallet with a twist!
// Do NOT use this in production!

// UitwerpselenToken is based on MerdeToken by Doug Hoyte:
// https://github.com/Arachnid/uscc/tree/master/submissions-2017/doughoyte

contract UitwerpselenToken {
    address public owner;
    address public manager;

    function UitwerpselenToken(address _manager) {
        owner = msg.sender;
        manager = _manager;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyManager {
        require(msg.sender == manager);
        _;
    }

    mapping (address => uint) public balanceOf;
    uint public deposited;

    function deposit() payable {
        require(deposited + msg.value > deposited);
        require(balanceOf[msg.sender] + msg.value > balanceOf[msg.sender]); 
        balanceOf[msg.sender] += msg.value;
        deposited += msg.value;
    }

    function balanceOf(address owner) constant returns (uint balance) {
        return balanceOf[owner];
    }

    function transfer(address to, uint value) {
        require(balanceOf[msg.sender] >= value);
        require(balanceOf[to] + value > balanceOf[to]);
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
    }

    function withdraw(uint amount) onlyOwner {
        require(amount <= deposited);
        deposited -= amount;
        msg.sender.transfer(amount);
    }

    uint[] public bonusCodes;

    function pushBonusCode(uint code) onlyManager {
        bonusCodes.push(code);
    }

    function popBonusCode() onlyManager {
        require(bonusCodes.length >= 0);
        bonusCodes.length--;
    }

    function modifyBonusCode(uint index, uint update) onlyManager {
        require(index < bonusCodes.length);
        bonusCodes[index] = update;
    }
}

