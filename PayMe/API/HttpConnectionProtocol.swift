//
//  HttpConnectionProtocol.swift
//  OsecacApp
//
//  Created by Eduardo on 3/17/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

protocol HttpConnectionProtocol {
    
    func get(url: String,
             params: [String: AnyObject],
             headers: [String: String],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void)
    func post(url: String,
              params: [String: AnyObject],
              headers: [String: String],
              onSuccess: @escaping (AnyObject) -> Void,
              onFailure: @escaping (AnyObject) -> Void)
    func put(url: String,
             params: [String: AnyObject],
             headers: [String: String],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void)
    func delete(url: String,
                params: [String: AnyObject],
                headers: [String: String],
                onSuccess: @escaping (AnyObject) -> Void,
                onFailure: @escaping (AnyObject) -> Void)
}
