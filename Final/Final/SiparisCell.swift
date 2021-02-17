//
//  SiparisCell.swift
//  Final
//
//  Created by ECENUR on 10.02.2021.
//

import UIKit
import Lottie

class SiparisCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        animationView.play()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
