//
//  ChatView.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa
import SnapKit
import Assistant

class ChatView: UIViewController {
    
    private let viewModel: ChatViewModel
    private let disposeBag = DisposeBag()
    
    private let messagesCellId = "messageCellId"
    
    private let endCallBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Завершить", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        
        return btn
    }()
    
    private let messagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return tableView
    }()
    
    
    init (viewModel: ChatViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Чат"
        tabBarItem.title = title
        
        messagesTableView.register(MessageCell.self, forCellReuseIdentifier: messagesCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1490196078, alpha: 1)
        
        setupViews()
        setupLayout()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.input.viewDidAppear.onNext(())
    }
    
    private func setupViews() {
        view.addSubview(messagesTableView)
        view.addSubview(endCallBtn)
    }
    
    private func setupLayout() {
        messagesTableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        endCallBtn.snp.makeConstraints { make in
            make.top.equalTo(messagesTableView.snp.bottom)
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }
    
    private func setupBindings() {
        viewModel.output.messages
            .drive(messagesTableView.rx.items) { [unowned self] tableView, index, message in
                let indexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: messagesCellId, for: indexPath) as? MessageCell else { return UITableViewCell() }
                
                cell.setup(with: message)
                cell.transform = CGAffineTransform(scaleX: 1, y: -1)
                return cell
            }
            .disposed(by: disposeBag)
        
        endCallBtn.rx.tap
            .bind(to: viewModel.input.endCallButtonTap)
            .disposed(by: disposeBag)
    }
}
