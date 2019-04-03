import UIKit
/*
func methodNoVariables(){
    print("This is first Line")
    print("This is Second Line")
    print("This is Third Line")
}


func methodWithVariables(str1 : String, myInt: Int){
    
    print("string value =  \(str1)")
    print("int value =  \(myInt)")
}

func methodWithReturnValues(a : Int, b: Int) -> Int{
    let c = a + b
    return c
}

func methodWithMultipleReturnValues(a: Int, b: Int) ->(Int, Int){
    let sum = a + b
    let prod = a * b
    
    return (sum, prod)
    
}

methodNoVariables()

methodWithVariables(str1: "Ashish", myInt: 5)

let sum = methodWithReturnValues(a: 5, b: 6)
print("Sum = \(sum)")


let multipleReturn = methodWithMultipleReturnValues(a: 5, b: 6)

print(multipleReturn.0)
print(multipleReturn.1)

 */




func bmiCalculator(weight: Int, height: Double) -> String {
    
    let bmi = Double(weight) / (height * height)
    
    if(bmi >= 30){
        return "Obese"
    }
    
    if(bmi >= 25 && bmi < 30 ){
        return "Overweight"
    }
    if(bmi >= 18.5 && bmi < 25){
        return "Normal Weight"
    }
    

    return "Underweight"
    
    
}

func BMICalculatorImperial(weight: Double, heightFeet: Double, heightInches: Double, imperialUnits: Bool) -> String{
    
    var wt = weight
    if(imperialUnits == true){
        wt *= 0.453592
    }
    // Convert height from ft inches to meters
    
    let  height = (( heightFeet * 12  + heightInches ) * 2.54 ) / 100
    
    let bmi = wt / (height * height)
    
    if(bmi >= 30){
        return "Obese"
    }
    
    if(bmi >= 25 && bmi < 30 ){
        return "Overweight"
    }
    if(bmi >= 18.5 && bmi < 25){
        return "Normal Weight"
    }
    return "Underweight"
}

bmiCalculator(weight: 60, height: 1.524)

BMICalculatorImperial(weight: 165, heightFeet: 5, heightInches: 10, imperialUnits: true)
