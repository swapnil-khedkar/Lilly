//
//  ProductTableViewCell.swift
//  Lilly
//
//  Created by swapnil khedkar on 5/18/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

  @IBOutlet weak var productNameLabel: UILabel!
  @IBOutlet weak var productDescriptionTextView: UITextView!
  @IBOutlet weak var productPriceLabel: UILabel!
  @IBOutlet weak var productRatingLabel: UILabel!
  @IBOutlet weak var productImageView: UIImageView!

  var isProductSelected: Bool = false

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
