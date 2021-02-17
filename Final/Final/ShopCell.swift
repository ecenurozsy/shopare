//
//  ShopCell.swift
//  Final
//
//  Created by ECENUR on 10.02.2021.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pCategory: UILabel!
    @IBOutlet weak var pPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
