//
//  PMInteractor.swift
//  PayMe
//
//  Created by Eduardo Herrera on 24/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import Gloss

class PMInteractor: NSObject, PMInteractorProtocol, InteractorOutputProtocol {
    
    var dataManager: DataManagerProtocol?
    var mainPMPresenter: PMPresenter?
    let headers = DataAdapter.adaptStandardHeaders()
    let notificationCenter = NotificationCenter.default
    
    required init(pmPresenter: PMPresenter) {
        
        dataManager = DataManager.sharedInstance
        mainPMPresenter = pmPresenter
    }
    
    //PMInteractorProtocol
    func getPM() {
        
        let params = DataAdapter.adaptPM()
        let handler = ResponseHandler(onSuccess: { info in
            
            let pmArray: NSArray? = info["Response"] as? NSArray
            var pmData: [PM] = []
            if pmArray != nil {
                for pm in pmArray! {
                    if let tempPM = PM(json: pm as! JSON) {
                        pmData.append(tempPM)
                    }
                }
                self.mainPMPresenter?.mainPMData = pmData
            }
            
            NotificationCenter.default.post(.init(name: .wsSetDataToView))
            
        }, output: self)
        
        dataManager?.getPaymentMethods(headers: headers, params: params, handler: handler);
    }
    
    func getBanks(paymentIn: Payment) {
        
        let params = DataAdapter.adaptBanks(paymentIn: paymentIn)
        let handler = ResponseHandler(onSuccess: { info in
            
            let banksArray: NSArray? = info["Response"] as? NSArray
            var banksData: [Banks] = []
            if banksArray != nil {
                for bank in banksArray! {
                    if let tempBank = Banks(json: bank as! JSON) {
                        banksData.append(tempBank)
                    }
                }
                self.mainPMPresenter?.mainBankData = banksData
            }
            
            NotificationCenter.default.post(.init(name: .wsSetDataToView))
            
        }, output: self)
        
        dataManager?.getBanks(headers: headers, params: params, handler: handler);
    }
    
    func getQuotas(paymentIn: Payment) {
        
        let params = DataAdapter.adaptQuotas(paymentIn: paymentIn)
        let handler = ResponseHandler(onSuccess: { info in
            
            if let qJSON = info["Response"] as? NSArray {
                if let qBodyJson = qJSON[0] as? JSON {
                    let qArray: NSArray? = qBodyJson["payer_costs"] as? NSArray
                    var qData: [Quotas] = []
                    if qArray != nil {
                        for quota in qArray! {
                            if let tempQuota = Quotas(json: quota as! JSON) {
                                qData.append(tempQuota)
                            }
                        }
                        self.mainPMPresenter?.mainQuotasData = qData
                    }
                }
            }
            
            NotificationCenter.default.post(.init(name: .wsSetDataToView))
            
        }, output: self)
        
        dataManager?.getQuotas(headers: headers, params: params, handler: handler);
    }
    
    //InteractorOutputProtocol
    func onFailure(_ failure: AnyObject) {
        
    }
    
    func onError(_ error: AnyObject) {
        
    }
}
