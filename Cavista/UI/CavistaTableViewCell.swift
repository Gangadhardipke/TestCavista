//
//  CavistaTableViewCell.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
class CavistaTableViewCell: UITableViewCell, ReusableView  {
    
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
    private lazy var recordContainerView: UIView = {
        let recordContainerView = UIView()
        recordContainerView.translatesAutoresizingMaskIntoConstraints = false
        recordContainerView.layer.cornerRadius = 5
        recordContainerView.layer.masksToBounds = false
        recordContainerView.clipsToBounds = true
        return recordContainerView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(record: RecordModel){
        if recordContainerView.superview == nil {
            contentView.addSubview(self.recordContainerView)
            recordContainerView.addSubview(self.rightMiddleStackView)
            rightMiddleStackView.addArrangedSubview(self.idLabel)
            rightMiddleStackView.addArrangedSubview(self.dateLabel)
            recordContainerView.addSubview(self.typeLabel)
            if record.type == .text{
                recordContainerView.addSubview(self.descriptionLabel)
            } else {
                recordContainerView.addSubview(self.recordImageView)
            }
            NSLayoutConstraint.activate([
                self.recordContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                self.recordContainerView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 4),
                self.recordContainerView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
                self.recordContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                self.recordContainerView.leadingAnchor
                    .constraint(equalTo: contentView.leadingAnchor, constant: 8),
                self.rightMiddleStackView.topAnchor.constraint(equalTo: self.recordContainerView.topAnchor, constant: 4),
                self.rightMiddleStackView.leadingAnchor.constraint(equalTo: self.recordContainerView.leadingAnchor, constant: 8),
                self.rightMiddleStackView.centerXAnchor.constraint(equalTo: self.recordContainerView.centerXAnchor),
                self.rightMiddleStackView.trailingAnchor.constraint(equalTo: self.recordContainerView.trailingAnchor, constant: -8),
                self.rightMiddleStackView.heightAnchor.constraint(equalToConstant: 30),
                self.typeLabel.leadingAnchor.constraint(equalTo: self.recordContainerView.leadingAnchor, constant: 8),
                self.typeLabel.trailingAnchor.constraint(equalTo: self.recordContainerView.trailingAnchor, constant: -8),
                self.typeLabel.topAnchor.constraint(equalTo: self.rightMiddleStackView.bottomAnchor, constant: 4),
                self.typeLabel.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
        idLabel.text = record.id
        typeLabel.text = record.type.map { $0.rawValue }
        dateLabel.text = record.date
        self.recordImageView.removeFromSuperview()
        self.descriptionLabel.removeFromSuperview()
        if record.type == .text {
            recordContainerView.addSubview(self.descriptionLabel)
            descriptionLabel.text = record.data
            NSLayoutConstraint.activate([
                self.descriptionLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 4),
                self.descriptionLabel.leadingAnchor.constraint(equalTo: self.recordContainerView.leadingAnchor, constant: 8),
                self.descriptionLabel.trailingAnchor.constraint(equalTo: self.recordContainerView.trailingAnchor, constant: -8),
                self.descriptionLabel.bottomAnchor.constraint(equalTo: self.recordContainerView.bottomAnchor, constant: -4),
            ])
        } else {
            recordContainerView.addSubview(self.recordImageView)
            NSLayoutConstraint.activate([
                self.recordImageView.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 4),
                self.recordImageView.leadingAnchor.constraint(equalTo: self.recordContainerView.leadingAnchor, constant: 8),
                self.recordImageView.trailingAnchor.constraint(equalTo: self.recordContainerView.trailingAnchor, constant: -8),
                self.recordImageView.bottomAnchor.constraint(equalTo: self.recordContainerView.bottomAnchor, constant: -4),
                self.recordImageView.heightAnchor.constraint(equalToConstant: 200),
            ])
            recordImageView.configureImages(record: record)
        }
        self.layoutIfNeeded()
    }
}
