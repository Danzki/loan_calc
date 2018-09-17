//
//  ThirdViewController.swift
//  loan_calc
//
//  Created by MU on 14.09.2018.
//  Copyright © 2018 Danzki.Inc. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var showPayment: UILabel!
    @IBOutlet weak var showOverPay: UILabel!
    
    var loanResult: LoanCalc = LoanCalc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPayment.text = String(loanResult.result["MonthlyPayment"]!)
        showOverPay.text = String(loanResult.result["OverPaymentAmount"]!)
        
    }
}
