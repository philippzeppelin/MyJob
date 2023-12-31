//
//  JobCell.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 31.10.2023.
//

import UIKit

protocol JobCellDelegate: AnyObject {
    func cellSelectedStateChanged(at indexPath: IndexPath, isSelected: Bool)
}

final class JobCell: UICollectionViewCell {
    static let cellIdentifier = "JobCell"
    weak var delegate: JobCellDelegate?

//    override var isSelected: Bool {
//        didSet {
//            if isSelected == true {
//                layer.backgroundColor = UIColor.red.cgColor
//                layer.borderWidth = 0.3
//                layer.borderColor = UIColor.yellow.cgColor
//            } else if isSelected == false {
//                layer.backgroundColor = UIColor.clear.cgColor
//                layer.borderWidth = 0
//                layer.borderColor = UIColor.clear.cgColor
//            }
//        }
//    }

    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dividerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.systemGray5.cgColor
        layer.lineWidth = 1.0
        return layer
    }()

    private let jobNameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.arialBold17
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let earningsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.labelsBackgroundCornerRadius
        label.layer.backgroundColor = UIColor(hexString: "F7CE17").cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let companyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.companyLogoDiameter / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.arialBold14
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let jobStartingDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Fonts.arial16
        label.layer.cornerRadius = Constants.labelsBackgroundCornerRadius
        label.layer.backgroundColor = UIColor.systemGray4.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let jobStartingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Fonts.arial16
        label.layer.cornerRadius = Constants.labelsBackgroundCornerRadius
        label.layer.backgroundColor = UIColor.systemGray4.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        embedView()
        setupTopViewConstraints()
        setupBottomViewConstraints()
        setupJobNameLabelConstraints()
        setupEarningsLabelConstraints()
        companyLogoImageViewConstraints()
        companyNameConstraints()
        setupJobStartingTimeLabelConstraints()
        setupJobStartingDateLabelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createDivider()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        setCellSelected(selected)
//        delegate?.cellSelectedStateChanged(at: indexPath, isSelected: selected)
//    }

//    func setCellSelected(_ selected: Bool) {
//        isSelected = selected
//
//        if isCellSelected {
//            layer.borderWidth = 2
//            layer.borderColor = UIColor.yellow.cgColor
//        } else {
//            layer.borderWidth = 0
//            layer.borderColor = UIColor.clear.cgColor
//        }
//    }

    private func createDivider() {
        let dividerPath = UIBezierPath()
        let centerY = contentView.bounds.height / Constants.viewDivideByNumber
        let linePathOnX = contentView.bounds.width - Constants.lineXOffset

        dividerPath.move(to: CGPoint(x: Constants.lineXOffset,
                                     y: centerY))
        dividerPath.addLine(to: CGPoint(x: linePathOnX,
                                        y: centerY))

        dividerLayer.path = dividerPath.cgPath
    }
}

// MARK: - Configuration
extension JobCell {
    struct Configuration {
        let job: JobsModel
        let logoURL: URL?
//        let indexPath: IndexPath
    }

    func configureCell(_ configuration: Configuration) {
        let job = configuration.job
        jobNameLabel.text = job.profession
        earningsLabel.text = "\(Int(job.salary)) ₽"
        companyNameLabel.text = job.employer
        isSelected = job.isSelected

        if let formattedDateAndTime = formatDateTime(job.date) {
            jobStartingDateLabel.text = formattedDateAndTime.date
            jobStartingTimeLabel.text = formattedDateAndTime.time
        } else {
            jobStartingDateLabel.text = "N/A"
            jobStartingTimeLabel.text = "N/A"
        }

        if let logoURL = configuration.logoURL {
            let task = URLSession.shared.dataTask(with: logoURL) { (data, _, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.companyLogoImageView.image = image
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            task.resume()
        } else {
            companyLogoImageView.image = UIImage(systemName: "gear")
        }

//        if let selectedIndexPath = selectedIndexPath, configuration.indexPath == selectedIndexPath {
//            setCellSelected(true)
//        } else {
//            setCellSelected(false)
//        }
    }

    private func formatDateTime(_ dateTimeString: String) -> (date: String, time: String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        if let date = dateFormatter.date(from: dateTimeString) {
            dateFormatter.dateFormat = "dd.MM"
            let formattedDate = dateFormatter.string(from: date)

            dateFormatter.dateFormat = "H:mm"
            let formattedTime = dateFormatter.string(from: date)

            return (date: formattedDate, time: formattedTime)
        }

        return (date: "N/A", time: "N/A")
    }
}

// MARK: - Setup Appearence
extension JobCell {
    private func setupAppearence() {
        backgroundColor = .white
        layer.cornerRadius = 12
    }
}

// MARK: - Setup View and Constraints
private extension JobCell {
    func embedView() {
        contentView.layer.addSublayer(dividerLayer)
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)

        topView.addSubview(jobNameLabel)
        topView.addSubview(earningsLabel)

        [
            companyLogoImageView,
            companyNameLabel,
            jobStartingTimeLabel,
            jobStartingDateLabel
        ].forEach { bottomView.addSubview($0) }
    }

    func setupTopViewConstraints() {
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }

    func setupBottomViewConstraints() {
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setupJobNameLabelConstraints() {
        NSLayoutConstraint.activate([
            jobNameLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: Constants.uiElementsViewPadding),
            jobNameLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }

    func setupEarningsLabelConstraints() {
        NSLayoutConstraint.activate([
            earningsLabel.widthAnchor.constraint(equalToConstant: 75),
            earningsLabel.heightAnchor.constraint(equalToConstant: Constants.labelsHeight),
            topView.rightAnchor.constraint(equalTo: earningsLabel.rightAnchor, constant: Constants.uiElementsViewPadding),
            earningsLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }

    func companyLogoImageViewConstraints() {
        NSLayoutConstraint.activate([
            companyLogoImageView.heightAnchor.constraint(equalToConstant: Constants.companyLogoDiameter),
            companyLogoImageView.widthAnchor.constraint(equalToConstant: Constants.companyLogoDiameter),
            companyLogoImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            companyLogoImageView.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: Constants.uiElementsViewPadding)
        ])
    }

    func companyNameConstraints() {
        NSLayoutConstraint.activate([
            companyNameLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            companyNameLabel.leftAnchor.constraint(equalTo: companyLogoImageView.rightAnchor, constant: 15)
        ])
    }

    func setupJobStartingTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            jobStartingTimeLabel.heightAnchor.constraint(equalToConstant: Constants.labelsHeight),
            jobStartingTimeLabel.widthAnchor.constraint(equalToConstant: 65),
            jobStartingTimeLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            bottomView.rightAnchor.constraint(equalTo: jobStartingTimeLabel.rightAnchor, constant: Constants.uiElementsViewPadding)
        ])
    }

    func setupJobStartingDateLabelConstraints() {
        NSLayoutConstraint.activate([
            jobStartingDateLabel.heightAnchor.constraint(equalToConstant: Constants.labelsHeight),
            jobStartingDateLabel.widthAnchor.constraint(equalToConstant: 55),
            jobStartingDateLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            jobStartingTimeLabel.leftAnchor.constraint(equalTo: jobStartingDateLabel.rightAnchor, constant: 5)
        ])
    }
}

// MARK: - Constants
extension JobCell {
    private enum Constants {
        static let labelsBackgroundCornerRadius: CGFloat = 5
        static let labelsHeight: CGFloat = 27
        static let companyLogoDiameter: CGFloat = 35
        static let uiElementsViewPadding: CGFloat = 20
        static let lineXOffset: CGFloat = 30
        static let viewDivideByNumber: CGFloat = 2
    }
}
