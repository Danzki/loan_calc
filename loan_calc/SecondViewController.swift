//
//  ViewController.swift
//  loan_calc
//
//  Created by MU on 29.08.2018.
//  Copyright © 2018 Danzki.Inc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var monthBox: UITextField!
    @IBOutlet weak var yearBox: UITextField!
    @IBOutlet weak var FirstPayField: UITextField!
    @IBOutlet weak var SummaField: UITextField!
    @IBOutlet weak var RateField: UITextField!
    @IBOutlet weak var MonthsField: UITextField!
    @IBOutlet weak var cButton: UIButton!
    
    //textFields validation
    @IBAction func validateSummaField(_ sender: UITextField) {
        if allowOnlyNumbersInTextField(string: sender.text!) {
            SummaValid = true
            if checkValid() {
                cButton.isEnabled = true
            }
        }
        else
        {
            sender.setFullBorder(borderColor: UIColor.red)
            cButton.isEnabled = false
        }
    }
    
    @IBAction func validateFirstPay(_ sender: UITextField) {
        if allowOnlyNumbersInTextField(string: sender.text!) {
            FirstPayValid = true
            if checkValid() {
                cButton.isEnabled = true
            }
        }
        else
        {
            sender.setFullBorder(borderColor: UIColor.red)
            cButton.isEnabled = false
        }
    }
    
    @IBAction func validateRate(_ sender: UITextField) {
        if allowOnlyNumbersInTextField(string: sender.text!) {
            RateValid = true
            if checkValid() {
                cButton.isEnabled = true
            }
        }
        else
        {
            sender.setFullBorder(borderColor: UIColor.red)
            cButton.isEnabled = false
        }
    }
    
    
    @IBAction func validateMonths(_ sender: UITextField) {
        if allowOnlyNumbersInTextField(string: sender.text!) {
            MonthsValid = true
            if checkValid() {
                cButton.isEnabled = true
            }
        }
        else
        {
            sender.setFullBorder(borderColor: UIColor.red)
            cButton.isEnabled = false
        }
    }
    
    //on edit actions
    @IBAction func editSumma(_ sender: Any) {
        SummaField.setBottomBorder(borderColor: UIColor.gray)
    }
    
    @IBAction func firstPayEdit(_ sender: Any) {
        FirstPayField.setBottomBorder(borderColor: UIColor.gray)
    }
    
    @IBAction func rateEdit(_ sender: Any) {
        RateField.setBottomBorder(borderColor: UIColor.gray)
    }
    
    @IBAction func monthsEdit(_ sender: Any) {
        MonthsField.setBottomBorder(borderColor: UIColor.gray)
    }
    
    
    //Button action
    @IBAction func calcButton(_ sender: UIButton) {
        //TODO: assign inputs to certain parameter of object
        self.loan.paramsAmount["FirstPay"] = Double(FirstPayField.text!)
        self.loan.paramsAmount["Amount"] = Double(SummaField.text!)
        self.loan.paramsAmount["Rate"] = Double(RateField.text!)
        self.loan.paramsType["MonthsPeriod"] = Int(MonthsField.text!)
        
        //TODO: call Loan.calculate method
        self.loan.calculation(TypePay: loan.paramsType["TypePay"]!)
    }
    
    var typePay = ["Аннуитетный", "Дифференцированный" ]
    var months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь" ]
    var years = (Date().year...2100).map { x in "\(x)" }
    var pickerPay = UIPickerView()
    var pickerMonth = UIPickerView()
    var pickerYear = UIPickerView()
    
    var loan = LoanCalc()
    
    var FirstPayValid: Bool = false
    var SummaValid: Bool = false
    var RateValid: Bool = false
    var MonthsValid: Bool = false
    
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
        
        FirstPayField.setBottomBorder(borderColor: UIColor.gray)
        SummaField.setBottomBorder(borderColor: UIColor.gray)
        RateField.setBottomBorder(borderColor: UIColor.gray)
        MonthsField.setBottomBorder(borderColor: UIColor.gray)
        
        textBox.text = typePay[0]
        monthBox.text = months[Date().month]
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
        //TypePay picker -
        if pickerView == pickerPay {
            loan.paramsType["TypePay"] = row
            textBox.text = typePay[row]
        }
        else if pickerView == pickerMonth {
            loan.paramsType["Month"] = row
            monthBox.text = months[row]
        }
        else if pickerView == pickerYear {
            loan.paramsType["Year"] = row
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ThirdViewController
        vc.loanResult = self.loan
    }
    
    func allowOnlyNumbersInTextField(string : String)->Bool{
        let numberCharacterSet = NSCharacterSet.decimalDigits
        let inputString = string
        let range = inputString.rangeOfCharacter(from: numberCharacterSet)
        // range will be nil if no numbers are found
        if range != nil {
            return true
        }
        else {
            return false
            // do your stuff
        }
    }
    
    func checkValid()->Bool{
        if SummaValid && FirstPayValid && MonthsValid && RateValid {
            return true
        }
        else {
            return false
        }
    }
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
    
    func setFullBorder(borderColor: UIColor)
    {
        self.borderStyle = UITextBorderStyle.line
        self.backgroundColor = borderColor
    }
}

extension Date{
    var day:Int {return Calendar.current.component(.day, from:self)}
    var month:Int {return Calendar.current.component(.month, from:self)}
    var year:Int {return Calendar.current.component(.year, from:self)}
}
