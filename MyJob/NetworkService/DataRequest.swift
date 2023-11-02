//
//  DataRequest.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 02.11.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case pit = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol DataRequestProtocol {
    associatedtype Response

    var body: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var url: String { get }

    func decode(_ data: Data) throws -> Response
}

extension DataRequestProtocol where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
