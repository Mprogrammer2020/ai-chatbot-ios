//
//  WebServices.swift
//  X-Vault
//
//  Created by netset on 09/12/22.
//

import UIKit

class WebServices {
    
    static var shared: WebServices {
        return WebServices()
    }
    fileprivate init(){}
    
    //MARK:- Post With Header Data API Interaction
    func postDataWithHeader(_ urlStr: String, params: [String:Any],headers: [String:String],showIndicator: Bool,methodType: HTTPMethod,completion: @escaping (_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Params:- ", params)
            debugPrint("Headers:- ",headers)
            AF.request(urlStr, method: methodType, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            if response.response?.statusCode == 200 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else if response.response?.statusCode == 401 {
                                self.statusHandler(response)
                            } else {
                                CommonMethod.shared.hideActivityIndicator()
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON), isSuccess: false, statusCode: response.response?.statusCode ?? 204))
                            }
                        } else {
                            CommonMethod.shared.hideActivityIndicator()
                            self.statusHandler(response)
                        }
                    } else {
                        CommonMethod.shared.hideActivityIndicator()
                        self.statusHandler(response)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
        }
    }
    
    func isInternetWorking() -> Bool {
        if NetworkReachabilityManager()!.isReachable {
            return true
        } else {
            return false
        }
    }
    
    //MARK:- Error Handling Methos
    func statusHandler(_ response:AFDataResponse<Any>) {
        
    }
    
    //MARK:- Get Error Message
    func getErrorMsg(_ json: NSDictionary) -> String {
        var msgStr = String()
        if let errorMsg = json["error"] as? String {
            msgStr = errorMsg
        } else if let errorMessage = json["message"] as? String {
            msgStr = errorMessage
        } else if let errorMessage = json["detail"] as? String {
            msgStr = errorMessage
        } else {
            msgStr = "Server Not Responding"
        }
        return msgStr
    }
}
