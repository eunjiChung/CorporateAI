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
    case location
}

final class CAMainViewModel {

    var data = BehaviorSubject<[TableRow]>(value: TableRow.allCases)

    var mainModel: CAMainModel?

    var didSuccessGetMainData: (()->Void)?

    func requestMain() {
        CANetworkAdapter.requestRx(target: CACoronaAPI.main)
            .subscribe(onNext: { data in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let jsonData = try Data(base64Encoded: json["result"] as? String ?? "")
                        print("jsonData", jsonData)
                        print("====================================================")
                        let result = try JSONDecoder().decode(CAResultMeta.self, from: jsonData!)
                        print("result", result)
                        //                    let jsonData = try Data(base64Encoded: json["result"] as? String)
                        //                    let result = try JSONDecoder().decode(CAResultMeta.self, from: jsonData)
                        //                    let result = json["result"] as? CAResultMeta
                        //                    self.mainModel = result?.resultMessage
                        //                    self.didSuccessGetMainData?()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("Completed!!!")
            })
    }
}
