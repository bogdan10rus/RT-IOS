//
//  DictionaryView.swift
//  TalkyFoxy
//
//  Created by Bogdan on 27.11.2020.
//

import RxSwift
import RxCocoa

class DictionaryView: UIViewController {
    
    private let viewModel: DictionaryViewModel
    
    init (viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Словарь"
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
