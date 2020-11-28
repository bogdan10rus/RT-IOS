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
        
        endCallBtn.addTarget(self, action: #selector(endCall), for: .touchUpInside)
        
        let authenticator = WatsonIAMAuthenticator(apiKey: "7lb1sAmrZdG2DvID4U3F1UYfAmI4LZUTNA_Y0E5hQdip")
        let assistant = Assistant(version: "2020-04-01", authenticator: authenticator)
        assistant.serviceURL = "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/ae397f84-1cba-462c-99ea-320eb62c2d0f"
        
        let input = MessageInput(text: "Hello")
        
        assistant.message(workspaceID: "777dc3d7-bd5b-4b10-b271-daa8985cd78c", input: input){
            (response, error) in
            self.messages.insert(Message(sender: .bot, text: response?.result?.output.text[0] ?? "I don`t understand you"), at: 0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(messagesTableView)
        view.addSubview(endCallBtn)
    }
    
    private func setupLayout() {
        messagesTableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        
        endCallBtn.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view)
            make.bottom.height.equalTo(100)
            make.top.equalTo(tableView.snp.bottom)
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
    }
}
