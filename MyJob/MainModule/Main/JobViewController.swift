//
//  JobViewController.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

private enum Section {
    case main
}

final class JobViewController: UIViewController {

    var presenter: MainPresenterProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<Section, JobsModel>?
    private var isSelected = false
//    private var selectedIndexPath: IndexPath?
    private var selectedJobs: Set<JobsModel> = []

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

    private let bookButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.95)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingDataToVC()
        setupAppearence()
        setupDelegates()
        embedView()
        setupCollectionViewConstraints()
        configureDataSource()
        setupBookButtonBackgroundViewConstraints()
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
        if isSelected {
            bookButton.backgroundColor = Resources.Colors.bookButtonColor
            bookButton.setTitle("Забронировать 2 подработки", for: .normal)
            bookButton.setTitleColor(.black, for: .normal)
            bookButton.setTitleColor(.systemGray6, for: .highlighted)
            bookButton.isUserInteractionEnabled = true
        } else {
            bookButton.backgroundColor = .gray
            bookButton.setTitle("Выберите подработки", for: .normal)
            bookButton.setTitleColor(.black, for: .normal)
            bookButton.isUserInteractionEnabled = false
        }

        bookButton.layer.cornerRadius = Constants.bookButtonCornerRadius
        bookButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 15)
        bookButton.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func bookButtonTapped() {
        print("tapped")
    }
}

// MARK: - UICollectionViewDelegate
extension JobViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? JobCell {
//            cell.setCellSelected(true)
//        }
//        isSelected = true
//        setupBookButton()
        if let job = dataSource?.itemIdentifier(for: indexPath) {
                selectedJobs.insert(job)
            }
            updateBookButtonState()
        collectionView.reloadData()

//        collectionView.reloadData()
//        setupBookButton()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let job = dataSource?.itemIdentifier(for: indexPath) {
            selectedJobs.remove(job)
        }
        updateBookButtonState()
        collectionView.reloadData()

    }

    private func updateBookButtonState() {
        if !selectedJobs.isEmpty {
            isSelected = true
            setupBookButton()
        } else {
            isSelected = false
            setupBookButton()
        }
    }
}

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
        view.addSubview(bookButtonBackgroundView)
        bookButtonBackgroundView.addSubview(bookButton)
    }

    func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupBookButtonBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            bookButtonBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            bookButtonBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bookButtonBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bookButtonBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBookButtonConstraints() {
        NSLayoutConstraint.activate([
            bookButton.heightAnchor.constraint(equalToConstant: Constants.bookButtonHeight),
            bookButton.leftAnchor.constraint(equalTo: bookButtonBackgroundView.leftAnchor, constant: Constants.bookButtonPadding),
            bookButtonBackgroundView.rightAnchor.constraint(equalTo: bookButton.rightAnchor, constant: Constants.bookButtonPadding),
            bookButtonBackgroundView.bottomAnchor.constraint(equalTo: bookButton.bottomAnchor, constant: Constants.bookButtonBottomSpace)
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
