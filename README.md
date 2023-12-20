# Yul
The **Ethereum Virtual Machine (EVM)** is the core component of the Ethereum network. This component allows the execution of smart contracts written in Solidity. After writing the contract, it is compiled into bytecode and deployed to the EVM.

**Solidity Assembly** refers to a low-level programming language that allows developers to write code at a level closer to the EVM itself. It provides a more granular control over the execution of smart contracts, allowing for optimizations and customization that may not be achievable through higher-level Solidity code alone. The language used for inline assembly in Solidity is known as **Yul**. 

Yul is an intermediate language that compiles to **EVM bytecode**. It is designed to be a low-level language that gives developers a high degree of control over the execution of their smart contracts. It can be used in stand-alone mode and for *inline assembly* inside Solidity.

Yul is designed to be a low-level stack-based language, providing developers with the ability to write more optimized and efficient code. It serves as the bridge between the higher-level Solidity code and the low-level EVM bytecode.

In this repository you will find a set of examples that I have written in order to master Yul programming and smart contract optimization. Also, you will find exercises from courses and other articles.

**Folders:**
* **Udemy-Course-Yul**: These are my exercises from the course  [**Advanced Solidity: Yul and Assembly**](https://www.udemy.com/course/advanced-solidity-yul-and-assembly/), developed by Jeffrey Scholz in Udemy.

**Resources:**

+ [**EVM Codes - An EVM Opcodes Interactive Reference**](https://www.evm.codes/) 
* Interactice Website & EVM playground. A very useful tool to practice and observe how opcodes work.

+ [**Andreas Antonopoulos - The Ethereum Virtual Machine**](https://github.com/ethereumbook/ethereumbook/blob/develop/13evm.asciidoc)
* In thi ebook, chapter 13 covers the fundamentals of how the EVM works and shows the EVM interaction with the protocol layer. 

