//
//  TaskResultCoordinator.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class TaskResultCoordinator: Coordinator<Void> {
    let navigationController: UINavigationController
    private let result: TaskResult
    
    init(navigationController: UINavigationController, result: TaskResult) {
        self.navigationController = navigationController
        self.result = result
    }
    
    override func start() -> Observable<Void> {
        let viewModel = TaskResultViewModel(result: result)
        let viewController = TaskResultView(viewModel: viewModel)
        
        navigationController.present(viewController, animated: true)
        
        return Observable.never()
    }
}
