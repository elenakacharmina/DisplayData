//
//  DataForTable.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import Foundation

struct DataForTable: Codable {
    var data: [CommonItem]?
    var view: [String]?
    
    enum CodingKeys: String, CodingKey {
        case view = "view"
        case data = "data"
    }
}

struct CommonItem: Codable {
    var name: String?
    var data: DataItemSelected?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case data = "data"
    }
    
    struct DataItemSelected: Codable {
        var selectedId: Int?
        var variants: [Variant]?
        var url: String?
        var text: String?
        
        enum CodingKeys: String, CodingKey {
            case selectedId = "selectedId"
            case variants = "variants"
            case url = "url"
            case text = "text"
        }
        
        struct Variant: Codable {
            var id: Int
            var text: String
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case text = "text"
            }
        }
    }
}
