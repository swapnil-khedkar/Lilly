//
//  DataHandler.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

/// Handles data interactions.
protocol DataHandler {

  /// Fetches store info.
  ///
  ///  - Parameter :
  ///      - completion: Callback that represents `StoreInfoResponse` in case of success or an `Error` otherwise.
  func fetchStoreInfo(completion: ((Result<StoreInfoResponse, Error>) -> Void))

  /// Fetches product list.
  ///
  ///  - Parameter :
  ///      - completion: Callback that represents `ProductsResponse` in case of success or an `Error` otherwise.
  func fetchProducts(completion: ((Result<ProductsResponse, Error>) -> Void))

  /// Stores the order.
  ///
  ///  - Parameters :
  ///      - order: An `Order` to be stored
  ///      - completion: Callback that represents `Bool` indicating success or failure of the API.
  func storeOrder(_ order: Order, completion: ((Bool) -> Void))

}
