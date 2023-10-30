//
//  JobCell.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 31.10.2023.
//

import UIKit

final class JobCell: UICollectionViewCell {
    static let cellIdentifier = "JobCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell() {}
}
