//
//  TasksListViewModel.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift
import RxCocoa

class TasksListViewModel: ViewModel {
    private let callManager = AppDelegate.shared.callManager
    private let apiService = ApiService()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selectedTask: AnyObserver<Task>
    }
    
    let input: Input
    
    let selectedTaskSubject = PublishSubject<Task>()
    let openChatView = PublishSubject<Void>()
    
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
        apiService.getTasksList()
            .flatMap { [unowned self] objects -> Observable<[Task]> in
                isLoadingSubject.onNext(false)
                return prepareTasks(from: objects)
            }
            .bind(to: tasksSubject)
            .disposed(by: disposeBag)
        
        setupCallManager()
    }
}

private extension TasksListViewModel {
    func prepareTasks(from objects: [TaskObject]) -> Observable<[Task]> {
        return .just(objects.map { Task(from: $0) })
    }
    
    func setupCallManager() {
        
        callManager.endHandler = { [weak self] in
            guard let self = self else { return }
            self.openChatView.onNext(())
        }
        
        let backgroundTaskIdentifier =
            UIApplication.shared.beginBackgroundTask(expirationHandler: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            AppDelegate.shared.displayIncomingCall(
                uuid: UUID()
            ) { _ in
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
    }
}
