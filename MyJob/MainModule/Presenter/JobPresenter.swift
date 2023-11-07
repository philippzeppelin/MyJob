//
//  JobPresenter.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol {
    var jobs: [JobsModel] { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchJobs()
}

final class JobPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var jobs: [JobsModel] = []

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    func fetchJobs() {
        guard let url = URL(string: "http://185.174.137.159/jobs") else { return }

        networkService?.fetchJobs(from: url, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let modelApi):
                    self.jobs += modelApi.map { JobsModel($0) }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}

