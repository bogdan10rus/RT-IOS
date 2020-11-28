//
//  TasksListCoordinator.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift

class TasksListCoordinator: Coordinator<Void> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = TasksListViewModel()
        let viewController = TasksListView(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.openChatView
            .flatMap { [unowned self] _ -> Observable<TaskResult> in
                let chatCoordinator = ChatCoordinator(navigationController: navigationController)
                return coordinate(to: chatCoordinator)
            }
            .flatMap { [unowned self] result -> Observable<Void> in
                let resultCoordinator = TaskResultCoordinator(navigationController: navigationController, result: result)
                return coordinate(to: resultCoordinator)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
}
