//
//  OptionsViewController.swift
//  Assignment1-Calculator
//
//  Created by Aleixo Porpino Filho on 2018-10-11.
//  Student ID 301005491
//
//  Version 1.0.0

import UIKit

class OptionsViewController: UIViewController {

    let defaults = UserDefaults.standard
    // Background numbers
    @IBOutlet weak var bgNumbersRedLabel: UILabel!
    @IBOutlet weak var bgNumbersGreenLabel: UILabel!
    @IBOutlet weak var bgNumbersBlueLabel: UILabel!
    @IBOutlet weak var bgNumbersRedSlider: UISlider!
    @IBOutlet weak var bgNumbersGreenSlider: UISlider!
    @IBOutlet weak var bgNumbersBlueSlider: UISlider!
    
    // Background operators
    @IBOutlet weak var bgOperatorsRedLabel: UILabel!
    @IBOutlet weak var bgOperatorsGreenLabel: UILabel!
    @IBOutlet weak var bgOperatorsBlueLabel: UILabel!
    @IBOutlet weak var bgOperatorsRedSlider: UISlider!
    @IBOutlet weak var bgOperatorsGreenSlider: UISlider!
    @IBOutlet weak var bgOperatorsBlueSlider: UISlider!
    
    // Text numbers
    @IBOutlet weak var txtNumbersRedLabel: UILabel!
    @IBOutlet weak var txtNumbersGreenLabel: UILabel!
    @IBOutlet weak var txtNumbersBlueLabel: UILabel!
    @IBOutlet weak var txtNumbersRedSlider: UISlider!
    @IBOutlet weak var txtNumbersGreenSlider: UISlider!
    @IBOutlet weak var txtNumbersBlueSlider: UISlider!
    
    // Text operators
    @IBOutlet weak var txtOperatorsRedLabel: UILabel!
    @IBOutlet weak var txtOperatorsGreenLabel: UILabel!
    @IBOutlet weak var txtOperatorsBlueLabel: UILabel!
    @IBOutlet weak var txtOperatorsRedSlider: UISlider!
    @IBOutlet weak var txtOperatorsGreenSlider: UISlider!
    @IBOutlet weak var txtOperatorsBlueSlider: UISlider!
    
    // Result Examples
    @IBOutlet weak var numbersResult: UIButton!
    @IBOutlet weak var operatorsResult: UIButton!
    @IBOutlet weak var applyChangesButton: UIButton!
    
    // Button colors variables
    private var numbersColors = ButtonColor(bgRed: 0.0,bgGreen: 0.0,bgBlue: 0.0,txtRed: 0.0,txtGreen: 0.0,txtBlue: 0.0)
    private var operatorsColors = ButtonColor(bgRed: 0.0,bgGreen: 0.0,bgBlue: 0.0,txtRed: 0.0,txtGreen: 0.0,txtBlue: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Verify if its colors saved in UserDefaults.
        if(defaults.object(forKey: "numbersColors") != nil) {
            let decodedNumbersColors  = UserDefaults.standard.object(forKey: "numbersColors") as! Data
            let numbersColors = NSKeyedUnarchiver.unarchiveObject(with: decodedNumbersColors) as! ButtonColor
            
            self.numbersColors = numbersColors
        }
        if(defaults.object(forKey: "operatorsColors") != nil) {
            let decodedOperatorsColors  = UserDefaults.standard.object(forKey: "operatorsColors") as! Data
            let operatorsColors = NSKeyedUnarchiver.unarchiveObject(with: decodedOperatorsColors) as! ButtonColor
        
            self.operatorsColors = operatorsColors
        }
        setSlidersValues()
        changeColors()
        changeApplyChangesColors()
    }
    
    // Set initially the sliders values
    func setSlidersValues() {
        bgNumbersRedSlider.value = numbersColors.bgRed
        bgNumbersGreenSlider.value = numbersColors.bgGreen
        bgNumbersBlueSlider.value = numbersColors.bgBlue
        
        txtNumbersRedSlider.value = numbersColors.txtRed
        txtNumbersGreenSlider.value = numbersColors.txtGreen
        txtNumbersBlueSlider.value = numbersColors.txtBlue
        
        bgOperatorsRedSlider.value = operatorsColors.bgRed
        bgOperatorsGreenSlider.value = operatorsColors.bgGreen
        bgOperatorsBlueSlider.value = operatorsColors.bgBlue
        
        txtOperatorsRedSlider.value = operatorsColors.txtRed
        txtOperatorsGreenSlider.value = operatorsColors.txtGreen
        txtOperatorsBlueSlider.value = operatorsColors.txtBlue
    }
    
