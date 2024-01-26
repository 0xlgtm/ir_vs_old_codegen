## IR vs Old Codegen

The purpose of this repo is to demonstrate the [differences](https://docs.soliditylang.org/en/latest/ir-breaking-changes.html) that come with using the IR codegen. Most of these changes are sementic only however, it may potentially be hiding new and different behaviour in the code. You wouldn't want to be caught with your pants down when your code is deployed on mainnet so it's better to err on the side of caution and be aware of these potential gotchas before you use the IR codegen. 

### How to use

This repo is configured with `via-ir` enabled by default so to run the IR specific tests, run the command `forge test --match-test "WithIr"`. To test it without IR, you need to disable `via_ir` in the [`foundry.toml`](./foundry.toml) and run the command `forge test --match-test "NoIr"`.
