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
        var convertedCurrency = self;
        if(convertedCurrency.currency != secondCurrency.currency){
            convertedCurrency = convertedCurrency.convert(secondCurrency.currency)
        }
        return Money(amount: (secondCurrency.amount + convertedCurrency.amount), currency: secondCurrency.currency)
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
    var firstName: String;
    var lastName: String;
    var age: Int;
    private var myJob: Job?
    var job: Job?{
        get { return myJob }
        set {
            if(age >= 18){
                myJob = newValue;
            }
        }
    };
    private var mySpouse: Person?
    var spouse: Person? {
        get { return mySpouse }
        set {
            if(age >= 18){
                mySpouse = newValue;
            }
        }
    };
    
    init (firstName inputFirst: String, lastName inputLast: String,
          age inputAge: Int) {
        firstName = inputFirst;
        lastName = inputLast;
        age = inputAge;
    }
    
    func toString() -> String{
        let firstNameComp = "firstName:" + firstName + " "
        let lastNameComp = "lastName:" + lastName + " "
        let ageComp = "age:" + String(age) + " "
        var jobComp = "job:nil "
        if(job != nil){
            jobComp = "job:" + (job!.title) + " "
        }
        var spouseComp = "spouse:nil"
        if(spouse != nil){
            spouseComp = "spouse:" + spouse!.firstName
        }
        return "[Person: " + firstNameComp + lastNameComp + ageComp + jobComp + spouseComp + "]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var people: [Person]
    init(spouse1: Person, spouse2: Person){
        if(spouse1.spouse == nil && spouse2.spouse == nil){
            people = [spouse1, spouse2]
        }
        else {
            people = []
        }
    }
    
    
    func haveChild(_ newChild: Person) -> Bool{
        return false;
    }
    
    func householdIncome() -> Int {
        return 1;
    }
}
