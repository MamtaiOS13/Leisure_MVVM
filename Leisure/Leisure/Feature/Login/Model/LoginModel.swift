//
//  LoginModel.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

struct RequestToken: Codable {
    let requestToken: String?
    private enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}

struct ValidUserToken: Codable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    private enum CodingKeys: String, CodingKey {
        case success
        case requestToken = "request_token"
        case expiresAt = "expires_at"
    }
}

struct ValidSession: Codable {
    let success: Bool?
    let sessionId: String?
    private enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
