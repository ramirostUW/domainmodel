struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int;
    var currency: String;
    
    func convert(_ targetCurrency: String)-> Money{
        var amntUSD = amount;
        if(currency == "GBP"){
            amntUSD = Int((Double(amntUSD)*2.0).rounded());
        }
        if(currency == "CAN"){
            amntUSD = Int((Double(amntUSD)/1.25).rounded());
        }
        if(currency == "EUR"){
            amntUSD = Int((Double(amntUSD)/1.5).rounded());
        }
        
        if(targetCurrency == "GBP"){
            return Money(amount: Int((Double(amntUSD)/2.0).rounded()), currency: targetCurrency)
        }
        else if (targetCurrency == "EUR"){
            return Money(amount: Int((Double(amntUSD)*1.5).rounded()), currency: targetCurrency)
        }
        else if (targetCurrency == "CAN"){
            return Money(amount: Int((Double(amntUSD)*1.25).rounded()), currency: targetCurrency)
        }
        else {
            return Money(amount: amntUSD, currency: targetCurrency);
        }
    }
    
    func add (_ secondCurrency: Money) -> Money{
        var convertedSecondCurrency = secondCurrency;
        if(convertedSecondCurrency.currency != currency){
            convertedSecondCurrency = secondCurrency.convert(currency)
        }
        return Money(amount: (amount + convertedSecondCurrency.amount), currency: currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
