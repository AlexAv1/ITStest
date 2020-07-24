//
//  PersonModel.swift
//  Test
//
//  Created by iMac on 10.07.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import Foundation

class PersonModel: Decodable {
    var id = 0
    var first_name = ""
    var last_name = ""
    var email = ""
    var gender = ""
    var dateOfBirtdh = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case gender = "gender"
        case dateOfBirtdh = "dateOfBirtdh"
        
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name) ?? ""
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? ""
        dateOfBirtdh = try values.decodeIfPresent(String.self, forKey: .dateOfBirtdh) ?? ""
    }
    
}
