//
//  OrderViewModel.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/19/22.
//

import Foundation

class OrderViewModel {

  private let dataHandler: DataHandler
  private var order: Order?

  // Callback for order placed to update on UI.
  var orderPlaced: (() -> ())?

  init(dataHandler: DataHandler) {
    self.dataHandler = dataHandler
  }

  func placeOrder() {
    // Place an order.
    guard let order = order else {
      assertionFailure("Order not available.")
      return
    }
    dataHandler.storeOrder(order) { isSuccess in
      print("Order status: \(isSuccess)")
      if isSuccess {
        orderPlaced?()
      } else {
        // TODO: Show an error on UI.
      }
    }
  }
}

extension OrderViewModel: OrderSummaryActionsDelegate {

  func didChooseToPlaceAnOrder(for product: Product, forUser user: User) {

    // Generate an order.
    order = Order(id: UUID().uuidString, total: product.price, user: user)
  }

}

