//
//  CARankCollectionViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/19.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit

final class CARankCollectionViewCell: UICollectionViewCell {

    static let id = "CARankCollectionViewCell"

    @IBOutlet var rankLabels: [UILabel]!
    @IBOutlet var locationLabels: [UILabel]!
    @IBOutlet var percentLabels: [UILabel]!
    @IBOutlet var barView: [UIView]!
    @IBOutlet var totalLabels: [UILabel]!

    override func awakeFromNib() {

    }

    func setRanks(_ models: [RankModel], _ index: Int) {
        rankLabels.forEach { $0.text = "\(($0.tag+1)+6*index)" }
        locationLabels.forEach { $0.text = models[$0.tag].location }
        percentLabels.forEach { $0.text = "\(models[$0.tag].percent)%" }
        totalLabels.forEach { $0.text = "\(models[$0.tag].total.withCommas())(+\(models[$0.tag].increase))" }
    }
}
