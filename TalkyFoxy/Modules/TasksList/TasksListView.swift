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
        
        view.backgroundColor = .white
    }

}
