// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract StoringData {
    function setData(uint256 newValue) public {
        assembly {
            sstore(0, newValue)
        }
    }

    function getData() public view returns(uint256) {
        assembly {
        let v := sload(0x00)
        
        let memptr := mload(0x40)
        mstore(memptr, v)
        return(memptr, 0x20)
        }
    }
}