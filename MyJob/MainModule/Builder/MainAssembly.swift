//
//  ModuleBuilder.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
