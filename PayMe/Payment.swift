//
//  Payment.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class Payment: NSObject {

    var pmAmount: Double
    var pmPMID: String
    var pmPM: String
    var pmPMIC: String
    var pmBankID: String
    var pmBank: String
    var pmBankIC: String
    var pmQuotas: String
    
    override init() {
        
        self.pmAmount = 0
        self.pmPMID = ""
        self.pmPM = ""
        self.pmPMIC = ""
        self.pmBankID = ""
        self.pmBank = ""
        self.pmBankIC = ""
        self.pmQuotas = ""
    }
}
