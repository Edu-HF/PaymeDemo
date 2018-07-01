//
//  PMPresenter.swift
//  PayMe
//
//  Created by Eduardo Herrera on 24/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PMPresenter: NSObject {
    
    var mainPayment: Payment!
    var mainBankData: [Banks]!
    var mainPMData: [PM]!
    var mainQuotasData: [Quotas]!
    private var mainPMInteractor: PMInteractorProtocol!
    
    override init() {
        super.init()
        loadProperties()
    }
    
    func loadProperties() {
        self.mainPayment = Payment()
        self.mainBankData = []
        self.mainPMData = []
        self.mainQuotasData = []
        self.mainPMInteractor = PMInteractor.init(pmPresenter: self)
    }
    
    func updateAmountOnPayment(amountIn: Double) {
        mainPayment.pmAmount = amountIn
    }
    
    func updatePMOnPayment(pmIn: PM) {
        mainPayment.pmPMID = pmIn.pmID
        mainPayment.pmPM = pmIn.pmName
        mainPayment.pmPMIC = pmIn.pmIC
    }
    
    func updateBankOnPayment(bankIn: Banks) {
        mainPayment.pmBankID = bankIn.bankID
        mainPayment.pmBank = bankIn.bankName
        mainPayment.pmBankIC = bankIn.bankIC
    }
    
    func updateQuotaOnPayment(quotaIn: Quotas) {
        mainPayment.pmQuotas = quotaIn.qMSG
    }
    
    func getPM() {
        self.mainPMInteractor.getPM()
    }
    
    func getBanks() {
        self.mainPMInteractor.getBanks(paymentIn: mainPayment)
    }
    
    func getQuotas() {
        self.mainPMInteractor.getQuotas(paymentIn: mainPayment)
    }
    
    func setDataToView(){}
}
