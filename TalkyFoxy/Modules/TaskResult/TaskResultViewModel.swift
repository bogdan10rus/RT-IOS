//
//  TaskResultViewModel.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class TaskResultViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    private let result: TaskResult
    
    struct Input {
        
    }
    
    let input: Input
    
    struct Output {
        let title: Driver<String>
        let taskRelevance: Driver<Int>
        let wordsPurity: Driver<Int>
        let vocabulary: Driver<Int>
    }
    
    let output: Output
    
    let titleSubject = BehaviorSubject<String>(value: "")
    let taskRelevanceSubject = BehaviorSubject<Int>(value: 0)
    let wordsPuritySubject = BehaviorSubject<Int>(value: 0)
    let vocabularySubject = BehaviorSubject<Int>(value: 0)
    
    init(result: TaskResult) {
        self.result = result
        input = Input()
        
        let title = titleSubject
            .asDriver(onErrorJustReturn: "")
        
        let taskRelevance = taskRelevanceSubject
            .asDriver(onErrorJustReturn: 0)
        
        let wordsPurity = wordsPuritySubject
            .asDriver(onErrorJustReturn: 0)
        
        let vocabulary = vocabularySubject
            .asDriver(onErrorJustReturn: 0)
        
        output = Output(title: title, taskRelevance: taskRelevance,
                        wordsPurity: wordsPurity, vocabulary: vocabulary)
        
        titleSubject.onNext(result.taskTitleEn)
        taskRelevanceSubject.onNext(result.taskRelevance)
        wordsPuritySubject.onNext(result.wordsPurity)
        vocabularySubject.onNext(result.vocabulary)
    }
}
