//
//  DetailViewModel.swift
//  Cavista
//
//  Created by Apple on 27/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
class DetailViewModel{
    var record: RecordModel
    
    public convenience init() {
        self.init(record:nil)
    }
    
    public init(record: RecordModel?) {
        self.record = record!
    }
}
