//
//  StoreViewModel.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

class StoreViewModel {

  private let dataHandler: DataHandler

  private(set) var storeInfo: StoreInfo = StoreInfo(name: "") {
    didSet {
      storeInfoFetched?()
    }
  }

  // Callback for updating the store info on UI.
  var storeInfoFetched: (() -> ())?

  init(dataHandler: DataHandler) {
    self.dataHandler = dataHandler
  }

  func fetchStoreInfo() {
    dataHandler.fetchStoreInfo { result in
      switch result {
      case .success(let response):
        storeInfo = response.storeInfo
      case .failure(let error):
        // TODO: Show the error on UI.
        print("Error in fetching store info: \(error)")
      }
    }
  }
}
