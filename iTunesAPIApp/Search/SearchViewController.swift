//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

struct ITunesModel: SectionModelType {
    var items: [AppInfo]
}
extension ITunesModel {
    init(original: ITunesModel, items: [AppInfo]) {
        self = original
        self.items = items
    }
}

class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .systemBackground
        view.rowHeight = 320
        view.separatorStyle = .none
        return view
    }()
    
    let searchBar = UISearchBar()
    
    var data: [AppInfo] = []
    
    lazy var items = BehaviorSubject(value: data)
    lazy var text = BehaviorRelay(value: "")
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configure()
        bind()
        setSearchController()
    }
    
    func bind() {
        
        let input = SearchViewModel.Input(text: searchBar.rx.text.orEmpty, cellTap: tableView.rx.itemSelected, modelSelect: tableView.rx.modelSelected(AppInfo.self))
    
        
        let output = viewModel.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<ITunesModel>(
          configureCell: { dataSource, tableView, indexPath, item in
              guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
              cell.setData(app: item)
            return cell
        })
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.setData(app: element)
            }
            .disposed(by: disposeBag)
        
        
        
        output.model
            .bind(with: self) { owner, model in
                print("화면넘기기전에 값을넘겨보자",model)
                owner.navigationController?.pushViewController(DetailViewContoller(), animated: true)
            }.disposed(by: disposeBag)
        
        
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }
    
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
