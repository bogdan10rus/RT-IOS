//
//  BotApiService.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation
import Assistant
import RxSwift

class BotApiService {
    private let apiKey = "JjxFHNz2mKx4DuZ_y9zqeUns3wQf_9rrsPVq8kxt2J-3"
    private let disposeBag = DisposeBag()
    
    private let authenticator: WatsonIAMAuthenticator
    private let assistant: Assistant
    
    private var context: Context?
    
    private let requestTextSubject = PublishSubject<String>()
    private let responseTextSubject = PublishSubject<String>()
    
    var requestText: AnyObserver<String> {
        requestTextSubject.asObserver()
    }
    
    var responseText: Observable<String> {
        responseTextSubject.asObservable()
    }
    
    init() {
        authenticator = WatsonIAMAuthenticator(apiKey: apiKey)
        assistant = Assistant(version: "2020-04-01", authenticator: authenticator)
        assistant.serviceURL = "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/9ff4b198-0b0b-47d1-bb70-8391eb31ccc4"
        
        requestTextSubject
            .flatMap { [unowned self] request -> Observable<String> in
                let input = MessageInput(text: request)
                
                let responseSubject = PublishSubject<String>()
                
                assistant.message(workspaceID: "6bdfb4ed-6e78-4dd6-9682-c3ddfe10aa4b", input: input, context: context) { response, error in
                    let responseText = response?.result?.output.text[0] ?? "I don`t understand you"
                    context = response?.result?.context
                    
                    responseSubject.onNext(responseText)
                }
                
                return responseSubject
                    .take(1)
            }
            .bind(to: responseTextSubject)
            .disposed(by: disposeBag)
    }
}
