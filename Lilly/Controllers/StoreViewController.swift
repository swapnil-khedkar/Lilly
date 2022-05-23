//
//  StoreViewController.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import UIKit

/// Provides updates for user interactions in store view controller.
protocol StoreActionsDelegate {

  /// Provides callback when product is selected for checkout
  ///
  /// - Parameter :
  ///   - index of the selected product.
  func didCheckoutProduct(at index: Int)
}

class StoreViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var storeNameLabel: UILabel!
  @IBOutlet weak var checkoutButton: UIButton!
  @IBOutlet weak var productsTableView: UITableView!

  // MARK: - Variables

  var storeViewModel: StoreViewModel!
  var productsViewModel: ProductsViewModel!
  var delegate: StoreActionsDelegate?

  private enum Constants {
    static let cellIdentifier = "ProductCell"
  }

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    let storeConfig = StoreInfoConfig()
    let storeHandler = DataService(configuration: storeConfig)
    storeViewModel = StoreViewModel(dataHandler: storeHandler)

    let productsConfig = ProductsConfig()
    let productsHandler = DataService(configuration: productsConfig)
    productsViewModel = ProductsViewModel(dataHandler: productsHandler)

    setupBinding()
    storeViewModel.fetchStoreInfo()
    productsViewModel.fetchProducts()
  }

  // MARK: - Member functions

  private func setupBinding() {

    delegate = productsViewModel
    storeViewModel.storeInfoFetched = { [weak self] in
      self?.storeNameLabel.text = self?.storeViewModel.storeInfo.name
    }

    productsViewModel.productsFetched = { [weak self] in
      self?.productsTableView.reloadData()
    }
  }

  // MARK: - Navigtion

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let summaryViewController: OrderSummrayViewController =
            segue.destination as? OrderSummrayViewController
    else {
      assertionFailure("Destination is not OrderSummrayViewController")
      return
    }
    summaryViewController.productsViewModel = productsViewModel

    let indexPath = productsTableView.indexPathForSelectedRow
    // Safe to force unwrap here as product must be selected in order to move to next screen.
    productsTableView.deselectRow(at: indexPath!, animated: false)
  }


  // MARK: - IBActions

  @IBAction func checkoutButtonTapped(_ sender: Any) {
    guard let selectedIndexPath = productsTableView.indexPathForSelectedRow else {
      assertionFailure("Product must be selected for checkout.")
      return
    }
    delegate?.didCheckoutProduct(at: selectedIndexPath.row)
  }
}

// MARK: - Table view data source

extension StoreViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productsViewModel.products.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: Constants.cellIdentifier) as? ProductTableViewCell
    else {
      print("Could not dequeue ProductTableViewCell.")
      return UITableViewCell()
    }

    let product = productsViewModel.products[indexPath.row]
    cell.productNameLabel.text = product.name
    cell.productDescriptionTextView.text = product.description
    cell.productImageView.image = UIImage(named: product.image)
    cell.productPriceLabel.text = "Rs. \(product.price)"
    cell.productRatingLabel.text = "\(product.rating)*"

    return cell
  }
}

// MARK: - Table view delegate

extension StoreViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedCell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell else {
      return
    }
    selectedCell.isProductSelected = !selectedCell.isProductSelected

    if !selectedCell.isProductSelected {
      tableView.deselectRow(at: indexPath, animated: true)
      checkoutButton.isUserInteractionEnabled = false
      checkoutButton.isEnabled = false

    } else {
      checkoutButton.isUserInteractionEnabled = true
      checkoutButton.isEnabled = true
    }
  }

}
