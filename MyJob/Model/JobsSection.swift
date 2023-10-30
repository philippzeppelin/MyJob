//
//  JobsSection.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 31.10.2023.
//

import Foundation

enum JobsSection {
    case jobList([JobsModel])

    var jobs: [JobsModel] {
        switch self {
        case .jobList(let jobs):
            return jobs
        }
    }

    public var count: Int {
        jobs.count
    }

    
}
