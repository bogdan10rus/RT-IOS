//
//  ChatCoordinator.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class ChatCoordinator: Coordinator<TaskResult> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<TaskResult> {
        let viewModel = ChatViewModel()
        let viewController = ChatView(viewModel: viewModel)
        
        navigationController.present(viewController, animated: true, completion: nil)
        
        viewModel.openResultScreenSubject
            .subscribe(onNext: { result in
                viewController.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        return viewModel
            .openResultScreenSubject
            .take(1)
    }
}
