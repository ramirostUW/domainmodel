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
    
    var title: String;
    var type: JobType;
    
    init (title inputTitle: String, type inputType: JobType){
        title = inputTitle;
        type = inputType;
    }
    
    func calculateIncome(_ hoursWorked: Int) -> Int{
        switch type {
        case .Hourly(let hourlyWage):
            return Int((hourlyWage*Double(hoursWorked)).rounded());
        case .Salary(let salaryWage):
            return Int(salaryWage);
        }
    }
    
    func raise(byAmount: Int){
        switch type {
        case .Hourly(let hourlyWage):
            type = JobType.Hourly(hourlyWage + Double(byAmount));
        case .Salary(let salaryWage):
            type = JobType.Salary(salaryWage + UInt(byAmount));
        }
    }
    
    func raise(byAmount: Double){
        switch type {
        case .Hourly(let hourlyWage):
            type = JobType.Hourly(hourlyWage + byAmount);
        case .Salary(let salaryWage):
            type = JobType.Salary(salaryWage + UInt(byAmount));
        }
    }
    
    func raise(byPercent: Double){
        switch type {
        case .Hourly(let hourlyWage):
            type = JobType.Hourly(hourlyWage * (1.0 + byPercent));
        case .Salary(let salaryWage):
            type = JobType.Salary(UInt((Double(salaryWage) * (1.0 + byPercent)).rounded()));
        }
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
