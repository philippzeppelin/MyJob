//
//  Router.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

protocol RouterMain {
    var builder: ModuleBuilderProtocol? { get set }
    var rootController: UINavigationController? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
}

final class Router: RouterProtocol {
    var builder: ModuleBuilderProtocol?
    var rootController: UINavigationController?

    init(builder: ModuleBuilderProtocol? = nil, rootController: UINavigationController? = nil) {
        self.builder = builder
        self.rootController = rootController
    }

    func initialViewController() {
        if let rootController = rootController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            rootController.pushViewController(mainViewController, animated: true)
        }
    }
}
