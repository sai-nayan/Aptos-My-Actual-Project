# **Aptos Simple Token Lottery**

## **1\. Description**

This project is a decentralized, simple, and transparent lottery smart contract built on the Aptos blockchain using the Move language. It allows an administrator to initiate a lottery with a specified ticket price and a maximum number of participants. Users can enter the lottery by purchasing a ticket. Once the maximum number of participants is reached, the contract automatically and randomly selects a winner, transferring the entire prize pool to their account.  
The core logic is contained in two main functions:

* start\_lottery: An admin-only function to initialize the lottery settings.  
* buy\_ticket: A public function for users to participate. This function also contains the logic to trigger the winner selection and payout once the lottery is full.

## **2\. Vision**

The vision behind this project is to provide a provably fair and autonomous lottery system that leverages the security and transparency of the Aptos blockchain. We aim to create a simple, trustless application where users can participate in a lottery without relying on a central authority to manage funds or select a winner. This serves as a foundational example of how decentralized applications can bring fairness and transparency to traditional games of chance.

## **3\. Future Scope**

While the current implementation is a fully functional, simple lottery, there are several features and improvements planned for the future to enhance its capabilities and security:

* **Enhanced Randomness:** Integrate a more secure source of randomness, such as a Verifiable Random Function (VRF) or an oracle, to ensure the winner selection is unpredictable and cannot be manipulated.  
* **Frontend UI:** Develop a user-friendly web interface to allow users to easily connect their wallets, view lottery details, and purchase tickets without interacting directly with the blockchain.  
* **Multiple Lotteries:** Allow the admin to create and manage multiple, concurrent lotteries with different ticket prices, prize pools, and participant limits.  
* **Admin Fees:** Introduce an optional, transparent fee mechanism where the contract owner can collect a small percentage of the prize pool as a service fee.  
* **Scheduled Draws:** Implement time-based lotteries that select a winner at a specific date and time, regardless of whether the participant cap has been reached.  
* **Support for Other Tokens:** Extend the contract to support various fungible tokens on the Aptos ecosystem, not just the native AptosCoin.

* Transaction Hash: 0x21f57d9e36cc10b44bd121475cc689034fec1d4f6640871a6a644960146c72b5
Screenshot: <img width="1796" height="1094" alt="Screenshot 2025-09-18 at 2 37 43 PM" src="https://github.com/user-attachments/assets/12290d01-06fc-4f09-a655-93b2c9390491" />
  
