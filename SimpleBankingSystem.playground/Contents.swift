import UIKit

var greeting = "Hello, playground"

/*
* Classroom Coding Challenge*: Simple Banking System*
* You are tasked with creating a simple banking system with Swift. The system should support the following* features:
* /
 
 PART I: USING CLASSES.
 
 I. Create Customer Accounts: Create customer accounts with the following details:
    i.   (CHECK) Customer Name
    ii.  (CHECK) Account Number
    iii. (CHECK) Initial Balance
 
 PART II: IMPLEMENTING INHERITANCE
 
*   Support Different Account Types: 
        Implement three types of accounts -
            (CHECK) Savings
            (CHECK) Checking
            (CHECK) Business
 
*   Each account type may have specific features.
*       
        (CHECK) Deposit and Withdraw: Allow customers to deposit and withdraw money from their accounts.
        Make sure to handle overdraft for checking accounts and minimum balance for savings accounts.
 
*       (CHECK) Calculate Interest: For savings accounts, calculate and add monthly interest to the balance.
*
*       (CHECK) List All Accounts: Implement a function to list all customer accounts.
*
*       (CHECK) Transfer Funds: Implement a fund transfer feature to transfer money between two customer                accounts.
*
*       (CHECK) Calculate Total Bank Balance: Calculate the total balance of all accounts in the bank.
            
            - (CHECK) NEED: Final Balance for ALL accounts
                
              - ( Final Checking + Final Savings + Final Business )
*
*   PART III:
*   Your task is to:
        Design and implement the Swift code to achieve these functionalities. You should:
            (CHECK) use classes and
            (CHECK) inheritance to model accounts
            use structs or enums for the account types
            (CHECK) apply generics for flexible account management
            (CHECK) and employ Swift collections to store and manage customer accounts
        
        Additionally:
            (CHECK) make use of control statements for account operations
            optionals for error handling
            (CHECK) protocols and for code organization.
            (CHECK) extensions for code organization.
 
 Plus points if you add more features by yourself
 
*/
                                                                                                                                    
//  Protocol for the Bank Account
protocol Fundable
{
    //  Properties
    var initialBalance:  Double  { get set }
    var finalBalance:   Double  { get set }
    var transferAmount: Double  { get set }
    var numberOfSavingsTransfers: Int { get set }
    
    var finalBalanceChecking: Double { get set }
    var finalBalanceSavings:  Double { get set }
    var finalBalanceBusiness: Double { get set }
    
    //  Behaviors
    //  func deposit( initialBalance: Double, depositAmount: Double )
    func deposit  <T: Numeric>( initialBalance: T, depositAmount: T )
    func withdraw <T: Numeric>( initialBalance: T, withdrawalAmount: T )
    
    func transfer ( tranferAmount: Double, fromCheckingToSavings:  Bool,
                    fromCheckingToBusiness: Bool, fromSavingsToChecking:  Bool,
                    fromSavingsToBusiness:  Bool, fromBusinessToChecking: Bool,
                    fromBusinessToSavings:  Bool )
    
    //func withdraw( initialBalance: Double, withdrawalAmount: Double )
    func displayTotalBalance( totalBalance: Double, finalBalanceChecking: Double,
                              finalBalanceSavings: Double, finalBalanceBusiness: Double ) -> Double
    //func listAccounts()


}

//  Bank Account Class Implements Fundable
class BankAccount: Fundable 
{
    
    //  Our function to display the total balance in every account.
    func displayTotalBalance(totalBalance: Double, finalBalanceChecking: Double, finalBalanceSavings: Double, finalBalanceBusiness: Double) -> Double {
        let totalBalance = finalBalanceSavings + finalBalanceChecking + finalBalanceBusiness
        print( "Our final balance (for all accounts) is \(totalBalance)." )
        
        return totalBalance
    }
    
    
    //  Attributes/Variables
    //  Let's start with our constants
    let name = "Russell"
    let accountNumber = 0011419930
    let overdraftFee = 35.00
    
    //  And now our Variables
    var initialBalance: Double  = 0.00
    var finalBalance:   Double  = 0.0
    
    var finalBalanceChecking: Double = 0.0
    var finalBalanceSavings:  Double = 0.0
    var finalBalanceBusiness: Double = 0.0
    
    //  Transfer bools and vars
    var transferAmount: Double = 0.0
    var fromCheckingToSavings: Bool
    var fromCheckingToBusiness: Bool
    var fromSavingsToChecking: Bool
    var fromSavingsToBusiness: Bool
    var fromBusinessToChecking: Bool
    var fromBusinessToSavings: Bool
    
    //  Track number of transfers from the savings account.
    var numberOfSavingsTransfers = 0
    
    //  Contructor
    init( initialBalance: Double,
          finalBalance: Double,
          finalBalanceChecking: Double,
          finalBalanceSavings: Double,
          finalBalanceBusiness: Double,
          transferAmount: Double,
          fromCheckingToSavings: Bool,
          fromCheckingToBusiness: Bool,
          fromSavingsToChecking: Bool,
          fromSavingsToBusiness: Bool,
          fromBusinessToChecking: Bool,
          fromBusinessToSavings: Bool )
    {
        self.initialBalance = initialBalance
        self.finalBalance  = finalBalance
        self.finalBalanceChecking = finalBalanceChecking
        self.finalBalanceSavings  = finalBalanceSavings
        self.finalBalanceBusiness  = finalBalanceBusiness
        self.transferAmount  = transferAmount
        self.fromCheckingToSavings  = fromCheckingToSavings
        self.fromCheckingToBusiness  = fromCheckingToBusiness
        self.fromSavingsToChecking  = fromSavingsToChecking
        self.fromSavingsToBusiness  = fromSavingsToBusiness
        self.fromBusinessToChecking  = fromBusinessToChecking
        self.fromBusinessToSavings  = fromBusinessToSavings
    }
    
