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


When sending Ether to the contract, make sure you hit your `goal` that you set, and `finalize` the sale using the `Crowdsale`'s `finalize` function. In order to finalize, `isOpen` must return false (`isOpen` comes from `TimedCrowdsale` which checks to see if the `close` time has passed yet). Since the `goal` is 300 Ether, you may need to send from multiple accounts. If you run out of prefunded accounts in Ganache, you can create a new workspace.

Remember, the refund feature of `RefundablePostDeliveryCrowdsale` only allows for refunds once the crowdsale is closed **and** the goal is met. See the [OpenZeppelin RefundableCrowdsale](https://docs.openzeppelin.com/contracts/2.x/api/crowdsale#RefundableCrowdsale) documentation for details as to why this is logic is used to prevent potential attacks on your token's value.


In this project we will use MetaMask. Make sure to purchase higher amounts of tokens in order to see the denomination appear in your wallets as more than a few wei worth.

### Deploying the Crowdsale

Deploy the crowdsale to the Kovan testnet, and store the deployed address for later. Switch MetaMask to your desired network, and use the `Deploy` tab in Remix to deploy your contracts. Take note of the total gas cost, and compare it to how costly it would be in reality. Since you are deploying to a network that you don't have control over, faucets will not likely give out 300 test Ether. You can simply reduce the goal when deploying to a testnet to an amount much smaller, like 10,000 wei.

## Let's Deploy the Contracts on different testnet and see the difference Kovan vs. Local testnet on MetaMask

### Final documents 

* OmimarCoincodes: 'https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/OmimarCoin.sol'
* OmimarCoin Crowdsales (codes): 'https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/Crowdsale.sol'

### Contracts Deployment process - step by step

* Deployment on Kovan testnet
In order for crowdsale contracts to work smart contracts should be executed in following order. Prior to deployment one has to open ganache and metamask, and change the network to Kovan. Deployment will be succesfull if the Kovan address is prefunded, as we need some funds for gas.

* Deployment of the first contract OmimarCoin (solidity codes written in this contract should be imported in 'Crowdsale.sol'). Parameter required for deployment: 'name', 'symbol', 'initial_supply'.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/01-OmimarCoin_deployment.PNG)

* Confirmation of deployed contract

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/02-OmimarCoin-deployed-confirmation.PNG)

### NOTE: To be able to sucessfully run crowdsale it is important to strictly follow order of deployment for next contracts:

* OmimarCoinSaleDeployer Contract

Parameters required for deployment: 'name', 'symbol', 'address' (initial metamask wallet address), and 'goal'.


![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/03-OmimarCoinSaleDeployer.PNG)

* OmimarCoinSaleDeployer Contract - Confirmation

![](hhttps://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/04-OmimarCoinSaleDeployer-confirmation.PNG)

* OmimarCoinSale Deployment 

To deploy contract it is neccesseary to use 'omimar_sales_address' and input in the box next to 'At Address'. Then click to 'At Address' button to deploy the contract.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/05-OmimarCoinSale-depl.PNG)

* OmimarCoin Deployment

To deploy contract it is neccesseary to use 'token_address' and input in the box next to 'At Address'. Then click to 'At Address' button to deploy the contract.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/06-OmimarCoin-depl.PNG)

* Contract deployed - check the 'getter' functions to see wheter it is deployed properly.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/07-OmimarCoin-getter_fn.PNG)

* After all contracts are deployed we will buy some coins in several transactions.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/08-OmimarCoin-buyingcoins.PNG)

Confirmation of executed transaction. 

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/09-OmimarCoin-buyingcoins_conf.PNG)

Adding OMM token in the wallet on 'MetaMask'

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/10-add_token.PNG)

'OMM' token balance on 'MetaMask'.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/11-added_OMM_token.PNG)

'MetaMask' wallet overview both currencies: 'ETH' and 'OMM".

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/12-metamask_wallet.PNG)

Another purchase of 'OMM'.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/14-buyOMM.PNG)

NEW BALANCE: 'MetaMask' wallet overview both currencies: 'ETH' and 'OMM".

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/15-wallet_balance.PNG)


* Deployment on local test net, to check how contracts are performing and do all the additional functions testing.

Change 'MetaMask' on local host testnet, Refresh 'remix' and compile 'Crowdsale.sol' document.

* OmimarCoinSaleDeployer Contract

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/16-OmimarCoin_deployment-localnetwork.PNG)

* OmimarCoinSale Deployment 

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/17-OmimarCoinSale-depl.PNG)

* OmimarCoin Deployment 

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/18-OmimarCoin-depl.PNG)

* Purchasing of 'OMM' tokens in several transactions to reach the crowdsale goal.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/19-buying_OMM.PNG)

* Confirmation.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/20-OMM-buy-conf.PNG)

* New purchase - ACT LIKE A 'WHALE'.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/21-new-buyOMM.PNG)

* Make sure we reached the crowdsale cap.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/22-cap_reached.PNG)

* As the initial goal is to get 300 'ETH' we have to refund funds over the cap.

![](https://github.com/NinoslavVasic/Crowdsale-OMMcoin/blob/master/screenshots/23-claim_refund.PNG)




<footer>
    
Copyright 2020 Columbia Engineering - FinTech Bootcamp NVasic
    
    
</footer>

