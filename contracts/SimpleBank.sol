pragma solidity ^0.5.0;
contract SimpleBank {

    // OK - State variables

    /* OK - Fill in the keyword. Hint: We want to protect our users balance from other contracts*/
    mapping (address => uint) private balances;
    
    /* OK - Fill in the keyword. We want to create a getter function and allow contracts to be able to see if a user is enrolled.  */
    mapping (address => bool) public enrolled;

    /* Let's make sure everyone knows who owns the bank. Use the appropriate keyword for this*/
    address owner;

    // OK - Events - publicize actions to external listeners

    /* OK - Add an argument for this event, an accountAddress */
    event LogEnrolled(address indexed accountAddress);

    /* OK - Add 2 arguments for this event, an accountAddress and an amount */
    event LogDepositMade(address indexed accountAddress, uint amount);

    /* OK - Create an event called LogWithdrawal */
    /* OK - Add 3 arguments for this event, an accountAddress, withdrawAmount and a newBalance */
    event LogWithdrawal(address indexed accountAddress, uint withdrawAmount, uint newBalance);

    // OK - Functions

    /* OK - Use the appropriate global variable to get the sender of the transaction */
    constructor() public {
        owner = msg.sender;
    }


    // OK - A SPECIAL KEYWORD prevents function from editing state variables; allows function to run locally/off blockchain
    // @return The balance of the user
    function balance() public view returns (uint) {
        return balances[msg.sender];
    }


    /// @notice Enroll a customer with the bank
    /// @return The users enrolled status
    // Emit the appropriate event
    function enroll() public returns (bool){
        enrolled[msg.sender] = true;
        emit LogEnrolled(msg.sender);
        return (enrolled[msg.sender]);
    }

    // OK - @notice Deposit ether into bank
    // OK - @return The balance of the user after the deposit is made
    // OK - Add the appropriate keyword so that this function can receive ether
    // OK - Use the appropriate global variables to get the transaction sender and value
    // OK - Emit the appropriate event
    // OK - Add the amount to the user's balance, call the event associated with a deposit, then return the balance of the user */
    
    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    // @notice Withdraw ether from bank
    // @dev This does not return any excess ether sent to it
    // @param withdrawAmount amount you want to withdraw
    // @return The balance remaining for the user
    // Emit the appropriate event    
    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        require(withdrawAmount <= balances[msg.sender], 'error b/c amount greater than balance');
        balances[msg.sender] -= withdrawAmount;
        msg.sender.transfer(withdrawAmount);
        emit LogWithdrawal(msg.sender, withdrawAmount, balances[msg.sender]);
        return balances[msg.sender];
    
    //* If the sender's balance is at least the amount they want to withdraw,
    // Subtract the amount from the sender's balance, and try to send that amount of ether
    // to the user attempting to withdraw. 
    // return the user's balance.*/
    }
    // Fallback function - Called if other functions don't match call or
    // sent ether without data
    // Typically, called when invalid data is sent
    // Added so ether sent to this contract is reverted if the contract fails
    // otherwise, the sender's money is transferred to contract
    // function() {
    //     revert();
    // }
}
