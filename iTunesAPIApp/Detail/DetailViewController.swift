//
//  DetailViewController.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewContoller: UIViewController{
    
    let mainView = DetailView()
    let viewModel = DetailViewModel()
    var detailData: AppInfo?
    private let disposeBag = DisposeBag()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    
    private func bind() {
        guard let data = detailData else { return }
        let input = DetailViewModel.Input(model: data)
        let output = viewModel.transform(input: input)
        
        output.model
            .bind(with: self) { owner, value in
                owner.setUpUI(data: value)
            }.disposed(by: disposeBag)
    }
    
    private func setUpUI(data: AppInfo){
        
        let iconURLString = data.artworkUrl512
        let screenShotURLString = data.screenshotUrls
        
        DispatchQueue.global().async { [weak self] in
            let image = self?.setImage(urlString: iconURLString)
            DispatchQueue.main.async {
                self?.mainView.appIconImageView.image = image
            }
        }
        mainView.appNameLabel.text = data.trackName
        mainView.sellerNameLabel.text = data.sellerName
        mainView.versionLabel.text = data.version
        mainView.releaseNotesLabel.text = data.releaseNotes
        mainView.descriptionLabel.text = data.description
    }
    private func setscreenshot(urls: [String]) -> [UIImage?]{
        var result: [UIImage?] = []
        for (index,urlString) in urls.enumerated() {
            if index > 2 {
                break
            }
            let image = setImage(urlString: urlString)
            result.append(image)
        }
        return result
    }
    
    private func setImage(urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else {
            print("url 변환불가")
            return nil
        }
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
