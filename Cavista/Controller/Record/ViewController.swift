//
//  ViewController.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Toast_Swift
import SnapKit
class ViewController: UIViewController {
    
    private lazy var recordTableView: UITableView = {
        let recordTableView = UITableView()
        recordTableView.accessibilityIdentifier = "recordTableView"
        recordTableView.delegate = self
        recordTableView.dataSource = self
        recordTableView.backgroundColor = .white
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        recordTableView.rowHeight = UITableView.automaticDimension
        recordTableView.estimatedRowHeight = 60
        recordTableView.registerCell(RecordTableViewCell.self)
        recordTableView.separatorInset = UIEdgeInsets.zero
        recordTableView.tableFooterView = UIView()
        return recordTableView
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let sortButton = UIBarButtonItem (title: "Sort By", style: .plain, target: self, action: #selector(self.sortedPressed))
        sortButton.tintColor = UIColor.gray
        sortButton.accessibilityIdentifier = "sortButton"
        return sortButton
    }()
    
    public var viewModel: ViewModel! {
        didSet {
            viewModel.onFetchCompleted = {
                self.view.hideToastActivity()
                self.recordTableView.reloadData()
            }
            viewModel.onFetchFailed = { [weak self] error in
                self?.view.hideToastActivity()
                self?.view.makeToast(error, duration: TimeInterval(Constant.toastyDuration), position: .top)
                self?.recordTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Records"
        self.view.addSubview(recordTableView)
        self.recordTableView.snp.makeConstraints({ (constraint) in
            constraint.top.bottom.left.right.equalTo(self.view)
        })
        if viewModel.recordList.count == 0{
            self.view.makeToastActivity(.center)
            self.navigationItem.rightBarButtonItem = sortButton
            self.viewModel.fetchRecord()
        }
        
    }
    
    //MARK: Sort button click
    @objc func sortedPressed() {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "All", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.viewModel.filterList(type: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Text", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.viewModel.filterList(type: .text)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Image", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.viewModel.filterList(type: .image)
        }))
        actionsheet.addAction(UIAlertAction(title: "Other", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.viewModel.filterList(type: .other)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
            
        }))
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = actionsheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        self.present(actionsheet, animated: true, completion: nil)
    }
    
}

// MARK: Tableview delegate 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.accessibilityIdentifier = "recordTableViewCell\(indexPath.row)"
        let recordStream =  viewModel.recordList[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(record: recordStream)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = self.viewModel.recordList[indexPath.row]
        let viewController = DetailViewController()
        viewController.viewModel = DetailViewModel(record: record)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
