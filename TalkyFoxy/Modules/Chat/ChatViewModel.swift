//
//  ChatViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class ChatViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    private let speechRecognizer = SpeechRecognizer()
    private let botService = BotApiService()
    
    struct Input {
        let viewDidAppear: AnyObserver<Void>
        let endCallButtonTap: AnyObserver<Void>
    }
    
    let input: Input
    
    private let viewDidAppearSubject = PublishSubject<Void>()
    let endCallButtonTapSubject = PublishSubject<Void>()
    
    struct Output {
        let messages: Driver<[Message]>
    }
    
    let output: Output
    
    private let messagesSubject = BehaviorSubject<[Message]>(value: [])
    
    init() {
        input = Input(viewDidAppear: viewDidAppearSubject.asObserver(),
                      endCallButtonTap: endCallButtonTapSubject.asObserver())
        
        let messages = messagesSubject
            .asDriver(onErrorJustReturn: [])
        
        output = Output(messages: messages)
        
        viewDidAppearSubject
            .subscribe(onNext: { [unowned self] _ in
                speechRecognizer.listen()
            })
            .disposed(by: disposeBag)
        
        speechRecognizer
            .recognizedText
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0 != "" }
            .do(onNext: { [unowned self] text in
                speechRecognizer.stopListening()
                addNewMessage(from: .user, text: text)
            })
            .bind(to: botService.requestText)
            .disposed(by: disposeBag)
        
        botService
            .responseText
            .subscribe(onNext: { [unowned self] response in
                addNewMessage(from: .bot, text: response)
                speechRecognizer.speak(text: response)
            })
            .disposed(by: disposeBag)
        
        speechRecognizer
            .isSpeaking
            .skip(1)
            .filter { !$0 }
            .subscribe(onNext: { [unowned self] _ in
                speechRecognizer.listen()
            })
            .disposed(by: disposeBag)
        
        endCallButtonTapSubject
            .subscribe(onNext: { [unowned self] in
                speechRecognizer.stopListening()
                speechRecognizer.stopSpeaking()
            })
            .disposed(by: disposeBag)
    }
}

private extension ChatViewModel {
    func addNewMessage(from sender: Sender, text: String) {
        let messages = (try? messagesSubject.value()) ?? []
        messagesSubject.onNext([.init(sender: sender, text: text)] + messages)
    }
}
