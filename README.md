## IR vs Old Codegen

The purpose of this repo is to demonstrate the [differences](https://docs.soliditylang.org/en/latest/ir-breaking-changes.html) that come with using the IR codegen. Most of these changes are sementic only however, it may potentially be hiding new and different behaviour in the code. You wouldn't want to be caught with your pants down when your code is deployed on mainnet so it's better to err on the side of caution and be aware of these potential gotchas before you use the IR codegen. 

### How to use

To demonstrate these differences, you will need to run the test with and without `via-ir` enabled. You can configure this in the [`foundry.toml`](./foundry.toml).