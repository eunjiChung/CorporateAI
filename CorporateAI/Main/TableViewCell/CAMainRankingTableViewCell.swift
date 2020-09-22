//
//  CAMainRankingTableViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CAMainRankingTableViewCell: UITableViewCell {
    
    static let identifier = "CAMainRankingTableViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    let viewModel = CARankCellViewModel()
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        bind()
    }

    private func bind() {
        viewModel.itemsObservable
            .bind(to: collectionView.rx.items(cellIdentifier: CARankCollectionViewCell.id, cellType: CARankCollectionViewCell.self)) { index, item, cell in
                self.pageControl.currentPage = item.index
                cell.setRanks(item.ranks, item.index)
        }
        .disposed(by: disposeBag)
    }

}

extension CAMainRankingTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 378)
    }

}
