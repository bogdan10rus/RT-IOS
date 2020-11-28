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
    
    private let endCallBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Завершить", for: .normal)
        
        return btn
    }()
    
    let tableView = UITableView()
    var messages : [Message] = [Message(sender: .bot, text: "Hi")]
    
    
    
    init (viewModel: ChatViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Чат"
        tabBarItem.title = title
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        
        endCallBtn.addTarget(self, action: #selector(endCall), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        AppDelegate.shared.callManager.endHandler = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
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
    
    override func loadView() {
        super.loadView()
        setupTableView()
        
        view.addSubview(endCallBtn)
        
        endCallBtn.snp.makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(view)
            make.bottom.height.equalTo(100)
            make.top.equalTo(tableView.snp.bottom)
        }
    }
}

extension ChatView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.textLabel?.textAlignment = message.sender == .bot ? .left : .right
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
    
}


extension ChatView {
    func setupTableView(){
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        let author: Sender = Int.random(in: 0...1) == 0 ? .bot : .user
        self.messages.insert(Message(sender: author, text: "New message"), at: 0)
        self.tableView.reloadData()
    }
    
    @objc func endCall(sender:UIButton) {
        AppDelegate.shared.callManager.endCall()
    }
}

struct Message {
    let sender: Sender
    let text: String
    
    init(sender: Sender, text: String) {
        self.sender = sender
        self.text = text
    }
}

enum Sender {
    case bot
    case user
}
