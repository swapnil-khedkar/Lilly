//
//  StoreInfo.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

struct StoreInfo: Codable {

  let name: String
}

struct StoreInfoResponse: Codable {
  let storeInfo: StoreInfo
}
