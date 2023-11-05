//
//  JobsModel.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import Foundation

struct JobsModelApi: Decodable {
    let profession: String
    let date: String
    let salary: Double
    let id: String
    let logo: URL?
    let employer: String
}
