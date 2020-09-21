//
//  CAURLString.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation
import Moya

struct ResponseData {
    var data: Any?
    var urlResponse: HTTPURLResponse?
}

struct CAURLString {
    /******************************************************************************
        CoronaBot HOST URL
     ******************************************************************************/
    static let baseURL = "https://corona-base.herokuapp.com"
}

enum CACoronaAPI {
    case main
    case local

    case domestic
    case oversea
    case localOccur(city: String)
    case localDef(city: String)
    case rank
}

extension CACoronaAPI: TargetType {

    var baseURL: URL { return URL(string: CAURLString.baseURL)! }

    var path: String {
        switch self {
        case .main:                         return "/main"
        case .local:                        return "/local"

        case .domestic:                     return "/crn"
        case .oversea:                      return "/crn/oversea"
        case .localOccur(_):                return "/crn/local/occ"
        case .localDef(_):                  return "/crn/local/def"
        case .rank:                         return "/crn/rank"
        }
    }

    var method: Moya.Method {
        switch self {
        case .main, .local, .domestic, .oversea, .localOccur, .localDef, .rank:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .main, .local, .domestic, .oversea, .rank:
            return .requestPlain

        case .localOccur(let city), .localDef(let city):
            let param = ["city": city]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
//        let userAgent: String = KMUserDefaultsManager.shared.userAgent ?? ""
        let param = [
            "Content-Type": "application/json",
            "Authorization": "ai_company"
        ]

        return param
    }
}
