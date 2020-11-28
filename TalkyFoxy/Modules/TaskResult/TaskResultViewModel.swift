//
//  TaskResultViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class TaskResultViewModel: ViewModel {
    private let result: TaskResult
    struct Input {
        
    }
    
    let input: Input
    
    struct Output {
        
    }
    
    let output: Output
    
    init(result: TaskResult) {
        self.result = result
        input = Input()
        output = Output()
    }
}
