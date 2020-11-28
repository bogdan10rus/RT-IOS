//
//  ChatView.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift
import RxCocoa
import SnapKit

class ChatView: UIViewController {
    
    private let viewModel: ChatViewModel
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
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
            make.edges.equalTo(view)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        let author: Sender = Int.random(in: 0...1) == 0 ? .bot : .user
        self.messages.insert(Message(sender: author, text: "New message"), at: 0)
        self.tableView.reloadData()
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
