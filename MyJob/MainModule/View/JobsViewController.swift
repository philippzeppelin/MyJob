//
//  JobsViewController.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

class JobsViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    var jobsCollectionView: UICollectionView?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.createLayout(for: section)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(JobCell.self, forCellWithReuseIdentifier: JobCell.cellIdentifier)
        collectionView.backgroundColor = .systemGray5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        embedView()
        setupConstraints()
        setupDelegates()
        view.backgroundColor = .systemBackground
    }

    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func createLayout(for section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(1))
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.cellInsets,
            leading: Constants.cellInsets,
            bottom: 0,
            trailing: Constants.cellInsets
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(Constants.cellHeigth)),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}

// MARK: - UICollectionViewDataSource
extension JobsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: JobCell.cellIdentifier,
            for: indexPath
        ) as? JobCell else {
            return UICollectionViewCell()
        }

        cell.configureCell()
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension JobsViewController: UICollectionViewDelegate {}

// MARK: - MainViewProtocol
extension JobsViewController: MainViewProtocol {
    func success() {}
    func error(error: Error) {}
}

private extension JobsViewController {
    func embedView() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension JobsViewController {
    private enum Constants {
        static let cellInsets: CGFloat = 15
        static let cellHeigth: CGFloat = 125
    }
}
