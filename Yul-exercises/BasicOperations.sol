//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract ForLoopYul {
    // Yul has no else statement

    function forLoopYul(uint8 x) external pure returns(uint256 result){

        assembly {
            for { let i :=0 } lt(i, x) { i:= add(i,1) } {
                result:= add(result, 2)
            }
        }
        return result;
    }
    
    function isPrime(uint256 x) public pure returns(bool p) {
        p = true;

        assembly {
            let halfX := add(div(x,2),1)
            
            let i:= 2
            for{ } lt( i, halfX) {} { 
                    if iszero(mod(x,i)){
                        p:=0
                        break
                    }
                    i := add(i,1)
                }

        }
        return p;
    }


    function testPrime() external pure returns (bool){
        require(isPrime(2));
        require(isPrime(3));
        require(!isPrime(4));
        require(!isPrime(15));
        require(isPrime(23));
        require(isPrime(101));

        return true;
    }
}

contract IfStatement {

    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            if 2 {
                result := 1
            }
        }

        return result; // returns 1
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if 0 {
                result := 2
            }
        }

        return result; // returns 1
    }

    function isEqual(uint256 x, uint256 y) external pure returns(bool result) {
        result = false;
        assembly{
            
            if eq(x,y) {
                result:= 1
            } 
            // This is equivalent to: result:= eq(x,y)
        }
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function unsafe1Negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function bitFlipDemo() external pure returns (bytes32 result1, bytes32 result2, bytes32 result3) {
        bytes32 uno = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

        assembly {
            result1 := not(2)
            result2 := not(0)
            result3 := not(uno)
        }
    }

    function unsafe2Negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(2) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function safeNegation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(2) {
                result := 2
            }
        }

        return result; // returns 1
    }

    function getMax(uint256 x, uint256 y) external pure returns (uint256 max) {
        assembly {
            if lt(x,y) {
                max := y
            }

            if iszero(lt(x,y)) {
                max := x
            }
        }
    }

     // The rest:
    /*
        | solidity | YUL       |
        +----------+-----------+
        | a && b   | and(a, b) |
        +----------+-----------+
        | a || b   | or(a, b)  |
        +----------+-----------+
        | a ^ b    | xor(a, b) |
        +----------+-----------+
        | a + b    | add(a, b) |
        +----------+-----------+
        | a - b    | sub(a, b) |
        +----------+-----------+
        | a * b    | mul(a, b) |
        +----------+-----------+
        | a / b    | div(a, b) |
        +----------+-----------+
        | a % b    | mod(a, b) |
        +----------+-----------+
        | a >> b   | shr(b, a) |
        +----------+-----------+
        | a << b   | shl(b, a) |
        +----------------------+

    */
}

