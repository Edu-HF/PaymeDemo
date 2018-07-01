//
//  PaymentQuotasVC.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import DropDown

class PaymentQuotasVC: mainBaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var pmAmount: UILabel!
    @IBOutlet weak var pmIC: UIImageView!
    @IBOutlet weak var pbIC: UIImageView!
    @IBOutlet weak var pqTF: UITextField!
    
    var mainPMPresenter: PMPresenter!
    var quotasDD = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        buildNavigationBar(navTitle: "Cuotas", navTitleIma: "")
        buildBackButton()
        pqTF.delegate = self
        showLoading()
        mainPMPresenter.getQuotas()
        pmIC.downloadImageFromURL(linkIn: mainPMPresenter.mainPayment.pmPMIC)
        pbIC.downloadImageFromURL(linkIn: mainPMPresenter.mainPayment.pmBankIC)
        pmAmount.text = String(mainPMPresenter.mainPayment.pmAmount)
    }

    @IBAction func payActButtom(_ sender: Any) {
        if pqTF.text != "" {
            self.navigationController?.popToRootViewController(animated: false)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                NotificationCenter.default.post(.init(name: .showPaymentProcessed))
            })
        }else{
            showToastMSG(msgIn: "Debe seleccionar el numero de Cuotas. Intente nuevamente", imaIn: #imageLiteral(resourceName: "Caution_IC"))
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        quotasDD.show()
    }

    override func setDataToView() {
        removeLoading()
        
        quotasDD.anchorView = pqTF
        quotasDD.bottomOffset = CGPoint(x: 0, y: pqTF.bounds.height)
        var quotasNames: [String] = []
        for tempQ in mainPMPresenter.mainQuotasData {
            quotasNames.append(tempQ.qMSG)
        }
        
        quotasDD.dataSource = quotasNames
        quotasDD.selectionAction = { [unowned self] (index, item) in
            self.pqTF.text = self.mainPMPresenter.mainQuotasData[index].qMSG
            self.mainPMPresenter.updateQuotaOnPayment(quotaIn: self.mainPMPresenter.mainQuotasData[index])
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
