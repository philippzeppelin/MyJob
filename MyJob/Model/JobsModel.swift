//
//  JobsModel.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import Foundation

struct JobsModel: Decodable {
    let profession: String
    let date: String
    let salary: Int
    let id: String
    let logo: String?
    let employer: String
}
