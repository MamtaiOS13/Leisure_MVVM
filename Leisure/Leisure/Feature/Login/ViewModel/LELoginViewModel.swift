//
//  LELoginViewModel.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

protocol LELoginViewModelDelegate: AnyObject {
    func hideLoader()
}
class LELoginViewModel {
    var network: NetworkClientProtocol = ServiceManager()
    weak var delegate: LELoginViewModelDelegate?
    func getValidSessionId() {
        _ = network.start(type: RequestToken.self, LoginRequest(.refresh)) { (result: Result<RequestToken, Error>) in
            switch result {
            case .success(let response):
                if let requestToken = response.requestToken {
                    self.getValidTMDUser(requestToken)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getValidTMDUser(_ requestToken: String) {
        _ = network.start(type: ValidUserToken.self,
                          LoginRequest(.login, requestToken)) { (result: Result<ValidUserToken, Error>) in
            switch result {
            case .success(let response):
                if let requestToken = response.requestToken {
                    self.getValidSessionIdFromRealUser(requestToken)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getValidSessionIdFromRealUser(_ requestToken: String) {
        _ = network.start(type: ValidSession.self,
                          LoginRequest(.revalid, requestToken)) { (result: Result<ValidSession, Error>) in
            switch result {
            case .success(let response):
                if let sessionId = response.sessionId {
                    self.delegate?.hideLoader()
                    ValidSessionUser.shared.sessionID = sessionId
                    DispatchQueue.main.async {
                        Utility.goToMainScreen()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.hideLoader()
            }
        }
    }

}