    // Call the function that change the colors
    @IBAction func onSliderChange() {
        changeColors()
    }
    
    // Change the colors with the sliders values
    func changeColors() {
        changeLabels()
        
        // Numbers
        numbersColors.bgRed = bgNumbersRedSlider.value
        numbersColors.bgGreen = bgNumbersGreenSlider.value
        numbersColors.bgBlue = bgNumbersBlueSlider.value
        
        numbersResult.backgroundColor = UIColor(red: CGFloat(numbersColors.bgRed), green: CGFloat(numbersColors.bgGreen), blue:
            CGFloat(numbersColors.bgBlue), alpha: 1.0)
        
        numbersColors.txtRed = txtNumbersRedSlider.value
        numbersColors.txtGreen = txtNumbersGreenSlider.value
        numbersColors.txtBlue = txtNumbersBlueSlider.value
        
        numbersResult.setTitleColor(UIColor(red: CGFloat(numbersColors.txtRed), green: CGFloat(numbersColors.txtGreen), blue:
            CGFloat(numbersColors.txtBlue), alpha: 1.0), for: .normal)
        
        // Operators
        operatorsColors.bgRed = bgOperatorsRedSlider.value
        operatorsColors.bgGreen = bgOperatorsGreenSlider.value
        operatorsColors.bgBlue = bgOperatorsBlueSlider.value
        
        operatorsResult.backgroundColor = UIColor(red: CGFloat(operatorsColors.bgRed), green: CGFloat(operatorsColors.bgGreen), blue:
            CGFloat(operatorsColors.bgBlue), alpha: 1.0)
        
        operatorsColors.txtRed = txtOperatorsRedSlider.value
        operatorsColors.txtGreen = txtOperatorsGreenSlider.value
        operatorsColors.txtBlue = txtOperatorsBlueSlider.value
        
        operatorsResult.titleLabel?.textColor = UIColor(red: CGFloat(operatorsColors.txtRed), green: CGFloat(operatorsColors.txtGreen), blue:
            CGFloat(operatorsColors.txtBlue), alpha: 1.0)
        
        operatorsResult.setTitleColor(UIColor(red: CGFloat(operatorsColors.txtRed), green: CGFloat(operatorsColors.txtGreen), blue:
            CGFloat(operatorsColors.txtBlue), alpha: 1.0), for: .normal)
    }
    
    // Change the sliders labels
    func changeLabels() {
        bgNumbersRedLabel.text = numbersColors.labelBgRed
        bgNumbersGreenLabel.text = numbersColors.labelBgGreen
        bgNumbersBlueLabel.text = numbersColors.labelBgBlue
        
        txtNumbersRedLabel.text = numbersColors.labelTxtRed
        txtNumbersGreenLabel.text = numbersColors.labelTxtGreen
        txtNumbersBlueLabel.text = numbersColors.labelTxtBlue
        
        bgOperatorsRedLabel.text = operatorsColors.labelBgRed
        bgOperatorsGreenLabel.text = operatorsColors.labelBgGreen
        bgOperatorsBlueLabel.text = operatorsColors.labelBgBlue
        
        txtOperatorsRedLabel.text = operatorsColors.labelTxtRed
        txtOperatorsGreenLabel.text = operatorsColors.labelTxtGreen
        txtOperatorsBlueLabel.text = operatorsColors.labelTxtBlue
        
    }
    // Apply the selected colors
    @IBAction func onApplyChanges() {
        changeApplyChangesColors()
        
        let encodedNumbersColors = NSKeyedArchiver.archivedData(withRootObject: numbersColors)
        defaults.set(encodedNumbersColors, forKey:"numbersColors")
        
        let encodedOperatorsColors = NSKeyedArchiver.archivedData(withRootObject: operatorsColors)
        defaults.set(encodedOperatorsColors, forKey:"operatorsColors")
        
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        //let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! ViewController
        //self.present(nextViewController, animated:true, completion:nil)
    }
    
    func changeApplyChangesColors() {
        applyChangesButton.backgroundColor = UIColor(red: CGFloat(numbersColors.bgRed), green: CGFloat(numbersColors.bgGreen), blue:
        CGFloat(numbersColors.bgBlue), alpha: 1.0)
        
        applyChangesButton.setTitleColor(UIColor(red: CGFloat(numbersColors.txtRed), green: CGFloat(numbersColors.txtGreen), blue:
        CGFloat(numbersColors.txtBlue), alpha: 1.0), for: .normal)
        
    }
    
}
