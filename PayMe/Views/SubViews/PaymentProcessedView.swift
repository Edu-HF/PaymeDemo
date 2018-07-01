//
//  PaymentProcessedView.swift
//  PayMe
//
//  Created by Eduardo Herrera on 01/07/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PaymentProcessedView: UIView {

    @IBOutlet weak var pmAmountLabel: UILabel!
    @IBOutlet weak var pmPMLabel: UILabel!
    @IBOutlet weak var pmBankLabel: UILabel!
    @IBOutlet weak var pmQuotasLabel: UILabel!
    @IBOutlet weak var pmPMIC: UIImageView!
    @IBOutlet weak var pmBankIC: UIImageView!
    
    var mainPMPresenter: PMPresenter!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PaymentProcessedView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setupView() {
        
        pmAmountLabel.text = String(mainPMPresenter.mainPayment.pmAmount)
        pmPMLabel.text = mainPMPresenter.mainPayment.pmPM
        pmBankLabel.text = mainPMPresenter.mainPayment.pmBank
        pmQuotasLabel.text = mainPMPresenter.mainPayment.pmQuotas
        
        pmPMIC.downloadImageFromURL(linkIn: mainPMPresenter.mainPayment.pmPMIC)
        pmBankIC.downloadImageFromURL(linkIn: mainPMPresenter.mainPayment.pmBankIC)
    }
    
    @IBAction func aceptAct(_ sender: Any) {
        self.dismissView()
    }
    
}
