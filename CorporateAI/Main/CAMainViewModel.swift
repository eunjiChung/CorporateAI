//
//  CAMainViewModel.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/05.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation
import RxSwift

enum TableRow: Int, CaseIterable {
    case head = 0
    case nation
    case rank
}

struct CAMainSectionModel {
    var type: TableRow
    var model: Any
}

final class CAMainViewModel {

    var mainModel = PublishSubject<[CAMainSectionModel]>()

    init() {
        requestMain()
    }

    func requestMain() {
        _ = CANetworkAdapter.requestRx(target: CACoronaAPI.main)
            .subscribe(onNext: { data in
                do {
                    let model = try JSONDecoder().decode(CAResultModel<CAMainModel>.self, from: data)
                    let result = model.result
                    self.generateMain(model: result.resultMessage)
                } catch {
                    print("❤️", error.localizedDescription)
                }
            }, onError: { error in
                print("❤️", error.localizedDescription)
            }, onCompleted: {
                print("Completed!!!")
            })
    }

    // MARK: - Private Methods
    private func generateMain(model: CAMainModel) {
        let result: [CAMainSectionModel] = [
            CAMainSectionModel(type: .head, model: ""),
            CAMainSectionModel(type: .nation, model: model),
            CAMainSectionModel(type: .rank, model: model.locals)
        ]
        mainModel.onNext(result)
    }
}
