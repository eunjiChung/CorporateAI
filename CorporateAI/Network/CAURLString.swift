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
    case dialog(model: CADialogModel)
}

extension CACoronaAPI: TargetType {

    var baseURL: URL { return URL(string: CAURLString.baseURL)! }

    var path: String {
        switch self {
        case .main:                         return "/main"
        case .local:                        return "/local"
        case .dialog(_):                    return "/dialogflow"
        }
    }

    var method: Moya.Method {
        switch self {
        case .main, .local, .dialog:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .main, .local:
            return .requestPlain
        case .dialog(let model):
            return .requestJSONEncodable(model)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        let param = [
            "Content-Type": "application/json",
            "Authorization": "ai_company"
        ]
        return param
    }
}
