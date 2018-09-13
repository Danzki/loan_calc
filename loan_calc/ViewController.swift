//
//  ViewController.swift
//  loan_calc
//
//  Created by MU on 29.08.2018.
//  Copyright © 2018 Danzki.Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var monthBox: UITextField!
    @IBOutlet weak var yearBox: UITextField!
    
    var typePay = ["Аннуитетный", "Дифференцированный" ]
    var months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь" ]
    var years = (Date().year...2100).map { x in "\(x)" }
    var pickerPay = UIPickerView()
    var pickerMonth = UIPickerView()
    var pickerYear = UIPickerView()
    
    var currentCalc = LoanCalc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerPay.delegate = self
        pickerPay.dataSource = self
        pickerMonth.delegate = self
        pickerMonth.dataSource = self
        pickerYear.delegate = self
        pickerYear.dataSource = self
        textBox.inputView = pickerPay
        monthBox.inputView = pickerMonth
        yearBox.inputView = pickerYear
        
        textBox.setBottomBorder(borderColor: UIColor.darkGray)
        textBox.text = typePay[0]
        monthBox.text = months[0]
        yearBox.text = years[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows: Int = typePay.count
        if pickerView == pickerMonth {
            countrows = months.count
        }
        else if pickerView == pickerYear {
            countrows = years.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerPay {
            textBox.text = typePay[row]
        }
        else if pickerView == pickerMonth {
            monthBox.text = months[row]
        }
        else if pickerView == pickerYear {
            yearBox.text = years[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerPay {
            let titlerow = typePay[row]
            return titlerow
        }
        else if pickerView == pickerMonth {
            let titlerow = months[row]
            return titlerow
        }
        else if pickerView == pickerYear {
            let titlerow = years[row]
            return titlerow
        }
        
        return title
    }
    
    
    //calculate
    //@IBAction func Push(_ sender: UIButton, forEvent event: UIEvent) {
        
    //}
    
    

}

extension UITextField
{
    func setBottomBorder(borderColor: UIColor)
    {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width = 1.0

        let borderLine = UIView()
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(self.frame.width), height: width)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

extension Date{
    var day:Int {return Calendar.current.component(.day, from:self)}
    var month:Int {return Calendar.current.component(.month, from:self)}
    var year:Int {return Calendar.current.component(.year, from:self)}
}
