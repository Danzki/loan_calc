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
    var FirstPay: Float?
    var Amount: Float?
    var Rate: Float?
    var MonthsPeriod: Int?
    var TypePay: Int?
    var StartMonth: String?
    var StartYear: String?
    
    //results of calculation
    var MonthlyPayment: Float?
    
    init() {
        FirstPay = 0.0
        Amount = 0.0
        Rate = 0.0
        MonthsPeriod = 0
        TypePay = 0
    }
    
    
}
