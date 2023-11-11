//
//  SearchTableViewCell.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchTableViewCell: UITableViewCell {
    
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 16
        return button
    }()
    
    let ratingStarImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    let ratingLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    let sellerNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    let genresLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    let firstScreenShotImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    let secondScreenShotImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    let thirdScreenShotImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    
    lazy var imageStackView = {
       let view = UIStackView(arrangedSubviews: [firstScreenShotImageView,secondScreenShotImageView,thirdScreenShotImageView])
        view.spacing = 10
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func configure() {
        setAppIconImageView()
        setDownloadButton()
       setAppNameLabel()
        setRatingImageAndLabel()
        setSellerNameLabel()
        setgenresLabel()
        setScreenShotImageView()
    }
    
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchTableViewCell {
    
    private func setAppNameLabel(){
        contentView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
    }
    private func setAppIconImageView(){
        contentView.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
    }
    private func setDownloadButton(){
        
        contentView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    private func setRatingImageAndLabel(){
        contentView.addSubview(ratingStarImageView)
        contentView.addSubview(ratingLabel)
        
        ratingStarImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalTo(appIconImageView.snp.leading)
            make.top.equalTo(appIconImageView.snp.bottom).offset(5)
        }
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(ratingStarImageView.snp.trailing).offset(8)
            make.centerY.equalTo(ratingStarImageView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    private func setSellerNameLabel(){
        contentView.addSubview(sellerNameLabel)
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        genresLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        sellerNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ratingLabel.snp.top)
            make.leading.greaterThanOrEqualTo(ratingLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
    }
    private func setgenresLabel(){
        contentView.addSubview(genresLabel)
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(sellerNameLabel.snp.top)
            make.trailing.equalTo(downloadButton.snp.trailing)
            make.height.equalTo(20)
        }
    }
    private func setScreenShotImageView(){
        contentView.addSubview(imageStackView)
        imageStackView.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.leading)
            make.trailing.equalTo(downloadButton.snp.trailing)
            make.top.equalTo(ratingStarImageView.snp.bottom).offset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-5)
        }
        firstScreenShotImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.32)
//            make.height.equalTo(firstScreenShotImageView.snp.width).multipliedBy(5.0/3.0)
        }
        secondScreenShotImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.32)
//            make.height.equalTo(secondScreenShotImageView.snp.width).multipliedBy(5.0/3.0)
        }
        thirdScreenShotImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.32)
//            make.height.equalTo(thirdScreenShotImageView.snp.width).multipliedBy(5.0/3.0)
        }
        
    }
    func setData(app: AppInfo){
//        let screenshotUrls: [String] //스크린샷
//        let trackName: String // 이름
//        let genres: [String] // 장르
//        let sellerName: String // 개발자 이름
//        let averageUserRating: Double // 평균 평점
//        let artworkUrl512: String // 아이콘 이미지
        
        let iconURLString = app.artworkUrl512
        let screenShotURLString = app.screenshotUrls
        DispatchQueue.global().async {[weak self] in
            let iconIamge = self?.setImage(urlString: iconURLString)
            let images = self?.setscreenshot(urls: screenShotURLString)
            DispatchQueue.main.async {
                self?.appIconImageView.image = iconIamge
                self?.firstScreenShotImageView.image = images?[0]
                self?.secondScreenShotImageView.image = images?[1]
                self?.thirdScreenShotImageView.image = images?[2] // 두개만 있는경우도 있음 처리해야함
            }
        }
        
        let appname = app.trackName
        let rating = app.averageUserRating
        let seller = app.sellerName
        let genres = app.genres
        appNameLabel.text = appname
        ratingLabel.text = String(format: "%.1f", rating)
        sellerNameLabel.text = seller
        genresLabel.text = genres.first
        
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
