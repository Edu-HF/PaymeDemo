//
//  Banks.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import Gloss

class Banks: NSObject, Glossy {

    var bankID: String
    var bankName: String
    var bankPM: String
    var bankIC: String
    
    required init?(json: JSON) {
        
        guard let bankID: String = "id" <~~ json else { return nil }
        
        self.bankID = bankID
        self.bankName = "name" <~~ json ?? ""
        self.bankPM = "processing_mode" <~~ json ?? ""
        self.bankIC = "thumbnail" <~~ json ?? ""
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
