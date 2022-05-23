//
//  ProductsViewModel.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import Foundation

class ProductsViewModel {

  private let dataHandler: DataHandler

  private(set) var products: [Product] = []  {
    didSet {
      productsFetched?()
    }
  }

  private(set) var selectedProduct: Product?

  // Callback for updating the products on UI.
  var productsFetched: (() -> ())?

  init(dataHandler: DataHandler) {
    self.dataHandler = dataHandler
  }

  func fetchProducts() {
    dataHandler.fetchProducts { result in
      switch result {
      case .success(let response):
        products = response.products
      case .failure(let error):
        // TODO: Show the error on UI.
        print("Error in fetching products: \(error)")
      }
    }
  }
}

extension ProductsViewModel: StoreActionsDelegate {
  func didCheckoutProduct(at index: Int) {
    selectedProduct = products[index]
  }
}
