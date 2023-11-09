//
//  DetailViewModel.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/09.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModelType {
    var disposeBag =  DisposeBag()
    
    struct Input {
        let model:  AppInfo
    }
    
    struct Output {
        var model: Observable<AppInfo>
    }

    func transform(input: Input) -> Output {
        let result = Observable.just(input.model)
        
        return Output(model: result)
    }
}
