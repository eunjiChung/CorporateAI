//
//  CARankCellViewModel.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/19.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation
import RxSwift

struct RankModel {
    var location: String
    var percent: Double
    var total: Int
    var increase: Int
}

struct CARankSectionModel {
    var index: Int
    var ranks: [RankModel]
}

final class CARankCellViewModel {

    // MARK: - Properties
    var rankModel: [CALocalModel]? {
        didSet {
            bindToList()
            generateMain()
        }
    }
    var ranks: [RankModel] = []
    var itemsObservable = PublishSubject<[CARankSectionModel]>()

    // MARK: - Init
    init() {

    }

    // MARK: - Private Methods
    private func bindToList() {
        guard let rankModel = self.rankModel, !rankModel.isEmpty else { return }
        var result: [RankModel] = []
        rankModel.forEach {
            result.append(RankModel(location: $0.gubun, percent: Double($0.qurRate)!, total: $0.defCnt, increase: Int($0.incDec)!))
        }
        ranks = result
    }

    private func generateMain() {
        let result: [CARankSectionModel] = [
            CARankSectionModel(index: 0, ranks: Array(ranks[0...5])),
            CARankSectionModel(index: 1, ranks: Array(ranks[6...11])),
            CARankSectionModel(index: 2, ranks: Array(ranks[12...])),
        ]
        itemsObservable.onNext(result)
    }
}
