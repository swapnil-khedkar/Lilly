//
//  Order.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

struct Order: Codable {

  let id: String
  let total: Double
  let user: User
}
