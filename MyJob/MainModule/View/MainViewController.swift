//
//  MainViewController.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func success() {}
    func error(error: Error) {}
}
