//
//  DictionaryViewModel.swift
//  TalkyFoxy
//
//  Created by Bogdan on 27.11.2020.
//

import RxSwift

class DictionaryViewModel: ViewModel {
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
