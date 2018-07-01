//
//  PM.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import Gloss

class PM: NSObject, Glossy {

    var pmID: String
    var pmName: String
    var pmState: String
    var pmIC: String
    
    required init?(json: JSON) {
        
        guard let pmID: String = "id" <~~ json else { return nil }
        
        self.pmID = pmID
        self.pmName = "name" <~~ json ?? ""
        self.pmState = "status" <~~ json ?? ""
        self.pmIC = "thumbnail" <~~ json ?? ""
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
