//
//  DataServiceFakeImpl.swift
//  LillyTests
//
//  Created by swapnil khedkar on 5/19/22.
//

import Foundation

@testable import Lilly

class DataServiceFakeImpl: DataHandler {

  var fetchStoreInfoHandler: ((((Result<StoreInfoResponse, Error>) -> Void)) -> Void)!
  var fetchProductsHandler: ((((Result<ProductsResponse, Error>) -> Void)) -> Void)!
  var storeOrderHandler: ((Order, ((Bool) -> Void)) -> Void)!

  func fetchStoreInfo(completion: ((Result<StoreInfoResponse, Error>) -> Void)) {
    fetchStoreInfoHandler(completion)
  }

  func fetchProducts(completion: ((Result<ProductsResponse, Error>) -> Void)) {
    fetchProductsHandler(completion)
  }

  func storeOrder(_ order: Order, completion: ((Bool) -> Void)) {
    storeOrderHandler(order, completion)
  }
}
