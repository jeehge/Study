//
//  LoginReactor.swift
//  rxLoginView
//
//  Created by JH on 21/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class LoginReactor: Reactor {
    
    enum Action {
        // actiom cases
        case login
        case id(String)
        case pw(String)
    }
    
    // Action
    enum Mutation {
        // mutation cases
        case validateLogin
        case validate(Bool)
        case setID(id: String)
        case setPW(pw: String)
    }
    
    struct State {
        //state
        var id: String?
        var pw: String?
        var isEnableButton: Bool
        var completeText: String
    }
    
    let initialState: State
    
    init() {
        // init state initialState = State(...)
        self.initialState = State(id: nil, pw: nil, isEnableButton: false, completeText: "(로그인 전)")
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         case .id(let idString):
            return Observable.concat([
                Observable.just(Mutation.setID(id: idString)),
                Observable.just(Mutation.validate(self.validate(id:  idString, pw: currentState.pw)))])
//            return Observable.just(Mutation.setID(id: idString))
         case .pw(let pwString):
            return Observable.concat([
                Observable.just(Mutation.setPW(pw: pwString)),
                Observable.just(Mutation.validate(self.validate(id: currentState.id, pw: pwString)))])
//            return Observable.just(Mutation.setPW(pw: pwString))
         case .login:
            return Observable.just(Mutation.validateLogin)
        }

    }
    
    // 이전에 갖고있던 state
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case .setID(let id):
            newState.id = id
            newState.isEnableButton = validate(id: newState.id, pw: newState.pw)
         case .setPW(let pw):
            newState.pw = pw;
            newState.isEnableButton = validate(id: newState.id, pw: newState.pw)
         case .validate(let valid):
            newState.isEnableButton = valid
         case .validateLogin:
            if state.isEnableButton {
                newState.completeText = "성공"
            } else {
                newState.completeText = "실패"
            }
        }
        return newState
    }
    
    private func validate(id: String?, pw: String?) -> Bool {
        guard let id = id, let pw = pw else { return false }
        // 아이디는 6자 이상 패스워드는 8자 이상
        return id.count >= 6 && pw.count >= 8
    }
    
}
