//
//  JobsModeel.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 05.11.2023.
//

import Foundation

struct JobsModel: Hashable {
    let id: String
    let logo: URL?
    let profession: String
    let employer: String
    let salary: Double
    let date: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(profession)
        hasher.combine(date)
        hasher.combine(salary)
        hasher.combine(id)
        hasher.combine(logo)
        hasher.combine(employer)
    }

    // Check for equality
    static func == (lhs: JobsModel, rhs: JobsModel) -> Bool {
        return lhs.id == rhs.id
    }
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
