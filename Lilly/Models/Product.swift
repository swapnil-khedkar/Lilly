//
//  Product.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation
import UIKit

struct Product: Codable {

  let id: Int
  let name: String
  let image: String
  let description: String
  let rating: Double
  let price: Double
}

struct ProductsResponse: Codable {
  let products: [Product]
}
