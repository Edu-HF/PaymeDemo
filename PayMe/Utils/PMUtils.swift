//
//  PMUtils.swift
//  PayMe
//
//  Created by Eduardo Herrera on 24/06/2018.
//  Copyright © 2018 Eduardo Herrera. All rights reserved.
//

import UIKit

extension UIColor {
    
    func buildHexColor(hexIn: String) -> UIColor {
        
        var hString: String = hexIn.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hString.hasPrefix("#")) {
            hString.remove(at: hString.startIndex)
        }
        
        if ((hString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: hString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITextField {
    
    func setRightIcon(iconIn:UIImage) {
        
        let viewR = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        let iconView = UIImageView.init(frame: CGRect.init(x: 0, y: 2, width: 20, height: 25))
        iconView.image = iconIn
        viewR.addSubview(iconView)
        self.rightView = viewR
        self.rightViewMode = UITextFieldViewMode.always
    }
}

extension Notification.Name {
    
    static let wsSetDataToView = Notification.Name(
        rawValue: "wsSetDataToView")
    static let showPaymentProcessed = Notification.Name(
        rawValue: "showPaymentProcessed")
}

extension UIImageView {
    
    func downloadImageFromURL(urlIn: URL, contentModeIn: UIViewContentMode = .scaleAspectFit) {
        self.contentMode = contentModeIn
        URLSession.shared.dataTask(with: urlIn) { data, response, error in
            guard
                let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200,
                let mType = response?.mimeType, mType.hasPrefix("image"),
                let dataIma = data, error == nil,
                let mainImage = UIImage(data: dataIma)
                else { return }
            DispatchQueue.main.async {
                self.image = mainImage
            }
        }.resume()
    }
    
    func downloadImageFromURL(linkIn: String, contentModeIn: UIViewContentMode = .scaleAspectFit) {
        guard let imaURL = URL(string: linkIn) else { return }
        downloadImageFromURL(urlIn: imaURL, contentModeIn: contentModeIn)
    }
}

extension UIView {
    
    func presentView() {
        
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func dismissView() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.removeFromSuperview()
            }
        })
    }
}
