//
//  Calculator.swift
//  Assignment1-Calculator
//  App Description: A simple calculator with all basic operations with additional
//  cosine, sine, square root and PI.
//
//  Created by Jose Aleixo Porpino Filho on 2018-09-22.
//  Student ID 301005491
//
//  Version 1.0.0

import Foundation

// Model class to handle with all the calculator operations and rules
class Calculator {
    
    private var firstNumber:Double? = nil
    
    private var storedNumberContinuousEquals:Double? = nil
    
    private var pressedEquals = false
    
    private var lastNumber = 0.0
    
    private var operatorSelected:String? = nil
    
    let imaginaryNumberErrorMessage = "Imaginary number"
    
    //Enum with the exceptions
    public enum CalcError:Error {
        case math(String)
    }
    
    // Set the number
    func setNumber(_ number: Double) {
        lastNumber = number
    }
    
    // Handle all the calculations
    func calculate(symbol: String) throws {
        switch symbol {
        case "π":
            lastNumber = Double.pi
            pressedEquals = false
        case "√":
            pressedEquals = false
            if lastNumber >= 0 {
                lastNumber = sqrt(lastNumber)
            } else {
                throw CalcError.math(imaginaryNumberErrorMessage)
            }
        case "cos":
            lastNumber = cos(lastNumber)
            pressedEquals = false
        case "sin":
            lastNumber = sin(lastNumber)
            pressedEquals = false
        case "tan":
            lastNumber = tan(lastNumber)
            pressedEquals = false
        case "x2":
            lastNumber = pow(lastNumber, 2)
            pressedEquals = false
        case "x3":
            lastNumber = pow(lastNumber, 3)
            pressedEquals = false
        case "10x":
            lastNumber = pow(10, lastNumber)
            pressedEquals = false
        case "%":
            if firstNumber != nil {
                lastNumber = firstNumber! * (lastNumber / 100)
            } else {
                lastNumber = lastNumber / 100
            }
            
            pressedEquals = false
        case "±":
            if lastNumber != 0 {
                lastNumber = -lastNumber
            }
            pressedEquals = false
        case "+", "-", "x", "÷":
            if !pressedEquals && (operatorSelected == nil || operatorSelected == symbol) {
                equals()
                firstNumber = lastNumber
            }
            operatorSelected = symbol
            pressedEquals = false
        case "=":
            // Verify if equals was pressed and pass the stored number to lastnumber in order to do the same operation if press equals many times
            if pressedEquals {
                lastNumber = storedNumberContinuousEquals!
            }
            storedNumberContinuousEquals = lastNumber
            pressedEquals = true
            equals();
        default:
            break
        }
    }
    
    
    // Equals method pass the calculation to lastNumber typed and the lastNumber typed is the first operation right now to keep working after pressing equals many times
    private func equals() {
        
        if let first = firstNumber {
            switch operatorSelected {
            case "+":
                lastNumber = sum(first,lastNumber)
                firstNumber = lastNumber
            case "-":
                lastNumber = subtract(first,lastNumber)
                firstNumber = lastNumber
            case "x":
                lastNumber = multiply(first,lastNumber)
                firstNumber = lastNumber
            case "÷":
                lastNumber = divide(first,lastNumber)
                firstNumber = lastNumber
            default:
                break
            }
        }
        
    }
    
    // Sum two values
    private func sum(_ value1:Double,_ value2:Double) -> Double {
        return value1 + value2;
    }
    // Subtract two values
    private func subtract(_ value1:Double,_ value2:Double) -> Double {
        return value1 - value2;
    }
    // Multiply two values
    private func multiply(_ value1:Double,_ value2:Double) -> Double {
        return value1 * value2;
    }
    // Divide two values
    private func divide(_ value1:Double,_ value2:Double) -> Double {
        return value1 / value2;
    }
    
    // Clear all the operations of the calculator method
    func clear(){
        storedNumberContinuousEquals = nil
        pressedEquals = false
        firstNumber = nil
        operatorSelected = nil
        setNumber(0)
    }
    
    // Get method of the result of the last value calculated
    var result: Double {
        get {
            return lastNumber
        }
    }
}
