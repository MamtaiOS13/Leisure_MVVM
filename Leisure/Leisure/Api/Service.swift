//
//  Service.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case HEAD
}
protocol Service {
    static var baseUrl: String? { get set }
    var requestType: RequestType { get }
    var requestURL: String { get }
    var requestParams: [String: Any]? { get }
    var additionalHeaders: [String: String]? { get }
    var requestQueryParam: String { get set }
}
typealias ServiceResponse<T> = (Result<T, Error>) -> Void

struct CustomError: Decodable, LocalizedError { public let errorDescription: String? }

func createError(with error: ServiceError) -> Error {
    let string = error.rawValue
    let err = CustomError(errorDescription: string)
    return err
}
