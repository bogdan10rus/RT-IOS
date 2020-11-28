//
//  TaskResultView.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa

class TaskResultView: UIViewController {
    
    private let viewModel: TaskResultViewModel
    
    private let progressBarOne: ProgressBar = {
        let pb = ProgressBar(frame: CGRect(x: 0, y: 0, width: 250, height: 250), progress: 30, progressColor: UIColor.ExtraColor.c1, radius: 125)
        return pb
    }()
    
    private let progressBarTwo: ProgressBar = {
        let pb = ProgressBar(frame: CGRect(x: 0, y: 0, width: 250, height: 250), progress: 70, progressColor: UIColor.ExtraColor.c2, radius: 105)
        return pb
    }()
    
    private let progressBarThree: ProgressBar = {
        let pb = ProgressBar(frame: CGRect(x: 0, y: 0, width: 250, height: 250), progress: 60, progressColor: UIColor.ExtraColor.c3, radius: 85)
        return pb
    }()
    
    init (viewModel: TaskResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Результат"
        tabBarItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupLayout()
        
    }
    
    private func setupViews() {
        view.addSubview(progressBarOne)
        view.addSubview(progressBarTwo)
        view.addSubview(progressBarThree)
    }

    private func setupLayout() {
        progressBarOne.snp.makeConstraints{make in
            make.center.equalToSuperview().offset(-125)
        }
        
        progressBarTwo.snp.makeConstraints{make in
            make.center.equalToSuperview().offset(-125)
        }
        
        progressBarThree.snp.makeConstraints{make in
            make.center.equalToSuperview().offset(-125)
        }
    }

}