    //  Behaviors/Methods
    //  Deposit Funds. We use a generic so we don't have to be redundant with code reuse.
    func deposit<T: Numeric>( initialBalance: T, depositAmount: T ) {
        
        let finalBalance = initialBalance + depositAmount
        print( "Depositing \(depositAmount)" )
        
    }
    
    //  Withdraw Funds. We use a generic so we don't have to be redundant with code reuse.
    func withdraw< T: Numeric >( initialBalance: T, withdrawalAmount: T )
    {
        let finalBalance = initialBalance - withdrawalAmount
        print( "Withdrawing \(withdrawalAmount)" )
    }
    
    //  Transfer function
    func transfer ( tranferAmount: Double,
                    fromCheckingToSavings:  Bool,
                    fromCheckingToBusiness: Bool,
                    fromSavingsToChecking:  Bool,
                    fromSavingsToBusiness:  Bool,
                    fromBusinessToChecking: Bool,
                    fromBusinessToSavings:  Bool )
    {
        while numberOfSavingsTransfers < 6
        {
            if fromCheckingToSavings {
                
                finalBalanceChecking -= transferAmount
                finalBalanceSavings += transferAmount
                
                //  Increment the number of savings transfers
                numberOfSavingsTransfers += 1
                
                print( "We have transferred this amount \(transferAmount) from checking to savings.")
                
            } else if fromBusinessToSavings {
                
                finalBalanceBusiness -= transferAmount
                finalBalanceSavings += transferAmount
                
                
                //  Increment the number of savings transfers
                numberOfSavingsTransfers += 1
                
                print( "We have transferred this amount \(transferAmount) from business to savings.")
            }
        }
        
        if fromBusinessToChecking {
            
            finalBalanceBusiness -= transferAmount
            finalBalanceChecking += transferAmount
            
            print( "We have transferred this amount \(transferAmount) from business to checkings.")
            
        } else if fromSavingsToChecking {
            
            finalBalanceSavings -= transferAmount
            finalBalanceChecking += transferAmount
            
            print( "We have transferred this amount \(transferAmount) from savings to checking.")
            
        } else if fromSavingsToBusiness {
            
            finalBalanceSavings -= transferAmount
            finalBalanceBusiness += transferAmount
            
            print( "We have transferred this amount \(transferAmount) from savings to business.")
            
        } else if fromCheckingToBusiness {
            
            finalBalanceChecking -= transferAmount
            finalBalanceBusiness += transferAmount
            
            print( "We have transferred this amount \(transferAmount) from checking to business.")
            
        }
    }
}



//  Extended functionality of the Simple Banking System
extension BankAccount {
    
    func lowBalanceAlert() {
        
        if finalBalanceChecking < 10.00 {
            print( "Checking account has a low balance." )
        }
    }
}

class CheckingAccount: BankAccount
{
    let monthlyServiceFee = 5.00
    let minumumBalance = 25.00
}

class SavingsAccount: BankAccount {
    
    let apy = 0.02
    var monthsActive: Double?
    var initialSavings: Double
    
    init ( monthsActive: Double?, initialSavings: Double) {
        self.monthsActive   = monthsActive
        self.initialSavings = initialSavings
        
        super.init(initialBalance: <#T##Double#>, finalBalance: <#T##Double#>, finalBalanceChecking: <#T##Double#>, finalBalanceSavings: <#T##Double#>, finalBalanceBusiness: <#T##Double#>, transferAmount: <#T##Double#>, fromCheckingToSavings: <#T##Bool#>, fromCheckingToBusiness: <#T##Bool#>, fromSavingsToChecking: <#T##Bool#>, fromSavingsToBusiness: <#T##Bool#>, fromBusinessToChecking: <#T##Bool#>, fromBusinessToSavings: <#T##Bool#>)
    }
    
    func calculateAccruedInterest( initialSavings: Double, monthsActive: Double, apy: Double ) {
        let finalBalancePlusInterest = monthsActive * apy
        print(finalBalancePlusInterest)
    }
}

class BusinessAccount: BankAccount
{
    let monthlyServiceFee = 5.00
    let minumumBalance = 2500.00
}

var account1 = BusinessAccount(initialBalance: <Double>, finalBalance: <Double>, finalBalanceChecking: <Double>, finalBalanceSavings: <Double>, finalBalanceBusiness: <Double>, transferAmount: <Double>, fromCheckingToSavings: <Bool>, fromCheckingToBusiness: <Bool>, fromSavingsToChecking: <Bool>, fromSavingsToBusiness: <Bool>, fromBusinessToChecking: <Bool>, fromBusinessToSavings: <Bool>)

var account2 = CheckingAccount(initialBalance: <Double>, finalBalance: <Double>, finalBalanceChecking: <Double>, finalBalanceSavings: <Double>, finalBalanceBusiness: <Double>, transferAmount: <#Double#>, fromCheckingToSavings: <Bool>, fromCheckingToBusiness: <Bool>, fromSavingsToChecking: <Bool>, fromSavingsToBusiness: <Bool>, fromBusinessToChecking: <Bool>, fromBusinessToSavings: <Bool>)

var account3 = SavingsAccount(monthsActive: <Double?>, initialSavings: <Double>)


var accountCollection:[Fundable.Type] = [BusinessAccount.self,CheckingAccount.self,SavingsAccount.self]

func listAccounts ( accountCollection:[Fundable] ) {
    for i in accountCollection {
        print(accountcollection[i])
    }
}
