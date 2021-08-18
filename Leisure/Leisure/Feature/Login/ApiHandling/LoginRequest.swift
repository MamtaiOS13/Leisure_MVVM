//
//  LoginRequest.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

enum LoginStepType {
    case refresh
    case login
    case revalid

}
class LoginRequest: BaseService {
    public init(_ loginType: LoginStepType, _ requestToken: String? = nil) {
        super.init()
        if loginType == .refresh {
            self.requestURL = Services.baseUrl + Services.requestToken
            self.requestType = .GET
        } else  if loginType == .login {
            self.requestURL = Services.baseUrl + Services.validateToken
            self.requestType = .POST
            self.requestParams = ["username": "mamta17",
                                  "password": "max17",
                                  "request_token": requestToken ?? ""]
        } else {
            self.requestURL = Services.baseUrl + Services.newSession
            self.requestParams = ["request_token": requestToken ?? ""]
            self.requestType = .POST
        }
    }
}
