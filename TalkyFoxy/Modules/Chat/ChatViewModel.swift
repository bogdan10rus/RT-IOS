//
//  ChatViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class ChatViewModel: ViewModel {
    private let speechRecognizer = SpeechRecognizer()
    
    struct Input {
        
    }
    
    let input: Input
    
    struct Output {
        
    }
    
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.speechRecognizer.speak(text: "Hi!")
        }
    }
}
