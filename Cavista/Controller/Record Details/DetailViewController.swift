//
//  DetailViewController.swift
//  Cavista
//
//  Created by Apple on 27/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    public var viewModel: DetailViewModel!
    private lazy var idLabel: UILabel = {
        let lastMessageDateLabel = UILabel()
        lastMessageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageDateLabel.accessibilityIdentifier = "idLabel"
        lastMessageDateLabel.adjustsFontForContentSizeCategory = true
        lastMessageDateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        dateLabel.textColor = .black
        return lastMessageDateLabel
    }()
    
    private lazy var recordImageView: AvtarView = {
        let recordImageView = AvtarView()
        recordImageView.translatesAutoresizingMaskIntoConstraints = false
        recordImageView.layer.cornerRadius = 5
        recordImageView.layer.masksToBounds = false
        recordImageView.clipsToBounds = true
        return recordImageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.accessibilityIdentifier = "dateLabel"
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 1
        return dateLabel
    }()
    private lazy var rightMiddleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            self.idLabel.heightAnchor.constraint(equalToConstant: 30),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        return stackView
    }()
    private lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.accessibilityIdentifier = "typeLabel"
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.font = UIFont.systemFont(ofSize: 12)
        typeLabel.textColor = .lightGray
        typeLabel.numberOfLines = 1
        return typeLabel
    }()
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    private lazy var recordScrollView: UIScrollView = {
        let recordScrollView = UIScrollView()
        recordScrollView.translatesAutoresizingMaskIntoConstraints = false
        recordScrollView.layer.cornerRadius = 5
        recordScrollView.layer.masksToBounds = false
        recordScrollView.clipsToBounds = true
        return recordScrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Details"
        self.view.addSubview(self.recordScrollView)
        self.recordScrollView.snp.makeConstraints({ (constraint) in
            constraint.bottom.right.equalTo(self.view).offset(-8)
            constraint.top.left.equalTo(self.view).offset(8)
            constraint.center.equalTo(self.view)
        })
        recordScrollView.addSubview(self.rightMiddleStackView)
        self.rightMiddleStackView.snp.makeConstraints({ (constraint) in
            constraint.right.equalTo(self.recordScrollView).offset(-8)
            constraint.top.equalTo(self.recordScrollView).offset(4)
            constraint.left.equalTo(self.recordScrollView).offset(8)
            constraint.centerX.equalTo(self.recordScrollView)
            constraint.height.greaterThanOrEqualTo(30)
        })
        rightMiddleStackView.addArrangedSubview(self.idLabel)
        rightMiddleStackView.addArrangedSubview(self.dateLabel)
        recordScrollView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints({ (constraint) in
            constraint.right.equalTo(self.recordScrollView).offset(-8)
            constraint.left.equalTo(self.recordScrollView).offset(8)
            constraint.top.equalTo(self.rightMiddleStackView.snp.bottom)
            constraint.centerX.equalTo(self.recordScrollView)
            constraint.height.lessThanOrEqualTo(30)
        })
        self.idLabel.text = self.viewModel.record?.id
        self.typeLabel.text = self.viewModel.record?.type.map { $0.rawValue }
        self.dateLabel.text = self.viewModel.record?.date
        self.recordImageView.removeFromSuperview()
        self.descriptionLabel.removeFromSuperview()
        if self.viewModel.record?.type == .text {
            recordScrollView.addSubview(self.descriptionLabel)
            descriptionLabel.text = self.viewModel.record?.data
            self.descriptionLabel.snp.makeConstraints({ (constraint) in
                constraint.top.equalTo(self.typeLabel.snp.bottom).offset(4)
                constraint.bottom.right.equalTo(self.recordScrollView).offset(-8)
                constraint.left.equalTo(self.recordScrollView).offset(8)
            })
        } else {
            recordScrollView.addSubview(self.recordImageView)
            self.recordImageView.snp.makeConstraints({ (constraint) in
                constraint.bottom.right.equalTo(self.recordScrollView).offset(-8)
                constraint.left.equalTo(self.recordScrollView).offset(8)
                constraint.top.equalTo(self.typeLabel.snp.bottom).offset(4)
                constraint.height.greaterThanOrEqualTo(300)
                constraint.height.lessThanOrEqualTo(300)
            })
            if let record = self.viewModel.record {
            recordImageView.configureImages(record: record)
            }
        }
    }
}
