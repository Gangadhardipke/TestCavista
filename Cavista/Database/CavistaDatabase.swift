//
//  CavistaDatabase.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import RealmSwift

public class CavistaDatabase{
    public func addRecord(records: [RecordModel]) {
        if records.count > 0{
        let realm = try! Realm()
        try! realm.write() { // 2
            realm.deleteAll()
          for record in records {
            let model = Record()
            model.id = record.id
            model.type = (record.type ?? Type(rawValue: ""))!.rawValue
            model.date = record.date ?? ""
            model.data = record.data ?? ""
            realm.add(model, update: .all)
          }
        }
        }
    }
    public func fetchRecord() -> [RecordModel]?{
        let realm = try! Realm()
        let records: Results<Record> = { realm.objects(Record.self) }()
        var list: [RecordModel] = []
        for record in records {
            let model = RecordModel(id: record.id, type: record.type, date: record.date, data: record.data)
            model.id = record.id
            model.id = record.id
            model.id = record.id
            model.id = record.id
            list.append(model)
        }
        return list
    }
}

class Record: Object {
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var date = ""
    @objc dynamic var data = ""
    override static func primaryKey() -> String? {
        return "id"
    } 
}
