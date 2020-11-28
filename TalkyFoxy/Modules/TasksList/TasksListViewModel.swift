//
//  TasksListViewModel.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift
import RxCocoa

class TasksListViewModel: ViewModel {
    struct Input {
        let selectedTask: AnyObserver<Task>
    }
    
    let input: Input
    
    let selectedTaskSubject = PublishSubject<Task>()
    
    struct Output {
        let tasks: Driver<[Task]>
        let isLoading: Driver<Bool>
    }
    
    let output: Output
    
    private let tasksSubject = BehaviorSubject<[Task]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    
    init() {
        input = Input(selectedTask: selectedTaskSubject.asObserver())
        
        let tasks = tasksSubject
            .asDriver(onErrorJustReturn: [])
        
        let isLoading = isLoadingSubject
            .asDriver(onErrorJustReturn: false)
        
        output = Output(tasks: tasks, isLoading: isLoading)
        
        isLoadingSubject.onNext(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.tasksSubject.onNext([
                .init(id: 0, name: "Task 1", time: "7pm"),
                .init(id: 1, name: "Task 2", time: "7 - 9pm"),
                .init(id: 2, name: "Task 3", time: "3pm"),
                .init(id: 3, name: "Task 4", time: "2pm"),
                .init(id: 4, name: "Task 5", time: "1pm"),
                .init(id: 5, name: "Task 6", time: "10pm"),
                .init(id: 6, name: "Task 1", time: "7pm"),
                .init(id: 7, name: "Task 2", time: "7 - 9pm"),
                .init(id: 8, name: "Task 3", time: "3pm"),
                .init(id: 9, name: "Task 4", time: "2pm"),
                .init(id: 10, name: "Task 5", time: "1pm"),
                .init(id: 11, name: "Task 6", time: "10pm"),
            ])
            
            self.isLoadingSubject.onNext(false)
        }
    }
}
