//
//  ChatViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class ChatViewModel: ViewModel {
    private let speechRecognizer = SpeechRecognizer()
    
    struct Input {
        
    }
    
    let input: Input
    
    struct Output {
        let messages: Driver<[Message]>
    }
    
    let output: Output
    
    private let messagesSubject = BehaviorSubject<[Message]>(value: [])
    
    init() {
        input = Input()
        
        let messages = messagesSubject
            .asDriver(onErrorJustReturn: [])
        
        output = Output(messages: messages)
        
        messagesSubject.onNext([
            .init(sender: .bot, text: "Hi"),
            .init(sender: .user, text: "Hello, my name is Egor. Whats your name?"),
            .init(sender: .bot, text: "Nice to meet you, Egor! My name is Foxy. How are you?"),
            .init(sender: .user, text: "I'm fine, what about you?"),
            .init(sender: .bot, text: "I'm fine too, thanks"),
        ].reversed())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [unowned self] in
            let messages = (try? messagesSubject.value()) ?? []
            messagesSubject.onNext([.init(sender: .bot, text: "I'm fine too, thanks2222")] + messages)
        }
    }
}
