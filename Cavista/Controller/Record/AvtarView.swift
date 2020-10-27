//
//  AvtarView.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
class AvtarView: UIView {
    let viewModel = AvatarFetchManager()
    private lazy var recordImageView: UIImageView = {
        let recordImageView = UIImageView()
        recordImageView.translatesAutoresizingMaskIntoConstraints = false
        recordImageView.accessibilityIdentifier = "recordImageView"
        recordImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        recordImageView.clipsToBounds = true
        recordImageView.contentMode = .scaleToFill
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
        self.recordImageView.snp.makeConstraints({ (constraint) in
            constraint.top.bottom.left.right.equalTo(self)
        })
    }

    public func configureImages(record: RecordModel) {
            DispatchQueue.main.async { [weak self] in
                self?.recordImageView.af.setImage(withURL: URL(string: record.data!)!, cacheKey: nil, placeholderImage: UIImage(named: "defaultImage"))
            }
    }

}
