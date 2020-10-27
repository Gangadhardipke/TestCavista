//
//  RecordTableViewCell.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
class RecordTableViewCell: UITableViewCell, ReusableView  {
    
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
            self.recordContainerView.snp.makeConstraints({ (constraint) in
                constraint.bottom.right.equalTo(self.contentView).offset(-8)
                constraint.top.left.equalTo(self.contentView).offset(8)
                constraint.centerY.equalTo(self.contentView)
            })
            recordContainerView.addSubview(self.rightMiddleStackView)
            self.rightMiddleStackView.snp.makeConstraints({ (constraint) in
                constraint.right.equalTo(self.recordContainerView).offset(-8)
                constraint.top.equalTo(self.recordContainerView).offset(4)
                constraint.left.equalTo(self.recordContainerView).offset(8)
                constraint.centerX.equalTo(self.recordContainerView)
                constraint.height.greaterThanOrEqualTo(30)
            })
            rightMiddleStackView.addArrangedSubview(self.idLabel)
            rightMiddleStackView.addArrangedSubview(self.dateLabel)
            recordContainerView.addSubview(self.typeLabel)
            self.typeLabel.snp.makeConstraints({ (constraint) in
                constraint.right.equalTo(self.recordContainerView).offset(-8)
                constraint.left.equalTo(self.recordContainerView).offset(8)
                constraint.top.equalTo(self.rightMiddleStackView.snp.bottom)
                constraint.centerX.equalTo(self.recordContainerView)
                constraint.height.lessThanOrEqualTo(30)
            })
        }
        idLabel.text = record.id
        typeLabel.text = record.type.map { $0.rawValue }
        dateLabel.text = record.date
        self.recordImageView.removeFromSuperview()
        self.descriptionLabel.removeFromSuperview()
        if record.type == .text {
            recordContainerView.addSubview(self.descriptionLabel)
            descriptionLabel.text = record.data
            self.descriptionLabel.snp.makeConstraints({ (constraint) in
                constraint.top.equalTo(self.typeLabel.snp.bottom).offset(4)
                constraint.bottom.right.equalTo(self.recordContainerView).offset(-8)
                constraint.left.equalTo(self.recordContainerView).offset(8)
            })
        } else {
            recordContainerView.addSubview(self.recordImageView)
            self.recordImageView.snp.makeConstraints({ (constraint) in
                constraint.bottom.right.equalTo(self.recordContainerView).offset(-8)
                constraint.left.equalTo(self.recordContainerView).offset(8)
                constraint.top.equalTo(self.typeLabel.snp.bottom).offset(4)
                constraint.height.greaterThanOrEqualTo(300)
                constraint.height.lessThanOrEqualTo(300)
            })
            recordImageView.configureImages(record: record)
        }
        self.layoutIfNeeded()
    }
}
