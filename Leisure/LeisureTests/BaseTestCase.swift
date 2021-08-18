//
//  BaseTestCase.swift
//  LeisureTests
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation
import XCTest
@testable import Leisure
class BaseTestCase: XCTestCase {
    override func setUp() {
    }
    func getResponseModel<T: Codable>(type: T.Type, fileName: String, _ completion: @escaping ServiceResponse<T>) {
        loadDataFromJsonFile(fileName: fileName, completion)
    }
    func loadDataFromJsonFile<T: Codable>(fileName: String, _ completion: @escaping ServiceResponse<T>) {
        let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
        let data = try? Data.init(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        parseDataResponse(data, completion)
    }
    func parseDataResponse<T: Codable>(_ data: Data?, _ completion: @escaping ServiceResponse<T>) {
        guard let data = data else {
            completion(.failure(createError(with: .invalidResponse)))
            return
        }
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode(T.self, from: data)
            completion(.success(movies))
        } catch {
            completion(.failure(createError(with: .invalidResponse)))
        }
    }
}
