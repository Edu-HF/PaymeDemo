//
//  PaymentBanksVC.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PaymentBanksVC: mainBaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainPBTV: UITableView!
    var mainPMPresenter: PMPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        
        buildNavigationBar(navTitle: "Bancos", navTitleIma: "")
        buildBackButton()
        mainPBTV.register(UINib(nibName: "PaymentBanksTVCell", bundle: nil), forCellReuseIdentifier: "PaymentBanksTVCell")
        mainPBTV.rowHeight = 100
        mainPBTV.separatorStyle = .none
        showLoading()
        mainPMPresenter.getBanks()
    }
    
    // MARK: UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainPMPresenter.mainBankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainPBCell = tableView.dequeueReusableCell(withIdentifier: "PaymentBanksTVCell") as! PaymentBanksTVCell
        
        mainPBCell.pbNameLabel.text = mainPMPresenter.mainBankData[indexPath.row].bankName
        mainPBCell.pbIC.downloadImageFromURL(linkIn: mainPMPresenter.mainBankData[indexPath.row].bankIC)
        
        mainPBCell.selectionStyle = .none
        return mainPBCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainPMPresenter.updateBankOnPayment(bankIn: mainPMPresenter.mainBankData[indexPath.row])
        self.performSegue(withIdentifier: "showPQ", sender: nil)
    }
    
    override func setDataToView() {
        removeLoading()
        mainPBTV.reloadData()
        
        if mainPMPresenter.mainBankData.count == 0 {
            showNotDataBG(hideViewIn: mainPBTV)
        }else{
            hideNotDataBG(showViewIn: mainPBTV)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPQ" {
            let pqView = segue.destination as! PaymentQuotasVC
            pqView.mainPMPresenter = mainPMPresenter
        }
    }
}
