//
//  JobCell.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 31.10.2023.
//

import UIKit

final class JobCell: UICollectionViewCell {
    static let cellIdentifier = "JobCell"

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
        label.text = "Грузчик"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let earningsLabel: UILabel = {
        let label = UILabel()
        label.text = "1 600 Р"
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
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let companyNameLabel: UILabel = { // Font
        let label = UILabel()
        label.text = "Озон"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let jobStartingDateLabel: UILabel = {
        let label = UILabel()
        label.text = "13.10"
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.labelsBackgroundCornerRadius
        label.layer.backgroundColor = UIColor.systemGray4.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let jobStartingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "18:00"
        label.textAlignment = .center
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

    func configureCell() {}

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
