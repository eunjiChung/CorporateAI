//
//  CAMainHeadTableViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit

class CAMainHeadTableViewCell: UITableViewCell {
    
    static let identifier = "CAMainHeadTableViewCell"
    
    @IBOutlet weak var showInstruction: UIButton!

    var didTouchInstruction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        showInstruction.layer.cornerRadius = 20
        showInstruction.layer.borderWidth = 1
        showInstruction.layer.borderColor = UIColor(red: 0.094, green: 0.392, blue: 0.671, alpha: 1).cgColor
    }

    @IBAction func didTouchInstruction(_ sender: Any) {
        didTouchInstruction?()
    }
}
