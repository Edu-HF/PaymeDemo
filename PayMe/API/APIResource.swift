//
//  APIResource.swift
//  OsecacApp
//
//  Created by Eduardo on 3/16/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

enum APIResource: String {
    
    case mainAPIKey     = "444a9ef5-8a6b-429f-abdf-587639155d88"
    case mainURLServer  = "https://api.mercadopago.com/"
    
    //WS
    case PaymentMethods = "v1/payment_methods"
    case Banks          = "v1/payment_methods/card_issuers"
    case Quotas         = "v1/payment_methods/installments"
}
