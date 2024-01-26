// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract A {
    uint x;
    constructor() {
        x = 42;
    }
    function f() public view returns(uint256) {
        return x;
    }
}
contract B is A {
    uint public y = f();
}

/*
Old codegen:

1. All state variables are zero-initialized at the beginning.
2. Evaluate base constructor arguments from most derived to most base contract.
3. For every contract in order from most base to most derived in the linearized hierarchy:
    a. Initialize state variables.
4. For every contract in order from most base to most derived in the linearized hierarchy:
    a. Run the constructor (if present).

Assume we have a contract where A is B is C. C is the most base contract so the order of execution is:
- C's state is initialized.
- B's state is initialized
- A's state is initialized.
- C's constructor is run.
- B's constructor is run.
- A's constructor is run.
*/

/*
New codegen:

1. All state variables are zero-initialized at the beginning.
2. Evaluate base constructor arguments from most derived to most base contract.
3. For every contract in order from most base to most derived in the linearized hierarchy:
    a. Initialize state variables.
    b. Run the constructor (if present).

Assume we have a contract where A is B is C. C is the most base contract so the order of execution is:
- C's state is initialized.
- C's constructor is run.
- B's state is initialized
- B's constructor is run.
- A's state is initialized.
- A's constructor is run.
*/

contract InheritanceTest is Test {
    B b;
    function setUp() public {
        b = new B();
    }

    // Following the logic that was described above,
    // since all the state variables are initialized first,
    // y will have a value of 0 because when f() is called
    // x still has the value of 0 as the constructor that
    // assigns x with the value of 42 has not be executed.
    function test_initialization_NoIR() public {
        assertEq(b.y(), 0);
    }

    // Using the IR codegen, the constructor of A is executed
    // first before the state of B is initialized. This means
    // that when the f() is called, x will have the value of 42
    // and y is thus assigned the value of 42.
    function test_initialization_WithIR() public {
        assertEq(b.y(), 42);
    }
}
