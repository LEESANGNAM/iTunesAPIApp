//
//  DetailCollectionViewCell.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/10.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
       return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        setUI()
    }
    
    private func setUI(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setData(imageUrls: String) {
        DispatchQueue.global().async {[weak self] in
            let image = self?.setImage(urlString: imageUrls)
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
