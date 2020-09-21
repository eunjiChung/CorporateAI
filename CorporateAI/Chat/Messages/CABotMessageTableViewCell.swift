//
//  CABotMessageTableViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/21.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit

final class CABotMessageTableViewCell: UITableViewCell {

    static let id = "CABotMessageTableViewCell"

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        messageView.layer.cornerRadius = 40
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.3921568627, blue: 0.6705882353, alpha: 1)
    }

}
