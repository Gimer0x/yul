# Yul Programming Language
This repository is a collection of exercises and resources to learn the programming language [**Yul**](https://docs.soliditylang.org/en/latest/). Understanding Yul is key to become an advanced Solidity developer or an Ethereum Security Researcher.

# Table of Contents
1. [The Ethereum Virtual Machine](#the-ethereum-virtual-machine-evm)
2. [Yul Tutorial](#yul-tutorial)
2. [Folders](#folders)
2. [Suggested Videos](#suggested-videos)
3. [Additional Resources](#additional-resources)

## The Ethereum Virtual Machine (EVM)
The **Ethereum Virtual Machine (EVM)** is the core component of the Ethereum network. This component allows the execution of smart contracts written in Solidity. After writing the contract, it is compiled into bytecode and deployed to the EVM. In this [**article**](https://medium.com/coinsbench/ethereum-virtual-machine-evm-deep-dive-part-i-7dd6fe7b2f44?sk=ecde25a77594f0a99366c23bc79aaa3c) you can find an introduction to the EVM.

**Solidity Assembly** refers to a low-level programming language that allows developers to write code at a level closer to the EVM itself. It provides a more granular control over the execution of smart contracts, allowing for optimizations and customization that may not be achievable through higher-level Solidity code alone. The language used for inline assembly in Solidity is known as **Yul**. 

Yul is an intermediate language that compiles to **EVM bytecode**. It is designed to be a low-level language that gives developers a high degree of control over the execution of their smart contracts. It can be used in stand-alone mode and for *inline assembly* inside Solidity.

Yul is designed to be a low-level stack-based language, providing developers with the ability to write more optimized and efficient code. It serves as the bridge between the higher-level Solidity code and the low-level EVM bytecode.

In this repository you will find a set of examples that I have written in order to master Yul programming and smart contract optimization. Also, you will find exercises from courses and other articles.

## Yul Tutorial

### Basic Syntax
To use assembly within a solidity smart contract, just insert an assembly block inside a solidity function:

```solidity 
function sendFunds(uint256 amount) external{

  assembly {
    let x := amount
  }

}
```

### Types in Yul
Yul does not have the concept of types. It only works with `32 bytes` words. However, we can read and write from Solidity variables, for example: 

```solidity 
assembly {
  let a := 1234
  let b := true
  let c := "hello world"
  let d := 0xabcdef
}
```
In this example, we asigned Solidity literals to assembly variables. Not that we use the keyword `let` to declare a variable. Internally Yul represents these values as follows:

```solidity 
a = 0x0000000000000000000000000000000000000000000000000000000000001234
b = 0x0000000000000000000000000000000000000000000000000000000000000001
c = 0x68656c6c6f20776f726c64000000000000000000000000000000000000000000
d = 0x0000000000000000000000000000000000000000000000000000000000abcdef

```
Each variable is represented as a 64 characters (or 32 bytes). Every byte is represented by two characters. Because there is no boolean type in Yul, all operations return full 32-byte words, even the logical operations like and, or and not. A `false`value is represented as full word with all 0s and a full word with 1 at the end for a `true`value. 

The `not` operator performs negation on the bit level (it flips all 0s to 1s and vice versa), which means that not(1) will still return true, because all bits except the first one will be ones.

### Storage variables

To retrieve and set storage variables we use the functions:

- **slot** - returns the location of a variable.
- **sload** - reads a value from a given storage slot.
- **sstore** - writes a value to given storage slot.

```solidity
contract StorageBasics {
    uint256 x = 10;
    uint256 y = 20;
    uint256 z = 30;

    function getValueX() external view returns (bytes32 ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function getSlot(uint256 slot) external view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }
    // DANGEROUS OPERATION! Never allow external users to set arbitrary slots.
    function setValue(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value)
        }
    }
}

```

## Folders
* **Udemy-Course-Yul**: These are my exercises from the course  [**Advanced Solidity: Yul and Assembly**](https://www.udemy.com/course/advanced-solidity-yul-and-assembly/), developed by Jeffrey Scholz in Udemy.

## Suggested Videos

- [Ethereum Under the Hood: Algorithms And Data Structures](https://www.youtube.com/watch?v=OxofT39TJgg) by Marek Kirejczyk

- [EVM From Solidity to Bytecode, Memory & Storage](https://www.youtube.com/watch?v=RxL_1AfV7N4&t=2s) by Peter Robinson

- [Demystifying EVM Opcodes](https://youtu.be/_tcyI_lNvo0?si=kxPFtKlVGAEb4HbT) by Gilbert G at ETH Global (2022).

- [Demystifying Ethereum Assembly](https://youtu.be/btDOvn8pLkA?si=fXKHMC_DIhmqZLok) by Joshua Riley at Devcon Bogota (2022)

- [EVM Opcodes for Gas Optimizations](https://www.youtube.com/live/M8_4THWJkHQ?si=uKYpXOf1BIkQt1qe) by Patrick Collins at Chainlink Hackaton (2022)

- [Alex Roan: Hitchhiker’s Guide to the EVM](https://youtu.be/zgukojxyHKc?si=2y5xectQ8U0bLCk0) by Alex Roan at SmartCon Developer (2021)

## Additional Resources

+ [EVM Codes - An EVM Opcodes Interactive Reference](https://www.evm.codes/): Interactive Website & EVM playground. A very useful tool to practice and observe how opcodes work.

+ [Andreas Antonopoulos - The Ethereum Virtual Machine](https://github.com/ethereumbook/ethereumbook/blob/develop/13evm.asciidoc): In this ebook, chapter 13 covers the fundamentals of how the EVM works and shows the EVM interaction with the protocol layer.

+ [Femboy Capital - A Playdate with the EVM](https://femboy.capital/evm-pt1): This blogpost deep dive into the EVM, explaining how stack machines work before showing how to write assembly code.

+ [Solidity Tutorial All About Assembly](https://jeancvllr.medium.com/solidity-tutorial-all-about-assembly-5acdfefde05c): A blogpost that explains in detail about EVM assembly, opcodes & using it in solidity.

+ [Ethereum Virtual Machine (EVM) Deep Dive P.1](https://medium.com/coinsbench/ethereum-virtual-machine-evm-deep-dive-part-i-7dd6fe7b2f44?sk=ecde25a77594f0a99366c23bc79aaa3c): This is a series of articles explaining the Ethereum Virtual Machine.

+ [Openzeppelin - Deconstructing a Solidity Contract](https://openzeppelin.com/): A series of blog posts to describe in detail how the solidity code is interpreted and executed by the EVM.
  - [Part 1 - Introduction](https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737/)
  - [Part 2 - Runtime vs Creation Bytecode](https://blog.zeppelin.solutions/deconstructing-a-solidity-contract-part-ii-creation-vs-runtime-6b9d60ecb44c)
  - [Part 3 - Function Selector](https://blog.zeppelin.solutions/deconstructing-a-solidity-contract-part-iii-the-function-selector-6a9b6886ea49)
  - [Part 4 - Function Wrappers](https://blog.zeppelin.solutions/deconstructing-a-solidity-contract-part-iv-function-wrappers-d8e46672b0ed)
  - [Part 5 - Function Bodies](https://blog.zeppelin.solutions/deconstructing-a-solidity-contract-part-v-function-bodies-2d19d4bef8be)
  - [Part 6 - The Metadata Hash](https://blog.zeppelin.solutions/deconstructing-a-solidity-contract-part-vi-the-swarm-hash-70f069e22aef)

+ [Diving Into the Ethereum Virtual Machine](https://medium.com/@hayeah/diving-into-the-ethereum-vm-6e8d5d2f3c30): In this series of articles the author deep dive into the Ethereum Virtual Machine and Opcodes.
  - [Part 1 - Introduction to the EVM assembly code](https://medium.com/@hayeah/diving-into-the-ethereum-vm-6e8d5d2f3c30)
  - [Part 2 - How fixed-length data types are represented](https://medium.com/@hayeah/diving-into-the-ethereum-vm-part-2-storage-layout-bc5349cb11b7)
  - [Part 3 - How dynamic data types are represented](https://medium.com/@hayeah/diving-into-the-ethereum-vm-the-hidden-costs-of-arrays-28e119f04a9b)
  - [Part 4 - How ABI Encodes External Method Calling](https://medium.com/@hayeah/how-to-decipher-a-smart-contract-method-call-8ee980311603)

+ [Noxx - EVM Deep Dives](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy?s=r): A series of blog posts that review in detail specific parts of the EVM taking you from solidity code to the EVM opcodes
 
  - [Part 1 - Function Selector Deep Dive](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy?s=r)
  - [Part 2 - Memory in the EVM](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-d6b?s=r)
  - [Part 3 - Storage in the EVM](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-3ea?s=r)
  - [Part 4 - Storage Opcodes In the Go Ethereum (Geth) Client](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-5a5?utm_source=%2Fprofile%2F80455042-noxx&utm_medium=reader2&s=r)
  - [Part 5 - Delegate Call Deep Dive](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-a5f?utm_source=%2Fprofile%2F80455042-noxx&utm_medium=reader2&s=r)

+ [Fvictorio - EVM Puzzle](https://github.com/fvictorio/evm-puzzles): These repositories are a collection of interactive EVM puzzles on GitHub.
  - [Fvictorio - EVM Puzzles](https://github.com/fvictorio/evm-puzzles)
  - [Daltboy - More EVM Puzzles](https://github.com/daltyboy11/more-evm-puzzles)

+ [Official Solidity Docs](https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_storage.html): Official Solidity Docs for how storage, memory & calldata are handled in a solidity contract
  - [Yul Programming Language](https://docs.soliditylang.org/en/latest/yul.html)
  - [Layout of State Variables in Storage](https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_storage.html)
  - [Layout in Memory](https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_memory.html)
  - [Layout of Calldata](https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_calldata.html)