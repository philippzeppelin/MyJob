//
//  JobsModel.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import Foundation

struct JobsModelApi: Decodable {
    let id: String
    let logo: URL?
    let profession: String
    let employer: String
    let salary: Double
    let date: String
}
