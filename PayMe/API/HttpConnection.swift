//
//  HttpConnection.swift
//  OsecacApp
//
//  Created by Eduardo on 3/17/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Alamofire
import Gloss

class HttpConnection: NSObject, HttpConnectionProtocol {
    
    var serverTrustPolicy: ServerTrustPolicy!
    var serverTrustPolicies: [String : AnyObject]!
    var afManager: SessionManager!
    
    func get(url: String,
             params: [String: AnyObject],
             headers: [String: String],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .get, params: params, headers:headers, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func post(url: String,
              params: [String: AnyObject],
              headers: [String: String],
              onSuccess: @escaping (AnyObject) -> Void,
              onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .post, params: params, headers:headers, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func put(url: String,
             params: [String: AnyObject],
             headers: [String: String],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .put, params: params, headers:headers, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func delete(url: String,
                params: [String: AnyObject],
                headers: [String: String],
                onSuccess: @escaping (AnyObject) -> Void,
                onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .delete, params: params, headers:headers, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func request(url: String,
                 method: HTTPMethod,
                 params: [String: AnyObject],
                 headers: [String: String],
                 onSuccess: @escaping (AnyObject) -> Void,
                 onFailure: @escaping (AnyObject) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params, headers: headers)
            .validate()
            .responseJSON { response in
                debugPrint(response.request!)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    onSuccess(data as AnyObject)
                case .failure(let error):
                    onFailure(error as AnyObject)
                }
        }
    }
    
   /* func configureAlamofireOsecacCertificate () {
    
        let certPath = Bundle.main.path(forResource: "OsecacServerCert", ofType: "cer")
        let mainCert: NSData = NSData.init(contentsOfFile: certPath!)!
        
        self.serverTrustPolicy = ServerTrustPolicy.pinCertificates(certificates: [SecCertificateCreateWithData(nil, mainCert)!], validateCertificateChain: true, validateHost: true)
        
        self.serverTrustPolicies = ["" : self.serverTrustPolicy as AnyObject]
        
        
        self.afManager = SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: self.serverTrustPolicies as! [String : ServerTrustPolicy])
        )
    }*/
}

