//
//  JobRequest.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 02.11.2023.
//

import Foundation

struct JobRequest: DataRequestProtocol {
    typealias Response = JobsModel

    var body: String = "http://185.174.137.159/"
    var path: String = "jobs"
    var method: HTTPMethod = .get

    public var url: String {
        return body + path
    }
}
