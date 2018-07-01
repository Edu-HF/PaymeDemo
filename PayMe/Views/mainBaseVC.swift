//
//  mainBaseVC.swift
//  PayMe
//
//  Created by Eduardo Herrera on 30/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit
import SwiftToast
import NVActivityIndicatorView
import SCLAlertView

class mainBaseVC: UIViewController {
    
    let notificationCenter = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.addObserver(self, selector: #selector(setDataToView), name: .wsSetDataToView, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(self)
    }
    
    func buildNavigationBar(navTitle: String, navTitleIma: String) {
        
        if navTitleIma != "" {
            
            let navIma = UIImage(named: navTitleIma)
            let navImaView = UIImageView.init(image: navIma)
            self.navigationItem.titleView = navImaView
            
        }else{
            self.navigationItem.title = navTitle
        }
    }
    
    func buildBackButton() {
        
        var backButton = UIBarButtonItem()
        let backB = UIButton(type: .custom)
        backB.frame = CGRect(x:0.0, y:0.0, width:25, height:25)
        backB.setBackgroundImage(#imageLiteral(resourceName: "Back_IC"), for: .normal)
        backB.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton = UIBarButtonItem(customView: backB)
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func showNotDataBG(hideViewIn: UIView?) {
        
        hideViewIn?.isHidden = true
        let mainNotDataImageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 40, y: 50, width: 250, height: 250))
        mainNotDataImageView.center = (hideViewIn?.center)!
        mainNotDataImageView.image = #imageLiteral(resourceName: "NotData_IC")
        mainNotDataImageView.contentMode = .scaleAspectFill
        mainNotDataImageView.tag = 400
        self.view.addSubview(mainNotDataImageView)
    }
    
    func hideNotDataBG(showViewIn: UIView?) {
        
        showViewIn?.isHidden = false
        for nView in self.view.subviews {
            if nView.tag == 400 {
                nView.removeFromSuperview()
            }
        }
    }
    
    func showToastMSG(msgIn: String, imaIn: UIImage) {
        
        let mainToast = SwiftToast(text: msgIn, textAlignment: .left, image: imaIn, backgroundColor: UIColor().buildHexColor(hexIn: "#7FBE00"), textColor: .white, font: .boldSystemFont(ofSize: 15.0), duration: 5, statusBarStyle: .lightContent, aboveStatusBar: true, isUserInteractionEnabled: false, target: nil, style: .navigationBar)
        
        self.present(mainToast, animated: true)
    }
    
    @objc func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func showLoading() -> Void {
        
        self.view.isUserInteractionEnabled = false
        
        let tempX = self.view.frame.size.width / 2.0
        let tempY = self.view.frame.size.height / 2.0
        let mainFrame = CGRect(x:tempX - 40, y:tempY - 40, width:100, height:100)
        
        let loadingView:UIView = UIView.init(frame: mainFrame)
        loadingView.backgroundColor = UIColor.clear
        loadingView.layer.cornerRadius = 5
        loadingView.tag = 200
        
        let mainAI = NVActivityIndicatorView(frame: CGRect(x:tempX - 40, y:tempY - 60, width:80, height:80), type: .ballClipRotateMultiple, color: UIColor().buildHexColor(hexIn: "#7FBE00"), padding: 0)
        mainAI.tag = 201
        mainAI.startAnimating()
        
        self.view.addSubview(loadingView)
        self.view.addSubview(mainAI)
    }
    
    func removeLoading(){
        
        self.view.isUserInteractionEnabled = true
        let removeView:UIView? = (self.view.viewWithTag(200))
        let removeAIView:UIView? = (self.view.viewWithTag(201))
        removeAIView?.removeFromSuperview()
        removeView?.removeFromSuperview()
    }

    @objc func setDataToView(){}
    func showError(errorIn: Any){}
}
