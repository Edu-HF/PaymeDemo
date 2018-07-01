//
//  DataAdapter.swift
//  PayMe
//
//  Created by Eduardo Herrera on 30/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class DataAdapter: NSObject {
    
    
    static func adaptStandardHeaders() -> [String : String] {
        
        let headers = ["Cache-Control" : "no-cache", "Content-Type" : "application/x-www-form-urlencoded"]
        return headers
    }
    
    static func adaptPM() -> [String : AnyObject] {
        
        let params = ["public_key" : APIResource.mainAPIKey.rawValue]
        return params as [String : AnyObject]
    }
    
    static func adaptBanks(paymentIn: Payment) -> [String : AnyObject] {
        
        let params = ["public_key" : APIResource.mainAPIKey.rawValue, "payment_method_id" : paymentIn.pmPMID]
        return params as [String : AnyObject]
    }
    
    static func adaptQuotas(paymentIn: Payment) -> [String : AnyObject] {
        
        let params = ["public_key" : APIResource.mainAPIKey.rawValue, "amount" : paymentIn.pmAmount, "payment_method_id" : paymentIn.pmPMID, "issuer.id" : paymentIn.pmBankID] as [String : Any]
        return params as [String : AnyObject]
    }

}
