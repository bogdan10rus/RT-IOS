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
    private let apiKey = "7lb1sAmrZdG2DvID4U3F1UYfAmI4LZUTNA_Y0E5hQdip"
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
        assistant.serviceURL = "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/ae397f84-1cba-462c-99ea-320eb62c2d0f"
        
        requestTextSubject
            .flatMap { [unowned self] request -> Observable<String> in
                let input = MessageInput(text: request)
                
                let responseSubject = PublishSubject<String>()
                
                assistant.message(workspaceID: "777dc3d7-bd5b-4b10-b271-daa8985cd78c", input: input, context: context) { response, error in
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
