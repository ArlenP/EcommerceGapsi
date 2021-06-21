//
//  TableViewCellProducts.swift
//  EcommerceGapsi
//
//  Created by Arlen Peña on 21/06/21.
//

import UIKit

class TableViewCellProducts: UITableViewCell {

    @IBOutlet weak var ImgProducts: UIImageView!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
