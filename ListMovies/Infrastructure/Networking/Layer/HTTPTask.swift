//
//  HTTPTask.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)

    // case download, upload...etc
}
