//
//  DataManagerProtocol.swift
//  PayMe
//
//  Created by Eduardo Herrera on 30/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

protocol DataManagerProtocol {
    
    func getPaymentMethods(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler)
    func getBanks(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler)
    func getQuotas(headers: [String : String], params: [String : AnyObject], handler: ResponseHandler)
}
