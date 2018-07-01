//
//  Quotas.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import Gloss

class Quotas: NSObject, Glossy {

    var qID: Int
    var qMSG: String
    
    required init?(json: JSON) {
        
        guard let qID: Int = "installments" <~~ json else { return nil }
        
        self.qID = qID
        self.qMSG = "recommended_message" <~~ json ?? ""
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
