//
//  PaymentBanksTVCell.swift
//  PayMe
//
//  Created by Eduardo Herrera on 24/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PaymentBanksTVCell: UITableViewCell {
    
    @IBOutlet weak var pbNameLabel: UILabel!
    @IBOutlet weak var pbIC: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
