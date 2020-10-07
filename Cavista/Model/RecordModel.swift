//
//  RecordModel.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
public class RecordModel:Decodable{

   enum CodingKeys: String, CodingKey {
          case id
          case type
          case date
          case data
    }
    
    var id: String
    var type: Type?
    var date: String?
    var data: String?
    
    public required init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          id = try container.decode(String.self, forKey: .id)
        type = try container.decodeIfPresent(Type.self, forKey: .type)
          data = try container.decodeIfPresent(String.self, forKey: .data) ?? ""
          date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
    }
    public init(id: String, type: String, date: String, data: String){
        self.id = id
        self.type = Type(rawValue: type)
        self.data = data
        self.date = date
    }
    
}
public enum Type: String, Decodable{
    case text = "text"
    case image = "image"
    case other = "other"
    public var description: String {
        return self.rawValue
    }
}
