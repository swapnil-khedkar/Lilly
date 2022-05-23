//
//  Configuration.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

enum FileType: String {
  case json
}

enum Service {
  case storeInfo
  case products
  case orderDone
}

protocol Configuration {

  var fileType: FileType { get }
  var fileName: String { get }
}

struct StoreInfoConfig: Configuration {

  var fileType: FileType {
    return .json
  }

  var fileName: String {
    return Constants.storeInfoFileName
  }
}

struct ProductsConfig: Configuration {

  var fileType: FileType {
    return .json
  }

  var fileName: String {
    return Constants.productsFileName
  }
}

struct OrderDoneConfig: Configuration {

  var fileType: FileType {
    return .json
  }

  var fileName: String {
    return Constants.orderDoneFileName
  }
}


