//
//  ServiceManager.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

class ServiceManager: NetworkClientProtocol {

    func start<T: Codable>(type: T.Type,
                           _ service: Service,
                           completion: @escaping ServiceResponse<T>) -> URLSessionDataTask? {

        guard var urlComponents = URLComponents(string: service.requestURL) else {
            completion(.failure(createError(with: .invalidResponse)))
            return nil
        }
        urlComponents.query = service.requestQueryParam
        guard let serviceUrl = urlComponents.url else {
            completion(.failure(createError(with: .invalidResponse)))
            return nil
          }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = service.requestType.rawValue
        request.allHTTPHeaderFields = service.additionalHeaders
        if let body = service.requestParams, let data = try? JSONSerialization.data(
            withJSONObject: body, options: []) {
            request.httpBody = data
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            self?.parseDataResponse(data, response, error, completion)
        }
        task.resume()
        return task
    }

    private func parseDataResponse<T: Codable>(_ data: Data?,
                                               _ response: URLResponse?,
                                               _ error: Error?,
                                               _ completion: @escaping ServiceResponse<T>) {

        guard let response = response, let data = data else {
            completion(.failure(createError(with: .invalidResponse)))
            return
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
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
