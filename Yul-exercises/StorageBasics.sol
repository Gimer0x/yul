// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract StorageBasics {
    uint256 public x = 2;
    uint256 public y = 13;
    uint256 public z = 54;
    uint256 public p;

    function getVariable(uint256 slot) external view returns(bytes32 res){
        assembly {
            res := sload(slot)
        }
    }

    function returnSlot() external pure returns(uint256 res) {
        assembly{
            res := y.slot
        }
    }

    function setVariable(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value)
        }
    }
}