//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Sebastian on 2/29/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    
    @IBOutlet weak var textFiled: UITextField!
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var farenheitVaule: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = farenheitVaule {
            return (value - 32) * 5/9
        } else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(sender: UITextField) {
        
        if let text = sender.text, value = Double(text) {
            farenheitVaule = value
        } else {
            farenheitVaule = nil
        }
    }
    
    @IBAction func dissmissKeyboardTap(sender: UITapGestureRecognizer) {
        textFiled.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //change background color accarding to time of day
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: NSDate())
        let hour = components.hour
        
        if hour > 19 || hour < 5 {
            view.backgroundColor = UIColor.darkGrayColor()
        } else {
            view.backgroundColor = UIColor.lightGrayColor()
        }

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textFiled.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        let nonNumbers = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil  {
            return false
        } else if string.rangeOfCharacterFromSet(nonNumbers) != nil {
            return false
        } else {
            return true
        }
    }
}
