//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract YulTypes {
    // In Yul theres is only one type
    // Strings less than 32 bytes

    function getNumber() external pure returns (uint256 x){
        assembly {
            x:= 42
        }
        return x;
    }

    function getHex() external pure returns (uint256 x){
        assembly {
            x:= 0xF
        }
        return x;
    }

    function getStringBytes() external pure returns (bytes32 x) {
        assembly {
            x:= "Lorem ipsum dolor set amet.."
        }
        return x;
    }

    function getString() external pure returns (string memory x) {
        assembly {
            x:= "Lorem ipsum dolor set amet.."
        }
        return string(abi.encode(x));
    }

    function representation() external pure returns (address x) {
        
        assembly {
            x := 1
        }

        return x;
    }


}