//
//  TasksListView.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift
import RxCocoa

class TasksListView: UIViewController {
    
    private let viewModel: TasksListViewModel
    
    var callManager: CallManager!
    
    init (viewModel: TasksListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Список заданий"
        tabBarItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callManager = AppDelegate.shared.callManager
        
        callManager.endHandler = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.present(ChatView(viewModel: ChatViewModel()), animated: true)
        }
        
        view.backgroundColor = .white
        
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
