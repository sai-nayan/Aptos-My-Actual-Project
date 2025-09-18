// This contract creates a simple lottery system on the Aptos blockchain.
// Replace `0xADMIN_ACCOUNT` with the address of the account deploying the contract.
module AdminAccount::token_lottery {

    // Import necessary modules from the Move standard library and Aptos framework.
    use std::signer;
    use std::vector;
    use aptos_framework::coin::{Self, Coin};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::timestamp;

    /// Error constant for when a user tries to buy a ticket with an incorrect amount.
    const EWRONG_TICKET_PRICE: u64 = 1;

    /// This resource holds all the data for our lottery.
    /// It is stored under the admin's account after deployment.
    struct LotteryData has key {
        // A dynamic list to store the addresses of all participants.
        participants: vector<address>,
        // The total prize pool, holding AptosCoin.
        pot: Coin<AptosCoin>,
        // The fixed cost to buy one lottery ticket.
        ticket_price: u64,
        // The number of participants required to trigger a draw.
        max_participants: u64,
    }

    /// Function 1: Initializes the lottery. This must be called once by the admin
    /// to create the LotteryData resource under their account.
    public fun start_lottery(admin: &signer, ticket_price: u64, max_participants: u64) {
        move_to(admin, LotteryData {
            participants: vector::empty(),
            pot: coin::zero(), // The pot starts empty.
            ticket_price,
            max_participants,
        });
    }

    /// Function 2: Allows a user to buy a ticket and enter the lottery.
    /// When the participant count hits the maximum, it automatically picks a winner,
    /// transfers the prize, and resets the lottery for the next round.
    public fun buy_ticket(participant: &signer, admin_addr: address, amount: u64) acquires LotteryData {
        let lottery = borrow_global_mut<LotteryData>(admin_addr);
        assert!(amount == lottery.ticket_price, EWRONG_TICKET_PRICE);

        // Withdraw the ticket price from the participant and add it to the pot.
        let payment = coin::withdraw<AptosCoin>(participant, amount);
        coin::merge(&mut lottery.pot, payment);
        vector::push_back(&mut lottery.participants, signer::address_of(participant));

        // If the lottery is full, it's time to draw a winner.
        if (vector::length(&lottery.participants) == lottery.max_participants) {
            // Use the block timestamp for simple, pseudo-random winner selection.
            // Note: This method is not secure enough for high-value production use.
            let winner_index = timestamp::now_seconds() % lottery.max_participants;
            let winner_addr = *vector::borrow(&lottery.participants, winner_index);

            // Transfer the entire pot to the winner and reset the participants list.
            let prize = coin::extract_all(&mut lottery.pot);
            coin::deposit(winner_addr, prize);
            lottery.participants = vector::empty();
        }
    }
}

//https://explorer.aptoslabs.com/txn/0x21f57d9e36cc10b44bd121475cc689034fec1d4f6640871a6a644960146c72b5?network=devnet
//Link to deployed URL