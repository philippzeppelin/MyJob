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
    // TODO: Сделать кастомные ячейки

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
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(0.2)),
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
//        cell.backgroundColor = .red
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

// TODO: Сделать кастомные ячейки
// TODO: Сделать корректный размер ячеек
// TODO: Сделать Network Service
