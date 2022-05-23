//
//  OrderDoneViewController.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/19/22.
//

import UIKit

class OrderDoneViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var continueShoppingButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  // MARK: - Variables

  var orderViewModel: OrderViewModel!

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.hidesBackButton = true
    overlayView.isHidden = false
    activityIndicator.startAnimating()

    setupBinding()
    orderViewModel.placeOrder()
    // Do any additional setup after loading the view.
  }

  // MARK: - Member functions

  private func setupBinding() {
    orderViewModel.orderPlaced = { [weak self] in

      // Dismissing the loader after 2 seconds.
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self?.activityIndicator.stopAnimating()
        self?.overlayView.isHidden = true
        self?.continueShoppingButton.isUserInteractionEnabled = true
        self?.continueShoppingButton.isEnabled = true
      }
    }
  }

  // MARK: - IBActions
  
  @IBAction func continueShoppingButtonTapped(_ sender: Any) {
    navigationController?.popToRootViewController(animated: false)
  }
}
