//
//  TasksListViewModel.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift

class TasksListViewModel: ViewModel {
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
