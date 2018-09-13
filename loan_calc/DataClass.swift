//
//  DataClass.swift
//  loan_calc
//
//  Created by MU on 06.09.2018.
//  Copyright © 2018 Danzki.Inc. All rights reserved.
//

import Foundation

class LoanCalc {
    //parameters for calculation
    var paramsAmount: [String: Double]
    var paramsType: [String: Int]
    
    //results of calculation
    var result: [String: Double]
    
    init() {
        self.paramsAmount = ["FirstPay": 0.00, "Amount": 0.00, "Rate": 0.00]
        self.paramsType = ["MonthsPeriod": 0, "TypePay": 0, "Month": 1, "Year": Date().year]
        self.result = ["MonthlyPayment": 0.00, "OverPaymentAmount": 0.00]
    }
    
    func calculation(TypePay: Int) {
        if TypePay == 1 {
            annuitetCalculation()
        }
        else {
            diffCalculation()
        }
    }
    
    func annuitetCalculation() {
        //Условие: сумма кредита — 1 000 000 рублей, срок — три года (36 месяцев), ставка — 20%. Погашение осуществляется аннуитетными платежами.
        //1. Процентная ставка по кредиту в месяц = годовая процентная ставка / 12 месяцев. Пример: 20%/12 месяцев/100=0,016.
        let RateMonth: Double = self.paramsAmount["Rate"]! / 12.00 / 100.00
        
        //2. Коэффициент аннуитета = (0,016*(1+0,016)^36)/((1+0,016)^36—1)=0,03676.
        let monthPeriod = self.paramsType["MonthPeriod"]!
        let power = NSDecimalNumber(decimal: pow(Decimal(1+RateMonth), Int(monthPeriod))).doubleValue
        let CoefAnnuitet: Double = (RateMonth * Double(power)) / (Double(power)-1)
        
        //3. Ежемесячный аннуитетный платеж = 0,03676*1 000 000 рублей = 37 163,58 рубля.
        self.result["MonthlyPayment"] = self.paramsAmount["Amount"]! * CoefAnnuitet
        
        //4. Итого переплата по кредиту составила 338 000 рублей. Платеж * срок - Сумма кредита
        self.result["OverPaymentAmount"] = self.result["MonthlyPayment"]! * Double(self.paramsType["MonthsPeriod"]!) - self.paramsAmount["Amount"]!
    }
    
    func diffCalculation() {
        self.result["MonthlyPayment"] = 0
        self.result["OverPaymentAmount"] = 0
    }
    
}
