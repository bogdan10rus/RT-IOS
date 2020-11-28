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
    private let apiService = ApiService()
    
    struct Input {
        let viewDidAppear: AnyObserver<Void>
        let endCallButtonTap: AnyObserver<Void>
    }
    
    let input: Input
    
    private let viewDidAppearSubject = PublishSubject<Void>()
    private let endCallButtonTapSubject = PublishSubject<Void>()
    let openResultScreenSubject = PublishSubject<TaskResult>()
    
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
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
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
            .flatMap { [unowned self] _  -> Observable<TaskResultObject> in
                speechRecognizer.stopListening()
                speechRecognizer.stopSpeaking()
                
                let messages = (try? messagesSubject.value()) ?? []
                
                return apiService.postTaskDialog(dialog: TaskDialogObject(userId: 1, taskId: 3, messages: messages.reversed()))
            }
            .debug()
            .flatMap { taskResultObject  -> Observable<TaskResult> in
                .just(TaskResult(from: taskResultObject))
            }
            .bind(to: openResultScreenSubject)
            .disposed(by: disposeBag)
    }
}

private extension ChatViewModel {
    func addNewMessage(from sender: Sender, text: String) {
        let messages = (try? messagesSubject.value()) ?? []
        messagesSubject.onNext([.init(sender: sender, text: text)] + messages)
    }
}
