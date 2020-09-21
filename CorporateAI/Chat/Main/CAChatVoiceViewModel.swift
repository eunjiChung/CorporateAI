//
//  CAChatMainViewModel.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/20.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Foundation
import RxSwift

final class CAChatVoiceViewModel {

    var isVoiceOn: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)

    var firstDesc = BehaviorSubject<String>(value:"안녕하세요.\n코로나봇 입니다.\n무엇을 알려드릴까요?")
    var secondDesc = BehaviorSubject<String>(value: "“서울 경기 누적 확진자수 알려줘”\n“코로나 콜센터 번호 알려줘“")

    var searchDesc = PublishSubject<String>()

    init() {
        
    }
}
