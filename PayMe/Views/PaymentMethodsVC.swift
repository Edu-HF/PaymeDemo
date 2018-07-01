//
//  PaymentMethodsVC.swift
//  PayMe
//
//  Created by Eduardo Herrera on 20/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

class PaymentMethodsVC: mainBaseVC, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainPMCV: UICollectionView!
    var mainPMPresenter: PMPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        
        buildNavigationBar(navTitle: "Metodos de Pago", navTitleIma: "")
        buildBackButton()
        mainPMCV.register(UINib(nibName: "PaymentMethodsCVCell", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodsCVCell")
        showLoading()
        mainPMPresenter.getPM()
    }
    
    // MARK: UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainPMPresenter.mainPMData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mainPMCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodsCVCell", for: indexPath) as! PaymentMethodsCVCell
        
        mainPMCell.pmNameLabel.text = mainPMPresenter.mainPMData[indexPath.row].pmName
        mainPMCell.pmIC.downloadImageFromURL(linkIn: mainPMPresenter.mainPMData[indexPath.row].pmIC)
        
        return mainPMCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainPMPresenter.updatePMOnPayment(pmIn: mainPMPresenter.mainPMData[indexPath.row])
        self.performSegue(withIdentifier: "showPB", sender: nil)
    }
    
    override func setDataToView() {
        removeLoading()
        mainPMCV.reloadData()
        
        if mainPMPresenter.mainPMData.count == 0 {
            showNotDataBG(hideViewIn: mainPMCV)
        }else{
            hideNotDataBG(showViewIn: mainPMCV)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPB" {
            let pbView = segue.destination as! PaymentBanksVC
            pbView.mainPMPresenter = mainPMPresenter
        }
    }
}
