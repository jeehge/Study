//
//  API.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import OAuthSwift
import RxSwift
import RxCocoa

struct API {
    
    let githubOAuth: OAuth2Swift = OAuth2Swift (
        consumerKey: "",
        consumerSecret: "",
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "code"
    )

    func getToken() -> Observable<(String, String)> {
        return Observable<(String, String)>.create({ (observer) -> Disposable in
            self.githubOAuth
                .authorize(withCallbackURL: URL(string: "IssuesApp://oauth-callback/github"),
                           scope: "user,repo",
                           state: "state",
                           completionHandler: { (result) in
                            switch result {
                            case .success(let (credentail, response, parameter)):
                                let oauthToken = credentail.oauthToken
                                let refreshToken = credentail.oauthRefreshToken
                                observer.onNext((oauthToken, refreshToken))
                                observer.onCompleted()
                            case .failure(let error):
                                observer.onError(error)
                                
                            }
                            
                })
            return Disposables.create {}
        })
    }
}
