//
//  HomeCell.swift
//  Deezer
//
//  Created by Hakan ERDOĞMUŞ on 16.10.2023.
//

import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    static let reuseID = "HomeCell"
    
    
    private var posterImageView: PosterImageView!
    private var datum: Datum?
    private var service: NetworkManager!
    private var labelText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configurePosterImageView()
        configureLabelText(text: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.cancelDownloading()
        labelText.text = nil
        //print("stop")
    }
    
    
    
    
    //MARK: Hücre ayarı
    private func configureCell() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func setCell(category: Datum) {
        posterImageView.downloadHomeImage(category: category)
    }
    
    private func configurePosterImageView() {
        
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setLabelText(nameCategory: Datum) {
        configureLabelText(text: nameCategory._name)
    }
    
    private func configureLabelText(text: String) {
    
        labelText = UILabel(frame: .zero)
        
        posterImageView.addSubview(labelText)
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        
       // labelText.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        //labelText.layer.opacity = 0.8
        
        
        
        labelText.text = text
        labelText.textColor = .white
        labelText.textAlignment = .center
        labelText.font = .boldSystemFont(ofSize: 20)
        
        labelText.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(-30)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
        
            make.centerX.equalToSuperview()
            
        }
    }
    
    
}
