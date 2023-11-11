//
//  File.swift
//  SeSACRxThreads
//
//  Created by 이상남 on 2023/11/06.
//

import Foundation
import RxSwift

enum NetWorkError : Error {
    case invalidURL
    case nuknown
    case statusError
    
}


class ApIMAnager {
    
    
    static func fetchData(text: String) -> Observable<SearchAppModel> {
        
        return Observable<SearchAppModel>.create { value in
            
            let urlString = "https://itunes.apple.com/search?term=\(text)&country=KR&media=software&limit=30"
            let encodeStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            guard let url = URL(string: encodeStr) else {
                value.onError(NetWorkError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("URLSession Succeced")
                
                if let _ = error {
                    value.onError(NetWorkError.nuknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value.onError(NetWorkError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data){
                    print(appData)
                    value.onNext(appData)
                    
                }
                
            }.resume()
            
            return Disposables.create()
            
        }
    }
}
