//
//  ProfileView.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class ProfileView: UIViewController {
    
    private let viewModel: ProfileViewModel
    
    init (viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Профиль"
        tabBarItem.title = title
        tabBarItem.image = #imageLiteral(resourceName: "profile_ic")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

}
