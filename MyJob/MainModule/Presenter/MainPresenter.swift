//
//  MainPresenter.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func error(error: Error)
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var job: [JobsModel] = []

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

//    func configure(cell: JobCell, at index: Int)
//    func bookButtonTapped(at index: Int)
}
