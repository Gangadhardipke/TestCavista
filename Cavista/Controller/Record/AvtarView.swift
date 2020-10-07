//
//  AvtarView.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class AvtarView: UIView {
    let viewModel = AvatarFetchManager()
    private lazy var recordImageView: UIImageView = {
        let recordImageView = UIImageView()
        recordImageView.translatesAutoresizingMaskIntoConstraints = false
        recordImageView.accessibilityIdentifier = "recordImageView"
        recordImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        recordImageView.clipsToBounds = true
        recordImageView.contentMode = .scaleAspectFill
        recordImageView.contentMode = .scaleAspectFill
        return recordImageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }

    private func configureContents() {
        self.addSubview(self.recordImageView)
        NSLayoutConstraint.activate([
            self.recordImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.recordImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.recordImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.recordImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    public func configureImages(record: RecordModel) {
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.avatarRequests.append(self?.recordImageView.configureForUser(url: record.data!, recordService: self?.viewModel.recordService, completion: nil))
            }
    }

}
