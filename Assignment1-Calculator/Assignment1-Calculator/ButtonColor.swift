//
//  ColorPicker.swift
//  Assignment1-Calculator
//
//  Created by Aleixo Porpino Filho on 2018-10-11.
//  Student ID 301005491
//
//  Version 1.0.0
//

import Foundation

// Model class to control the button colors variables
class ButtonColor: NSObject, NSCoding {
    
    
    public var bgRed:Float = 0.0
    public var bgGreen:Float = 0.0
    public var bgBlue:Float = 0.0
    
    public var txtRed:Float = 0.0
    public var txtGreen:Float = 0.0
    public var txtBlue:Float = 0.0
    
    // Default constructor method
    init(bgRed: Float, bgGreen: Float, bgBlue: Float,
        txtRed:Float, txtGreen:Float, txtBlue: Float) {
        self.bgRed = bgRed
        self.bgGreen = bgGreen
        self.bgBlue = bgBlue
        self.txtRed = txtRed
        self.txtGreen = txtGreen
        self.txtBlue = txtBlue
    }
    
    // Required to work the UserDefaults
    required init?(coder aDecoder: NSCoder) {
        self.bgRed = aDecoder.decodeObject(forKey: "bgRed") as? Float ?? aDecoder.decodeFloat(forKey: "bgRed")
        self.bgGreen = aDecoder.decodeObject(forKey: "bgGreen") as? Float ?? aDecoder.decodeFloat(forKey: "bgGreen")
        self.bgBlue = aDecoder.decodeObject(forKey: "bgBlue") as? Float ?? aDecoder.decodeFloat(forKey: "bgBlue")
        self.txtRed = aDecoder.decodeObject(forKey: "txtRed") as? Float ??
            aDecoder.decodeFloat(forKey: "txtRed")
        self.txtGreen = aDecoder.decodeObject(forKey: "txtGreen") as? Float ??
            aDecoder.decodeFloat(forKey: "txtGreen")
        self.txtBlue = aDecoder.decodeObject(forKey: "txtBlue") as? Float ??
        aDecoder.decodeFloat(forKey: "txtBlue")
    }
    
    // Override method for NSCoding to save in UserDefaults
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bgRed, forKey : "bgRed")
        aCoder.encode(bgGreen, forKey : "bgGreen")
        aCoder.encode(bgBlue, forKey : "bgBlue")
        aCoder.encode(txtRed, forKey : "txtRed")
        aCoder.encode(txtGreen, forKey : "txtGreen")
        aCoder.encode(txtBlue, forKey : "txtBlue")
    }
    
    // Put all the labels response in the get method
    public var labelBgRed: String {
        get {
            return "Red: " + String(format: "%0.0f", (bgRed * 255))
        }
    }
    public var labelBgGreen:String {
        get {
            return "Green: " + String(format: "%0.0f", (bgGreen * 255))
        }
    }
    public var labelBgBlue:String {
        get {
            return "Blue: " + String(format: "%0.0f", (bgBlue * 255))
        }
    }
    
    public var labelTxtRed:String {
        get {
            return "Red: " + String(format: "%0.0f", (txtRed * 255))
        }
    }
    public var labelTxtGreen:String {
        get {
            return "Green: " + String(format: "%0.0f", (txtGreen * 255))
        }
    }
    public var labelTxtBlue:String {
        get {
            return "Blue: " + String(format: "%0.0f", (txtBlue * 255))
        }
    }
}
