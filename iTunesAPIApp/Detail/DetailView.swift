//
//  DetailView.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/09.
//

import UIKit

class DetailView: UIView {
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "앱이름"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let sellerNameLabel = {
        let label = UILabel()
        label.text = "회사이름"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    let releaseTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.text = "새로운 소식"
        return label
    }()
    
    let versionLabel = {
        let label = UILabel()
        label.text = "버전 1.11.1"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    let releaseNotesLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식어쩌구저쩌구 새로운 업데이트 소식"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    
    let collectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 수직 스크롤
        layout.minimumInteritemSpacing = 10 // 아이템 간의 최소 간격
        layout.minimumLineSpacing = 10 // 라인(행) 간의 최소 간격
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemPink
        return collectionView
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개어쩌구 저쩌구 앱소개"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemYellow
//        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let contentView = UIView()
    lazy var contentList: [UIView] = [ appIconImageView, appNameLabel, sellerNameLabel, downloadButton,
                                       releaseTitleLabel,versionLabel,releaseNotesLabel,
                                       collectionView,descriptionLabel ]
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setconfigure()
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: configure()
extension DetailView {
    private func setconfigure(){
        setScrollerView()
        setContentView()
        setContentViewChiled()
    }
    
    private func setScrollerView(){
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func setContentView(){
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .brown
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView).inset(20)
            
        }
    }
    
    private func setContentViewChiled(){
        contentList.forEach { contentView.addSubview($0) }
        setAppIconConstraints()
        setAppNameLabelConstraints()
        setSellerNameLabel()
        setDownloadButton()
        setReleaseTitleLabel()
        setVersionLabel()
        setReleaseNotesLabel()
        setCollectionView()
        setDescriptionLabel()
    }
    private func setAppIconConstraints(){
        appIconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView)
            make.size.equalTo(100)
        }
    }
    private func setAppNameLabelConstraints(){
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.top)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    private func setSellerNameLabel() {
        sellerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView)
            make.leading.equalTo(appNameLabel)
            make.trailing.lessThanOrEqualTo(appNameLabel.snp.trailing)
        }
    }
    private func setDownloadButton() {
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(72)
            make.leading.equalTo(appNameLabel)
            make.bottom.equalTo(appIconImageView.snp.bottom)
        }
    }
    private func setReleaseTitleLabel(){
        releaseTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.leading)
            make.top.equalTo(appIconImageView.snp.bottom).offset(20)
        }
    }
    
    private func setVersionLabel(){
        versionLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.leading)
            make.top.equalTo(releaseTitleLabel.snp.bottom).offset(10)
        }
    }
    private func setReleaseNotesLabel(){
        releaseNotesLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(20)
            make.leading.equalTo(appIconImageView.snp.leading)
            make.trailing.equalToSuperview()
        }
    }
    private func setCollectionView(){
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.7)
            make.top.equalTo(releaseNotesLabel.snp.bottom).offset(30)
            make.width.equalTo(self.safeAreaLayoutGuide)
            
            make.leading.equalTo(contentView.snp.leading)
        }
    }
    
    private func setDescriptionLabel(){
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView)
        }
    }
    
}


