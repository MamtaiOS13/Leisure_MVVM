//
//  BaseService.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

class BaseService: Service {
    static var baseUrl: String?
    var requestType: RequestType = .GET
    var requestURL: String = ""
    var requestQueryParam: String = "\(Services.apiKeyUrl)"
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    init() {
        self.additionalHeaders = ["Content-Type": "application/json" ]
    }
}
