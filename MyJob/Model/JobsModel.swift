//
//  JobsModeel.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 05.11.2023.
//

import Foundation

struct JobsModel {
    let profession: String
    let date: String
    let salary: Double
    let id: String
    let logo: URL?
    let employer: String
}

extension JobsModel {
    init(_ jobsApi: JobsModelApi) {
        self.profession = jobsApi.profession
        self.date = jobsApi.date
        self.salary = jobsApi.salary
        self.id = jobsApi.id
        self.logo = jobsApi.logo
        self.employer = jobsApi.employer
    }
}
