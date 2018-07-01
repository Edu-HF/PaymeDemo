//
//  DataManager.swift
//  PayMe
//
//  Created by Eduardo Herrera on 30/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class DataManager: NSObject, DataManagerProtocol {
    
    static let sharedInstance: DataManagerProtocol = DataManager()
    fileprivate var clientAPI: APIClient
    
    override init() {
        
        clientAPI = APIClient(serverURL: APIResource.mainURLServer.rawValue)
    }
    
    func getPaymentMethods(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler) {
        clientAPI.requestGET(url: APIResource.PaymentMethods.rawValue, params: params, qParams: nil, headers: headers, handler: handler)
    }
    
    func getBanks(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler) {
        clientAPI.requestGET(url: APIResource.Banks.rawValue, params: params, qParams: nil, headers: headers, handler: handler)
    }
    
    func getQuotas(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler) {
        clientAPI.requestGET(url: APIResource.Quotas.rawValue, params: params, qParams: nil, headers: headers, handler: handler)
    }
}
