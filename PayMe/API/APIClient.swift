//
//  APIClient.swift
//  OsecacApp
//
//  Created by Eduardo on 3/17/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import Alamofire

class APIClient: NSObject {
    
    fileprivate var serverURL: String
    fileprivate var client: HttpConnectionProtocol
    
    init(serverURL: String) {
        self.serverURL = serverURL
        client = HttpConnection()
    }
    
    //REQUEST TYPES (POST, GET)
    func requestPOST(url: String, params: [String : AnyObject], qParams: [NSURLQueryItem]?, headers: [String : String]?, handler: ResponseHandler)  {
        
        let mURL = serverURL + url
        let mainCompURL = NSURLComponents.init(string: mURL)
        if qParams != nil {
            mainCompURL?.queryItems = qParams! as [URLQueryItem]
        }
        let mainURL = mainCompURL?.url
        
        Alamofire.request(mainURL!, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseString { response in
            
            switch response.result {
            case .success(let value):
                if let sCode = response.response?.statusCode {
                    switch(sCode){
                    case 100, 200, 204, 404:
                        //print("JSON: ", value)
                        let jsonResponse = self.jsonStringToDic(stringIn: value)
                        handler.onSuccess(jsonResponse as AnyObject)
                    case 400, 401:
                        //print("JSON: ", value)
                        var jsonError = self.jsonStringToDic(stringIn: value)
                        if let errorMSG = jsonError["Message"] {
                            handler.onFailure(errorMSG as AnyObject)
                        }
                    default:
                        handler.onFailure(NSLocalizedString("E_WS_STANDAR_ERROR", comment: "") as AnyObject)
                    }
                }
            case .failure(let error):
                print("Error: ", error)
                handler.onFailure(NSLocalizedString("E_WS_STANDAR_ERROR", comment: "") as AnyObject)
            }
        }
    }
    
    func requestGET(url: String, params: [String : AnyObject], qParams: [NSURLQueryItem]?, headers: [String : String], handler: ResponseHandler)  {
        
        let mURL = serverURL + url
        let mainCompURL = NSURLComponents.init(string: mURL)
        if qParams != nil {
            mainCompURL?.queryItems = qParams! as [URLQueryItem]
        }
        let mainURL = mainCompURL?.url
        
        Alamofire.request(mainURL!, parameters: params, headers: headers).responseString { response in
            
            switch response.result {
            case .success(let value):
                if let sCode = response.response?.statusCode {
                    switch(sCode){
                    case 100, 200, 204, 404:
                        //print("JSON: ", value)
                        let jsonResponse = self.jsonStringToDic(stringIn: value)
                        handler.onSuccess(jsonResponse as AnyObject)
                    case 400, 401:
                        //print("JSON: ", value)
                        var jsonError = self.jsonStringToDic(stringIn: value)
                        if let errorMSG = jsonError["Message"] {
                            handler.onFailure(errorMSG as AnyObject)
                        }
                    default:
                        print("JSON: ", value)
                        handler.onFailure(NSLocalizedString("E_WS_STANDAR_ERROR", comment: "") as AnyObject)
                    }
                }
            case .failure(let error):
                print("Error: ", error)
                handler.onFailure(NSLocalizedString("E_WS_STANDAR_ERROR", comment: "") as AnyObject)
            }
        }
    }
    
    func jsonStringToDic(stringIn: String) -> [String : AnyObject] {
    
        let jsonData:Data = stringIn.data(using: .utf8, allowLossyConversion: false)!
        var jsonDic: [String : AnyObject]?
        
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSArray
            jsonDic = ["Response" : json] as [String : AnyObject]
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        if jsonDic != nil {
            return jsonDic!
        }else{
            return ["Response" : stringIn as AnyObject]
        }
    }
}
