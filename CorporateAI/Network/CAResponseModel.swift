//
//  CAResponseModel.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/05.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation

struct CAResultModel: Decodable {
    var code: ResponseCode
    var message: String
    var result: CAMainModel
}

struct CAResultMeta<T: Decodable>: Decodable {
    var resultData: T
    var resultMessage: String
}

struct CAMainModel: Decodable {
    var defCnt: Int
    var incDec: String
    var localOccCnt: Int
    var locals: [CADomesticModel]
    var nations: CAAbroadModel
    var overFlowCnt: Int
    var standardDt: String
}

struct CADomesticModel: Decodable {
    var defCnt: Int
    var gubun: String
    var incDec: String
    var localOccCnt: Int
    var overFlowCnt: Int
    var qurRate: Double
}

struct CAAbroadModel: Decodable {
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

struct CADialogModel: Codable {
    var session: Int
    var text: String
}


