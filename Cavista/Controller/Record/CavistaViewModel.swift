//
//  CavistaViewModel.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public class CavistaViewModel{
    let cavistaService: CavistaServiceProvider
    let database: CavistaDatabase
    var isSelected: Bool
    var isfilter: Bool
    var mainList: [RecordModel] = []
    public var recordList: [RecordModel] = []
    var onFetchCompleted: (() -> ())? = nil
    var onFetchFailed: ((_ reason: String) -> ())? = nil
    
   public convenience init() {
    self.init(cavistaService: CavistaNetworking(), database:CavistaDatabase())
      }

    public init(cavistaService: CavistaServiceProvider, database: CavistaDatabase, recordList: [RecordModel] = [], isSelected: Bool = false, isfilter: Bool = false) {
          self.cavistaService = cavistaService
          self.database = database
          self.recordList = recordList
          self.isSelected = isSelected
          self.isfilter = isfilter
      }
    //MARK: Get the record from server and store into Realm
     public func fetchRecord() {
        if cavistaService.isConnectedToInternet() {
        cavistaService.fetchRecords(completion: { [weak self] (response) in
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
    
    // compare function that promises the compiler that the operands for < will be of the same type:
    func compare<T:Comparable>(lft: T, _ rgt: T) -> Bool {
        return lft < rgt
    }
}

