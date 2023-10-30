//
//  JobsViewController.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

class JobsViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

// MARK: - MainViewProtocol
extension JobsViewController: MainViewProtocol {
    func success() {}
    func error(error: Error) {}
}
