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
        
        return Observable.never()
    }
}
