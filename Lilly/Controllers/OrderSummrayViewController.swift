//
//  OrderSummrayViewController.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/19/22.
//

import UIKit

/// Provides updates for user interactions in order summary view controller.
protocol OrderSummaryActionsDelegate {

  /// Provides callback when user choose to place an order
  ///
  /// - Parameters:
  ///     - product: selected `Product`
  ///     - user: `User`details
  ///
  func didChooseToPlaceAnOrder(for product: Product, forUser user: User)
}

class OrderSummrayViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var productNameLabel: UILabel!
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var placeOrderButton: UIButton!
  @IBOutlet weak var addressTextField: UITextField!

  // MARK: - Variables

  var productsViewModel: ProductsViewModel!
  var orderViewModel: OrderViewModel!
  var delegate: OrderSummaryActionsDelegate?

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    let config = StoreInfoConfig()
    let handler = DataService(configuration: config)
    orderViewModel = OrderViewModel(dataHandler: handler)

    delegate = orderViewModel

    guard let selectedProduct = productsViewModel.selectedProduct else {
      assertionFailure("This should not happen. Product must be selected.")
      return
    }
    productNameLabel.text = selectedProduct.name
    productImageView.image = UIImage(named: selectedProduct.image)
    amountLabel.text = "Rs: \(selectedProduct.price)"
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: self.view.window
    )
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: self.view.window
    )
  }

  // MARK: - Member functions

  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
    )?.cgRectValue {
      if self.view.frame.origin.y == 0 {
        self.view.frame.origin.y -= keyboardSize.height
      }
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }

  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let orderViewController: OrderDoneViewController =
      segue.destination as? OrderDoneViewController
    else {
      assertionFailure("Destination is not OrderDoneViewController")
      return
    }
    orderViewController.orderViewModel = orderViewModel
  }

  // MARK: - IBActions

  @IBAction func placeOrderButtonTapped(_ sender: Any) {
    // Safe to force unwrap as the button is enabled only when text field has some text and
    // since we are on order summary page, selectedProduct must also hold some value.
    delegate?.didChooseToPlaceAnOrder(
      for: productsViewModel.selectedProduct!,
         forUser: User(address: addressTextField.text!)
    )
  }
}

// MARK: - Text field delegate

extension OrderSummrayViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.view.endEditing(true)
      return false
  }

  func textFieldDidChangeSelection(_ textField: UITextField) {
    placeOrderButton.isEnabled = !(addressTextField.text?.isEmpty ?? false)
  }
}

