# Crowdsale - OMMcoin

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/crowdsale_image.png)

## Background and initial setup

New startup has decided to crowdsale their OmimarCoin token in order to help fund the network development.
This network will be used to track the dog breeding activity across the globe in a decentralized way, and allow humans to track the genetic trail of their pets. 
Necessary legal bodies are already been contacted and company have the green light on creating a crowdsale open to the public. 
However, company is required to enable refunds if the crowdsale is successful and the goal is met, and it isallowed to raise a maximum of 300 Ether. The crowdsale will run for 24 weeks.

ERC20 token  should be created  and will be minted through a `Crowdsale` contract that we can leverage from the OpenZeppelin Solidity library.

This crowdsale contract will manage the entire process, allowing users to send ETH and get back OMM (OmimarCoin).
This contract will mint the tokens automatically and distribute them to buyers in one transaction.

It will need to inherit `Crowdsale`, `CappedCrowdsale`, `TimedCrowdsale`, `RefundableCrowdsale`, and `MintedCrowdsale`.

Crowdsale will be executed via  Kovan testnet in order to get a real-world pre-production test in.

## Instructions

### Creating your project

Using Remix, create a file called `OmimarCoin.sol` and create a standard `ERC20Mintable` token. 
Create a new contract named `OmimarCoinCrowdsale.sol`, and prepare it like a standard crowdsale.

### Designing the contracts

#### ERC20 OmimarCoin

We have to use standard `ERC20Mintable` and `ERC20Detailed` contract, hardcoding `18` as the `decimals` parameter, and leaving the `initial_supply` parameter alone.

Don't need to hardcode the decimals, however since most use-cases match Ethereum's default.


#### OmimarCoinCrowdsale

Leverage the [Crowdsale](../Starter-Code/Crowdsale.sol) starter code, saving the file in Remix as `Crowdsale.sol`.

You will need to bootstrap the contract by inheriting the following OpenZeppelin contracts:

* `Crowdsale`

* `MintedCrowdsale`

* `CappedCrowdsale`

* `TimedCrowdsale`

* `RefundablePostDeliveryCrowdsale`

We need to provide parameters for all of the features of crowdsale, such as the `name`, `symbol`, `wallet` for fundraising, `goal`, etc. Feel free to configure these parameters to your liking.

You can hardcode a `rate` of 1, to maintain parity with Ether units (1 TKN per Ether, or 1 TKNbit per wei). If you'd like to customize your crowdsale rate, follow the [Crowdsale Rate](https://docs.openzeppelin.com/contracts/2.x/crowdsales#crowdsale-rate) calculator on OpenZeppelin's documentation. Essentially, a token (TKN) can be divided into TKNbits just like Ether can be divided into wei. When using a `rate` of 1, just like 1000000000000000000 wei is equal to 1 Ether, 1000000000000000000 TKNbits is equal to 1 TKN.

Since `RefundablePostDeliveryCrowdsale` inherits the `RefundableCrowdsale` contract, which requires a `goal` parameter, you must call the `RefundableCrowdsale` constructor from your `OmimarrCoinCrowdsale` constructor as well as the others. `RefundablePostDeliveryCrowdsale` does not have its own constructor, so just use the `RefundableCrowdsale` constructor that it inherits.

If you forget to call the `RefundableCrowdsale` constructor, the `RefundablePostDeliveryCrowdsale` will fail since it relies on it (it inherits from `RefundableCrowdsale`), and does not have its own constructor.

When passing the `open` and `close` times, use `now` and `now + 24 weeks` to set the times properly from your `PupperCoinCrowdsaleDeployer` contract.

#### OmimarCoinCrowdsaleDeployer

Leverage the [OpenZeppelin Crowdsale Documentation](https://docs.openzeppelin.com/contracts/2.x/crowdsales) for an example of a contract deploying another, as well as the starter code provided in [Crowdsale.sol](../Starter-Code/Crowdsale.sol).

### Testing the Crowdsale

Test the crowdsale by sending Ether to the crowdsale from a different account (**not** the same account that is raising funds), then once you confirm that the crowdsale works as expected, try to add the token to MyCrypto and test a transaction. You can test the time functionality by replacing `now` with `fakenow`, and creating a setter function to modify `fakenow` to whatever time you want to simulate. You can also set the `close` time to be `now + 5 minutes`, or whatever timeline you'd like to test for a shorter crowdsale.

When sending Ether to the contract, make sure you hit your `goal` that you set, and `finalize` the sale using the `Crowdsale`'s `finalize` function. In order to finalize, `isOpen` must return false (`isOpen` comes from `TimedCrowdsale` which checks to see if the `close` time has passed yet). Since the `goal` is 300 Ether, you may need to send from multiple accounts. If you run out of prefunded accounts in Ganache, you can create a new workspace.

Remember, the refund feature of `RefundablePostDeliveryCrowdsale` only allows for refunds once the crowdsale is closed **and** the goal is met. See the [OpenZeppelin RefundableCrowdsale](https://docs.openzeppelin.com/contracts/2.x/api/crowdsale#RefundableCrowdsale) documentation for details as to why this is logic is used to prevent potential attacks on your token's value.

We will add custom tokens in Metamask from the `Add custom token` feature:

![add-custom-token](https://i.imgur.com/p1wwXQ9.png)

You can also do the same for MetaMask. Make sure to purchase higher amounts of tokens in order to see the denomination appear in your wallets as more than a few wei worth.

### Deploying the Crowdsale

Deploy the crowdsale to the Kovan testnet, and store the deployed address for later. Switch MetaMask to your desired network, and use the `Deploy` tab in Remix to deploy your contracts. Take note of the total gas cost, and compare it to how costly it would be in reality. Since you are deploying to a network that you don't have control over, faucets will not likely give out 300 test Ether. You can simply reduce the goal when deploying to a testnet to an amount much smaller, like 10,000 wei.


### Final documents 

*  OmimarCoincodes: 'https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/OmimarCoin.sol'
* OmimarCoin Crowdsales (codes): 'https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/Crowdsale.sol'

### Contracts Deployment process - step by step

* Deployment on Kovan testnet
In order for crowdsale contracts to work smart contracts should be executed in following order:

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/01-OmimarCoin_deployment.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/02-OmimarCoin-deployed-confirmation.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/03-OmimarCoinSaleDeployer.PNG)
![](hhttps://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/04-OmimarCoinSaleDeployer-confirmation.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/05-OmimarCoinSale-depl.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/06-OmimarCoin-depl.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/07-OmimarCoin-getter_fn.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/08-OmimarCoin-buyingcoins.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/09-OmimarCoin-buyingcoins_conf.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/10-add_token.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/11-added_OMM_token.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/12-metamask_wallet.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/14-buyOMM.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/15-wallet_balance.PNG)


* Deployment on local test net

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/16-OmimarCoin_deployment-localnetwork.PNG)

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/17-OmimarCoinSale-depl.PNG)

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/18-OmimarCoin-depl.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/19-buying_OMM.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/20-OMM-buy-conf.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/21-new-buyOMM.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/22-cap_reached.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/23-claim_refund.PNG)
![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/crowdsale_image.png)

