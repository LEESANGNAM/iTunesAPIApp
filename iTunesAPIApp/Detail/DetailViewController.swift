//
//  DetailViewController.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct ScreenShotImageModel {
    var header: String
    var items: [Item]
}
extension ScreenShotImageModel: SectionModelType {
    typealias Item = String
    init(original: ScreenShotImageModel, items: [Item]) {
        self = original
        self.items = items
    }
}

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewHeight = mainView.collectionView.bounds.height
        let contentWidth = view.bounds.width * 0.6
        mainView.collectionView.collectionViewLayout = createCustomFlowLayout(height: collectionViewHeight, width: contentWidth)
        
        let initialOffset = CGPoint(x: 0, y: 0)

        // setContentOffset을 사용하여 초기 스크롤 위치 조정
        mainView.collectionView.setContentOffset(initialOffset, animated: false)
       }
    
    private func bind() {
        guard let data = detailData else { return }
        let input = DetailViewModel.Input(model: data)
        let output = viewModel.transform(input: input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<ScreenShotImageModel>(
          configureCell: { dataSource, collectionView, indexPath, item in
              guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
              cell.setData(imageUrls: item)
            return cell
        })
        output.screenShot
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.model
            .bind(with: self) { owner, value in
                owner.setUpUI(data: value)
            }.disposed(by: disposeBag)
    }
    private func createCustomFlowLayout(height: CGFloat, width: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let itemSize = CGSize(width: width, height: height)
        layout.itemSize = itemSize
        return layout
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
