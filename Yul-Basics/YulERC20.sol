// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Used in the `name()` function
// 'Yul Token'
bytes32 constant nameLength = 0x0000000000000000000000000000000000000000000000000000000000000009;
bytes32 constant nameData = 0x59756c20546f6b656e0000000000000000000000000000000000000000000000;

// Used in the `symbol()` function
bytes32 constant symbolLength = 0x0000000000000000000000000000000000000000000000000000000000000003;
bytes32 constant symbolData = 0x59554c0000000000000000000000000000000000000000000000000000000000;

// `bytes4(keccak256("InsufficientBalance()"))`
bytes32 constant insufficientBalanceSelector = 0xf4d678b800000000000000000000000000000000000000000000000000000000;

// `bytes4(keccak256("InsufficientAllowance(address,address)"))`
bytes32 constant insufficientAllowanceSelector = 0xf180d8f900000000000000000000000000000000000000000000000000000000;

// cast keccak "Transfer(address,address,uint256)"
bytes32 constant transferHash = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef;

error InsufficientBalance();
error InsufficientAllowance(address owner, address spender);

/// @title Yul ERC20
/// @author Gimer Cervera
/// @notice For demo purposes ONLY.
contract YulERC20 {
    // owner -> balance
    mapping(address => uint256) internal _balances;

    // owner -> spender -> allowance
    mapping(address => mapping(address => uint256)) internal _allowances;

    function decimals() external pure returns (uint8) {
        assembly {
            mstore(0x00, 0x12)
            return (0x00, 0x20)
        }
    }

    function name() public pure returns (string memory) {
        assembly {
            // get the memory pointer address
            let memptr := mload(0x40)
            // string pointer
            mstore(memptr, 0x20)
            mstore(add(memptr, 0x20), nameLength)
            mstore(add(memptr, 0x40), nameData)
            return(memptr, 0x40)
        }
    }

    function symbol() public pure returns (string memory) {
        assembly {
            // get the memory pointer address
            let memptr := mload(0x40)
            mstore(memptr, 0x20)
            mstore(add(memptr, 0x20), symbolLength)
            mstore(add(memptr, 0x40), symbolData)
            return(memptr, 0x60)
        }
    }

    function getSelector(string memory _func) external pure returns(bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    function balanceOf (address ) public view returns (uint256) {
        assembly {
            mstore(0x00, calldataload(4))
            mstore(0x20, 0x00)
            mstore(0x00, sload(keccak256(0x00, 0x40)))
            return(0x00, 0x20)
        }
    }
}