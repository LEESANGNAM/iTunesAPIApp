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

class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        title = "\(Int.random(in:1...100))"
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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configure()
        bind()
        setSearchController()
    }
     
    func bind() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
//                cell.appNameLabel.text = element.trackName
//                cell.appIconImageView.backgroundColor = .green
                cell.setData(app: element)
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }.disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                owner.text.accept(value)
                print("== 실시간 검색 ==",value)
            }.disposed(by: disposeBag)
        
        text.bind(with: self) { owner, value in
            let request = ApIMAnager.fetchData(text: value)
            
            request.subscribe(with: self) { owner, result in
                owner.items.onNext(result.results)
            } onError: { owner, error in
                print(error)
            }.disposed(by: owner.disposeBag)

        }.disposed(by: disposeBag)
        
//        let request = ApIMAnager
//            .fetchData()
//            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
//
//        request
//            .drive(with: self) { owner, result in
//                owner.items.onNext(result.results)
//            }.disposed(by: disposeBag)
//
//        request
//            .map { data in
//                "\(data.results.count)"
//
//            }
//            .drive(with: self) { owner, result in
//                owner.navigationItem.title = result
//            }.disposed(by: disposeBag)
        

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
