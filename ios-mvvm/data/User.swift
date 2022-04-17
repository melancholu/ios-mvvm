//
//  User.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Foundation
import UIKit

struct User: Codable, Hashable {
    var name: String?
    var email: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? container.decodeIfPresent(String.self, forKey: .name))
        email = (try? container.decodeIfPresent(String.self, forKey: .email))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
    }
}

