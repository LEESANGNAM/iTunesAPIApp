//
//  SearchViewModel.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/08.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    struct Input {
        let text: ControlProperty<String>
        let cellTap: ControlEvent<IndexPath>
        let modelSelect: ControlEvent<AppInfo>
    }
    
    struct Output {
        var items: Observable<Array<AppInfo>>
        var model: Observable<AppInfo>
        
    }
    var disposeBag = DisposeBag()
    
    
    
    
    func transform(input: Input) -> Output {
        let items = PublishSubject<[AppInfo]>()
        let text = input.text
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        text.bind(with: self) { owner, query in
            let request = ApIMAnager.fetchData(text: query)
            
            let _ = request.subscribe(with: self) { owner, result in
                items.onNext(result.results)
            } onError: { owner, error in
                print(error)
            }
        }.disposed(by: disposeBag)
        
        let model: Observable<AppInfo> = Observable.zip(input.cellTap, input.modelSelect)
            .map { $0.1 }
        
        
        
        
        return Output(items: items, model: model)
    }
    
}
