//
//  ScientificViewController.swift
//  Assignment1-Calculator
//
//  Created by Aleixo Porpino Filho on 2018-10-14.
//  Copyright © 2018 Porpapps. All rights reserved.
//

import UIKit

class ScientificViewController: UIViewController {
    private let defaults = UserDefaults.standard
    private var userTyped = false
    private var lastButtonClicked:String? = nil;
    private let calc = Calculator()
    
    @IBOutlet weak var lblResult: UILabel!
    
    
    @IBOutlet var operatorsButton: [UIButton]!
    @IBOutlet var numbersButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = "0"
        loadButtonColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadButtonColors()
    }
    
    func loadButtonColors() {
        // Verify if it has a pre defined color in UserDefaults
        // and set the colors
        if(defaults.object(forKey: "numbersColors") != nil) {
            let decodedNumbersColors  = UserDefaults.standard.object(forKey: "numbersColors") as! Data
            let numbersColors = NSKeyedUnarchiver.unarchiveObject(with: decodedNumbersColors) as! ButtonColor
            
            for button in numbersButton {
                button.backgroundColor = UIColor(red: CGFloat(numbersColors.bgRed), green: CGFloat(numbersColors.bgGreen), blue:
                    CGFloat(numbersColors.bgBlue), alpha: 1.0)
                
                button.setTitleColor(UIColor(red: CGFloat(numbersColors.txtRed), green: CGFloat(numbersColors.txtGreen), blue:
                    CGFloat(numbersColors.txtBlue), alpha: 1.0), for: .normal)
            }
        }
        
        // Verify if it has a pre defined color in UserDefaults
        // and set the colors
        if(defaults.object(forKey: "operatorsColors") != nil) {
            let decodedOperatorsColors  = UserDefaults.standard.object(forKey: "operatorsColors") as! Data
            let operatorsColors = NSKeyedUnarchiver.unarchiveObject(with: decodedOperatorsColors) as! ButtonColor
            
            for button in operatorsButton {
                button.backgroundColor = UIColor(red: CGFloat(operatorsColors.bgRed), green: CGFloat(operatorsColors.bgGreen), blue:
                    CGFloat(operatorsColors.bgBlue), alpha: 1.0)
                
                button.setTitleColor(UIColor(red: CGFloat(operatorsColors.txtRed), green: CGFloat(operatorsColors.txtGreen), blue:
                    CGFloat(operatorsColors.txtBlue), alpha: 1.0), for: .normal)
            }
        }
    }

    // Clear event method reset all the calculator operations
    @IBAction private func onClickClear(_ sender: UIButton) {
        userTyped = false
        calc.clear()
        resultValue = calc.result
    }
    
    // Numbers and point event handler
    @IBAction private func onClickNumbers(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        let resultText = lblResult.text!
        // Verify and set the maxlength of the calculator to 9
        if resultText.count <= 9 {
            if userTyped {
                if !resultText.contains(".") || buttonText != "." {
                    lblResult.text = resultText + buttonText
                }
            } else {
                if buttonText == "." {
                    lblResult.text = "0."
                } else {
                    lblResult.text = buttonText
                }
            }
        }
        lastButtonClicked = buttonText
        userTyped = true
        
    }
    
    @IBAction private func onClickOptions(_ sender:UIButton) {
        self.tabBarController!.selectedIndex = 2
    }
    
    // Operations event handler
    @IBAction private func onClickOperations(_ sender: UIButton) {
        if userTyped {
            calc.setNumber(resultValue)
            userTyped = false
        }
        // Verify the last operations
        if let operand = sender.currentTitle {
            if (lastButtonClicked != operand ||
                (operand == "=" || operand == "π"
                    || operand == "√" || operand == "±"
                    || operand == "cos" || operand == "sin"
                    || operand == "x2" || operand == "x3"
                    || operand == "10x")) {
                
                // Exception handle to prevent crash
                do {
                    try calc.calculate(symbol: operand)
                } catch Calculator.CalcError.math(let errorMessage) { // Handle with the error treated in the calculator class and reset the values
                    lblResult.text = errorMessage
                    lastButtonClicked = operand
                    print(errorMessage)
                    userTyped = false
                    calc.clear();
                    return
                } catch {
                    lblResult.text = calc.imaginaryNumberErrorMessage
                    lastButtonClicked = operand
                    print(error)
                    calc.clear();
                    userTyped = false
                    return
                }
            }
            lastButtonClicked = operand
        }
        resultValue = calc.result
    }
    
    // get and set with some validations of the result value
    var resultValue: Double {
        get {
            if lblResult.text == "."{
                return 0.0
            } else {
                return Double(lblResult.text!)!
                
            }
        }
        set {
            // Verify the exception result as inf, -inf, nan and .0 and handle with all of these
            let txtValue = String(newValue)
            if txtValue == "inf" {
                lblResult.text = "∞" // Change inf to ∞
                calc.clear();
                userTyped = false
            } else if txtValue == "-inf" { // Change -inf to -∞
                lblResult.text = "-∞"
                calc.clear();
                userTyped = false
            } else if txtValue == "nan" { //Change nan for not a number
                lblResult.text = "Not a number"
                calc.clear();
                userTyped = false
            } else if txtValue.suffix(2) == ".0" { // Substitue the .0 in doube values for just the value itself
                lblResult.text = String(txtValue.prefix(txtValue.count - 2))
            } else if(txtValue == ".") {
                lblResult.text = "0."
            } else {
                lblResult.text = txtValue
            }
        }
    }
}
