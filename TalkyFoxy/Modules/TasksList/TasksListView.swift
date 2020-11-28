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
    private let disposeBag = DisposeBag()
    
    private let tasksTableViewCellId = "tasksTableViewCellId"
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        
        return view
    }()
    
    private let tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    init (viewModel: TasksListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Список заданий"
        tabBarItem.title = title
        tabBarItem.image = #imageLiteral(resourceName: "task_ic")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1490196078, alpha: 1)
        
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: tasksTableViewCellId)
        
        setupViews()
        setupLayout()
        setupBindings()
    }
    
    private func setupViews() {
        view.addSubview(tasksTableView)
        view.addSubview(activityIndicator)
    }

    private func setupLayout() {
        tasksTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    private func setupBindings() {
        viewModel.output.tasks
            .drive(tasksTableView.rx.items) { [unowned self] tableView, index, task in
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: tasksTableViewCellId, for: indexPath) as? TaskCell else { return UITableViewCell() }
            
                cell.setup(with: task)
                cell.selectionStyle = .none
            
                return cell
            }.disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .drive(onNext: { [unowned self] isLoading in
                isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
    }
}
