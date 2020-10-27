//
//  CavistaTests.swift
//  CavistaTests
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Cavista

class CavistaTests: XCTestCase {
    let dummyJSON: [[String: Any?]] = [
        [
         "id": "461",
         "date": "01/02/1919",
         "data": "test data",
         "type": "other",
        ],
        [
         "id": "463",
         "date": "01/04/1919",
         "data": "https://www.cavistatech.com/images/cavista-logo.png",
         "type": "image",
        ],
        [
         "id": "465",
         "date": "01/05/1919",
         "data": "test data2",
         "type": "text",
        ],
    ]
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAlamofireManager() {
           let alamofireManager = AlamofireManager.sessionManager
           XCTAssertEqual(alamofireManager.session.configuration.timeoutIntervalForRequest, TimeInterval(3600))
           XCTAssertEqual(alamofireManager.session.configuration.timeoutIntervalForResource, TimeInterval(3600))
       }
    
    func testRecordStream() throws {
        let jsonData = try JSONSerialization.data(withJSONObject: dummyJSON)
        let recordStreams = try JSONDecoder().decode([RecordModel].self, from: jsonData)
        let recordStream = recordStreams[0]
        XCTAssertEqual(recordStream.id,"461")
        XCTAssertEqual(recordStream.date,"01/02/1919")
        XCTAssertEqual(recordStream.type, Type.other)
        XCTAssertEqual(recordStream.data, "test data")
    }
    
    //MARK: Realm Store data fetch data test
    func testSaveRecordInRealm() throws{
        let jsonData = try JSONSerialization.data(withJSONObject: dummyJSON)
        let recordStreams = try JSONDecoder().decode([RecordModel].self, from: jsonData)
        let realm = try! Realm()
               try! realm.write() { // 2
                   realm.deleteAll()
                 for record in recordStreams {
                   let model = Record()
                   model.id = record.id
                   model.type = (record.type ?? Type(rawValue: ""))!.rawValue
                   model.date = record.date ?? ""
                   model.data = record.data ?? ""
                   realm.add(model, update: .all)
                 }
               }
        let record = realm.objects(Record.self).last
        XCTAssertEqual(record?.id,"465")
        XCTAssertEqual(record?.date,"01/05/1919")
        XCTAssertEqual(record?.type, "text")
        XCTAssertEqual(record?.data, "test data2")
    }
}
