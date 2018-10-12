//
//  ViewController.swift
//  Assignment1-Calculator
//  App Description: A simple calculator with all basic operations with additional
//  cosine, sine, square root and PI.
//
//  Created by Jose Aleixo Porpino Filho on 2018-09-22.
//  Student ID 301005491
//
//  Version 1.0.0

import UIKit


// Control class of the main view calculator
class ViewController: UIViewController {
    private let defaults = UserDefaults.standard
    private var userTyped = false
    private var lastButtonClicked:String? = nil;
    private let calc = Calculator()
    
    @IBOutlet weak var lblResult: UILabel!
    
    // Numbers Buttons
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnDot: UIButton!
    @IBOutlet weak var btnOptions: UIButton!
    
    private var numbersButton:[UIButton] = []
    
    // Operators Buttons
    @IBOutlet weak var btnAc: UIButton!
    @IBOutlet weak var btnPlusMinus: UIButton!
    @IBOutlet weak var btnSin: UIButton!
    @IBOutlet weak var btnPercentage: UIButton!
    @IBOutlet weak var btnPi: UIButton!
    @IBOutlet weak var btnSquareRoot: UIButton!
    @IBOutlet weak var btnCos: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    
    private var operatorsButton:[UIButton] = []
    
    // Set number 0 in the calculator label in the begining of load
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = "0"
        
        // Set all the numbers buttons in an array to manipulate after
        numbersButton.append(btnOptions)
        numbersButton.append(btnDot)
        numbersButton.append(btn0)
        numbersButton.append(btn1)
        numbersButton.append(btn2)
        numbersButton.append(btn3)
        numbersButton.append(btn4)
        numbersButton.append(btn5)
        numbersButton.append(btn6)
        numbersButton.append(btn7)
        numbersButton.append(btn8)
        numbersButton.append(btn9)
        
        // Set all the operators buttons in an array to manipulate after
        operatorsButton.append(btnAc)
        operatorsButton.append(btnPlusMinus)
        operatorsButton.append(btnSin)
        operatorsButton.append(btnPercentage)
        operatorsButton.append(btnPi)
        operatorsButton.append(btnSquareRoot)
        operatorsButton.append(btnCos)
        operatorsButton.append(btnDivide)
        operatorsButton.append(btnMultiply)
        operatorsButton.append(btnMinus)
        operatorsButton.append(btnPlus)
        operatorsButton.append(btnEquals)
        
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Options") as! OptionsViewController
        self.present(nextViewController, animated:true, completion:nil)
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
                    || operand == "cos" || operand == "sin")) {
                
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

