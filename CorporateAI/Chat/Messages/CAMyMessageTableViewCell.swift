//
//  CAMyMessageTableViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/21.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit

final class CAMyMessageTableViewCell: UITableViewCell {

    static let id = "CAMyMessageTableViewCell"

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        messageView.layer.cornerRadius = 40
    }

}
