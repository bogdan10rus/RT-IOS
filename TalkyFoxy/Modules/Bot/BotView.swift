//
//  BotView.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class BotView: UIViewController {
    
    private let viewModel: BotViewModel
    
    init (viewModel: BotViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Бот"
        tabBarItem.title = title
        tabBarItem.image = #imageLiteral(resourceName: "call_ic")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

}

