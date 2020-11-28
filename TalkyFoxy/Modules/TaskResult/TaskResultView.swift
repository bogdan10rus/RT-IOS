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
    
    private let progressItemOne: ProgressItem = {
        let pi = ProgressItem(progress: 30, progressColor: UIColor.ExtraColor.c1, title: "text1")
        return pi
    }()

    private let progressItemTwo: ProgressItem = {
        let pi = ProgressItem(progress: 70, progressColor: UIColor.ExtraColor.c2, title: "text2")
        return pi
    }()
    
    private let progressItemThree: ProgressItem = {
        let pi = ProgressItem(progress: 60, progressColor: UIColor.ExtraColor.c3, title: "text3")
        return pi
    }()
    
    private let headerWrapper: UIImageView = {
        let header = UIImageView(frame: .zero)
        header.image = #imageLiteral(resourceName: "img")
        header.contentMode = .scaleToFill
        return header
    }()
    
    private let userAvatar: UIImageView = {
        let header = UIImageView(frame: .zero)
        header.image = #imageLiteral(resourceName: "boy")
//        header.backgroundColor = .gray
        header.layer.cornerRadius = 60
        header.clipsToBounds = true
        header.contentMode = .scaleAspectFill
        return header
    }()
    
    private let progressWrapper: UIView = {
        let header = UIView(frame: .zero)
        return header
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let progressStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
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
        headerWrapper.addSubview(headerTitle)
        
        progressWrapper.addSubview(progressBarOne)
        progressWrapper.addSubview(progressBarTwo)
        progressWrapper.addSubview(progressBarThree)
        progressWrapper.addSubview(userAvatar)
        
        progressStack.addArrangedSubview(progressItemOne)
        progressStack.addArrangedSubview(progressItemTwo)
        progressStack.addArrangedSubview(progressItemThree)
        
        progressWrapper.addSubview(progressStack)
        
        view.addSubview(headerWrapper)
        view.addSubview(progressWrapper)
    }
    
    private func setupLayout() {
        headerTitle.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
        
        headerWrapper.snp.makeConstraints{make in
            make.trailing.top.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        progressBarOne.snp.makeConstraints{make in
            make.centerX.equalToSuperview().offset(-125)
            make.top.equalToSuperview().offset(40)
        }
        
        progressBarTwo.snp.makeConstraints{make in
            make.centerX.equalToSuperview().offset(-125)
            make.top.equalToSuperview().offset(40)
        }
        
        progressBarThree.snp.makeConstraints{make in
            make.centerX.equalToSuperview().offset(-125)
            make.top.equalToSuperview().offset(40)
        }
        
        userAvatar.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerWrapper.snp.bottom).offset(100)
            make.height.width.equalTo(120)
        }
        
        progressWrapper.snp.makeConstraints{make in
            make.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(headerWrapper.snp.bottom)
        }
        
        progressItemOne.snp.makeConstraints{make in
            make.height.equalToSuperview()
        }
        
        progressItemTwo.snp.makeConstraints{make in
            make.height.equalToSuperview()
        }
        
        progressItemThree.snp.makeConstraints{make in
            make.height.equalToSuperview()
        }
        
        progressStack.snp.makeConstraints{make in
            make.trailing.bottom.leading.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
}
