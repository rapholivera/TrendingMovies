//
//  HTTPTask.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {

    case requestParameters(
        urlEncoding: ParameterEncoding,
        urlParameters: Parameters = [:])

    // case download, upload...etc
}
