//
//  PaymentAmountVC.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PaymentAmountVC: mainBaseVC {
    
    @IBOutlet weak var pmAmountTF: UITextField!
    var mainPMPresenter: PMPresenter = PMPresenter()
    var mainPaymentProcessedView: PaymentProcessedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notificationCenter.addObserver(self, selector: #selector(showPaymentProcessed), name: .showPaymentProcessed, object: nil)
    }
    
    func setupView() {
        buildNavigationBar(navTitle: "Monto a Pagar", navTitleIma: "")
    }

    @IBAction func continueActButton(_ sender: Any) {
        if let pmAmount = Double(pmAmountTF.text!) {
            mainPMPresenter.updateAmountOnPayment(amountIn: pmAmount)
            self.performSegue(withIdentifier: "showPM", sender: nil)
        }else{
            self.showToastMSG(msgIn: "Debe ingresar un monto valido. Intente nuevamente", imaIn: #imageLiteral(resourceName: "Caution_IC"))
        }
    }
    
    @objc func showPaymentProcessed() {
        mainPaymentProcessedView = PaymentProcessedView.instanceFromNib() as! PaymentProcessedView
        mainPaymentProcessedView.mainPMPresenter = mainPMPresenter
        mainPaymentProcessedView.center = self.view.center
        mainPaymentProcessedView.setupView()
        mainPaymentProcessedView.presentView()
        self.view.addSubview(mainPaymentProcessedView)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPM" {
            let pmView = segue.destination as! PaymentMethodsVC
            pmView.mainPMPresenter = mainPMPresenter
        }
    }

}
