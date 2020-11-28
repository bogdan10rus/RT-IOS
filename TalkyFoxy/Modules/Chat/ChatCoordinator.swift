//
//  ChatCoordinator.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class ChatCoordinator: Coordinator<Void> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = ChatViewModel()
        let viewController = ChatView(viewModel: viewModel)
        
        navigationController.present(viewController, animated: true, completion: nil)
        
        viewModel.endCallButtonTapSubject.subscribe(onNext: {
            viewController.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        return viewModel
            .endCallButtonTapSubject
            .take(1)
    }
}
