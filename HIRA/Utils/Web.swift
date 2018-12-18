//
//  Web.swift
//  HIRA
//
//  Created by Debashis  on 23/11/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit
import Alamofire
import Gloss
class Web {
    class CONSTANT {
        public static let baseURL:String = "http://hi-api.dvlpsite.com/api/v1/"
    }
    
    public static func XHR(
        path:String,
        paramerters:[String:Any],
        requestHeader:[String:String],
        onCompletion:@escaping (_ response:Any, _ statusCode:Int, _ responseHeader:Any) -> Void,
        onFailure:@escaping (_ response:Any, _ statusCode:Int, _ responseHeader:Any) -> Void
    ){
        let finalURL = CONSTANT.baseURL + path
        print(finalURL)
        Alamofire.request(finalURL, method: .post, parameters: paramerters, encoding: URLEncoding.default, headers: requestHeader).responseJSON { (jsonResponse) in
            print(jsonResponse)
            switch jsonResponse.result {
            case .failure(let e):
                let hiraError:HIRAError = HIRAError(message: e.localizedDescription, status: 500)
                onFailure(hiraError,500,jsonResponse.response?.allHeaderFields ?? [])
                break
            case .success(let value):
                
                onCompletion(value,(jsonResponse.response?.statusCode)!,jsonResponse.response?.allHeaderFields ?? [])
                break
            default: break
                
            }
        }
    }
    public static func XHRGet(
        path:String,
        paramerters:[String:Any],
        requestHeader:[String:String],
        onCompletion:@escaping (_ response:Any, _ statusCode:Int, _ responseHeader:Any) -> Void,
        onFailure:@escaping (_ response:Any, _ statusCode:Int, _ responseHeader:Any) -> Void
        ){
        let finalURL = CONSTANT.baseURL + path
        print(finalURL)
        Alamofire.request(finalURL, method: .get, parameters: paramerters, encoding: URLEncoding.default, headers: requestHeader).responseJSON { (jsonResponse) in
            print(jsonResponse)
            switch jsonResponse.result {
            case .failure(let e):
                let hiraError:HIRAError = HIRAError(message: e.localizedDescription, status: 500)
                onFailure(hiraError,500,jsonResponse.response?.allHeaderFields ?? [])
                break
            case .success(let value):
                
                onCompletion(value,(jsonResponse.response?.statusCode)!,jsonResponse.response?.allHeaderFields ?? [])
                break
            default: break
                
            }
        }
    }
}
