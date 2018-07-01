//
//  PMInteractorProtocol.swift
//  PayMe
//
//  Created by Eduardo Herrera on 30/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

protocol PMInteractorProtocol {
    
    func getPM()
    func getBanks(paymentIn: Payment)
    func getQuotas(paymentIn: Payment)
}
