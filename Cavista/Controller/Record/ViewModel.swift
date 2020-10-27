//
//  ViewModel.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public class ViewModel{
    let networkService: NetworkServiceProvider
    let database: CavistaDatabase
    var isfilter: Bool
    var mainList: [RecordModel] = []
    public var recordList: [RecordModel] = []
    var onFetchCompleted: (() -> ())? = nil
    var onFetchFailed: ((_ reason: String) -> ())? = nil
    
    public convenience init() {
        self.init(networkService: NetworkService(), database:CavistaDatabase())
    }
    
    public init(networkService: NetworkServiceProvider, database: CavistaDatabase, recordList: [RecordModel] = [], isfilter: Bool = false) {
        self.networkService = networkService
        self.database = database
        self.recordList = recordList
        self.isfilter = isfilter
    }
    
    //MARK: Get the record from server and store into Realm
    public func fetchRecord() {
        if networkService.isConnectedToInternet() {
            networkService.fetchRecords(completion: { [weak self] (response) in
                guard self != nil else { return }
                switch response {
                case .success(let response):
                    if response.count > 0 {
                        self?.mainList.append(contentsOf: response)
                        self?.recordList.append(contentsOf: response)
                        self?.database.addRecord(records: self?.recordList ?? [])
                    }
                    self?.onFetchCompleted!()
                case .failure(let apiError):
                    self?.onFetchFailed?(apiError.localizedDescription)
                }
            })
        }
        else{
            // get the record from Realm if not found then show the message
            self.recordList = database.fetchRecord() ?? []
            self.mainList = self.recordList
            if recordList.count == 0{
                self.onFetchFailed?("Record not in local DB")
            }
            else{
                self.onFetchCompleted!()
            }
        }
    }
    
    //MARK: Apply the filter here
    func filterList(type: Type?)  {
        if type == nil{
            recordList = mainList
        }else{
            recordList = mainList.sorted(by: { (left, right) -> Bool in
                if (right.type == type || right.type != type) && left.type == type {
                    return true
                }else {
                    return false
                }
            })
        }
        self.onFetchCompleted!()
    }
}

