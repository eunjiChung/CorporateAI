//
//  CAResponseModel.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/05.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation

struct CAResultModel<T: Decodable>: Decodable {
    var code: ResponseCode
    var message: String
    var result: CAResultMeta<T>
}

struct CAResultMeta<T: Decodable>: Decodable {
    var resultMessage: T
}

struct CAMainModel: Decodable {
    var defCnt: Int
    var incDec: String
    var localOccCnt: Int
    var locals: [CALocalModel]
    var nations: CANationsModel
    var overFlowCnt: Int
    var standardDt: String
}

struct CALocalModel: Decodable {
    var defCnt: Int
    var gubun: String
    var incDec: String
    var localOccCnt: Int
    var overFlowCnt: Int
    var qurRate: String
}

struct CANationsModel: Decodable {
    var gubun: String
    var nationList: [CANationModel]
}

struct CANationModel: Decodable {
    var createDt: String
    var defCnt: Int
    var incDec: String
    var localOccCnt: Int
    var overFlowCnt: Int
}
