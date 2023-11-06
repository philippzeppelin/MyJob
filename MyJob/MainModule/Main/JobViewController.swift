//
//  JobViewController.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

final class JobViewController: UIViewController {
    private enum Section {
        case main
    }

    var presenter: MainPresenterProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<Section, JobsModel>?

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

    private let bookButton = UIButton()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingDataToVC()
        setupAppearence()
        setupDelegates()
        embedView()
        setupCollectionViewConstraints()
        configureDataSource()
        setupBookButton()
        setupBookButtonConstraints()
    }

    private func setupDelegates() {
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

    private func fetchingDataToVC() {
        presenter?.fetchJobs()
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, JobsModel>(collectionView: collectionView) {
            (collectionView, indexPath, job) -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: JobCell.cellIdentifier,
                for: indexPath
            ) as? JobCell {
                cell.configureCell(JobCell.Configuration(job: job, logoURL: job.logo))

                return cell
            }
            return nil
        }
    }

    private func setupBookButton() {
        bookButton.backgroundColor = Resources.Colors.bookButtonColor
        bookButton.layer.cornerRadius = Constants.bookButtonCornerRadius
        bookButton.setTitle("Забронировать 2 подработки", for: .normal)
        bookButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 15)
        bookButton.setTitleColor(.black, for: .normal)
        bookButton.setTitleColor(.systemGray6, for: .highlighted)
        bookButton.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func bookButtonTapped() {
        print("tapped")
    }
}

// MARK: - UICollectionViewDelegate
extension JobViewController: UICollectionViewDelegate {}

// MARK: - MainViewProtocol
extension JobViewController: MainViewProtocol {
    func success() {
        if let jobs = presenter?.jobs {
            var snapshot = NSDiffableDataSourceSnapshot<Section, JobsModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(jobs, toSection: .main)
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Setup View's Appearence
extension JobViewController {
    private func setupAppearence() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Setup View and Constraints
private extension JobViewController {
    func embedView() {
        view.addSubview(collectionView)
        view.addSubview(bookButton)
    }

    func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBookButtonConstraints() {
        NSLayoutConstraint.activate([
            bookButton.heightAnchor.constraint(equalToConstant: Constants.bookButtonHeight),
            bookButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.bookButtonPadding),
            view.rightAnchor.constraint(equalTo: bookButton.rightAnchor, constant: Constants.bookButtonPadding),
            view.bottomAnchor.constraint(equalTo: bookButton.bottomAnchor, constant: Constants.bookButtonBottomSpace)
        ])
    }
}

// MARK: - Constants
extension JobViewController {
    private enum Constants {
        static let cellInsets: CGFloat = 15
        static let cellHeigth: CGFloat = 125

        static let bookButtonHeight: CGFloat = 50
        static let bookButtonPadding: CGFloat = 30
        static let bookButtonBottomSpace: CGFloat = 30
        static let bookButtonCornerRadius: CGFloat = 10
    }
}
