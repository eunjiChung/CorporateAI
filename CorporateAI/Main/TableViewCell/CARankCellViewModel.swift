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

final class CARankCellViewModel {

    let ranks = [
        RankModel(location: "대구", percent: 46.0, total: 6972, increase: 9),
        RankModel(location: "서울", percent: 16.2, total: 2749, increase: 124),
        RankModel(location: "경기", percent: 14.1, total: 2402, increase: 95),
        RankModel(location: "경북", percent: 8.4, total: 1435, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4),
        RankModel(location: "검역", percent: 7.0, total: 1314, increase: 4)
    ]

    var itemsObservable = BehaviorSubject<[Int]>(value: [0, 1, 2])

    init() {
    }

    func requestRankList() {
        CANetworkAdapter.requestRx(target: CACoronaAPI.rank)
            .subscribe(onNext: { data in

            }, onError: { error in

            }, onCompleted: {

            })
    }
}
