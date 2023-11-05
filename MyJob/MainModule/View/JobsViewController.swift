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
<<<<<<< HEAD
        return 30
=======
        guard let jobsCount = presenter?.jobs.count else { return 0 }
        return jobsCount
>>>>>>> 20db96c (Set fetching data into ui elements)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: JobCell.cellIdentifier,
            for: indexPath
        ) as? JobCell else {
            return UICollectionViewCell()
        }

<<<<<<< HEAD
        cell.configureCell()
=======
        if let job = presenter?.jobs[indexPath.row] {
            cell.configureCell(.init(
                profession: job.profession,
                date: job.date,
                salary: job.salary,
                id: job.id,
                logo: job.logo,
                employer: job.employer)
            )
        }

>>>>>>> 20db96c (Set fetching data into ui elements)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension JobsViewController: UICollectionViewDelegate {}

// MARK: - MainViewProtocol
extension JobsViewController: MainViewProtocol {
<<<<<<< HEAD
    func success() {}
    func error(error: Error) {}
=======
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension JobsViewController {
    private func setupAppearence() {
        view.backgroundColor = .systemBackground
    }
>>>>>>> 20db96c (Set fetching data into ui elements)
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
