//
//  MovieApi.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

struct PageDTO<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}

struct MovieDTO: Decodable, Encodable {
    let id: Int
    let title: String
}
