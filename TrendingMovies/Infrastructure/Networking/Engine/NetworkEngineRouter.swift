//
//  NetworkEngineRouter.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndpointTargetType
    func request<T: Codable>(target: EndPoint, completion: @escaping(Result<T, APIError>) -> Void)
    func cancel()
}

class NetworkEngineRouter<EndPoint: EndpointTargetType>: NetworkRouter {

    private var task: URLSessionTask?

    func request<T: Codable>(target: EndPoint, completion: @escaping(Result<T, APIError>) -> Void) {

        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: target)

            task = session.dataTask(with: request, completionHandler: { data, _, _ in

                guard let data = data else { completion(Result.failure(APIError.badResponse)); return }

                do {
                    return completion(Result.success(try JSONDecoder().decode(T.self, from: data)))
                } catch {
                    return completion(Result.failure(APIError.badResponse))
                }
            })
        } catch {
            return completion(Result.failure(APIError.badRequest))
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {

        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            switch route.task {

            case .requestParameters(let urlEncoding,
                                    let urlParameters):

                var urlParametersFormatted: Parameters = urlParameters
                urlParametersFormatted["api_key"] = NetworkManager.MovieDbApiKey

                try self.configureParameters(urlEncoding: urlEncoding,
                                             urlParameters: urlParametersFormatted,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    fileprivate func configureParameters(urlEncoding: ParameterEncoding, urlParameters: Parameters, request: inout URLRequest) throws {
        do {
            try urlEncoding.encode(urlRequest: &request, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

}
