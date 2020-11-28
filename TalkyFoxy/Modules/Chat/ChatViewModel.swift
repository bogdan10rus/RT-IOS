//
//  ChatViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class ChatViewModel: ViewModel {
    struct Input {
        
    }
    
    let input: Input
    
    struct Output {
        
    }
    
    let output: Output
    
    init() {
        input = Input()
        output = Output()
    }
}
