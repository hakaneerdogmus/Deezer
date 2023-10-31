//
//  AlbumCell.swift
//  Deezer
//
//  Created by Hakan ERDOĞMUŞ on 17.10.2023.
//

import UIKit
import SnapKit
import AVFoundation

class AlbumCell: UICollectionViewCell {
    
    static let reuseID = "AlbumCell"
    
    private var posterImageView: PosterImageView!
    private var songName: UILabel!
    private var songDuration: UILabel!
    private var favoriteIcon: UIButton!
    private var audioPlayer: AVPlayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configurePosterImageView()
        configureSongName(songTitle: "")
        configureSongDuration(songTime: "")
        favIcon()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.cancelDownloading()
        songName.text = nil
        songDuration.text = nil
        
    }
    //MARK: Cell Setting
    private func configureCell() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    //MARK: Get Album Image
    func setCell(albumId: AlbumData) {
        posterImageView.downloadAlbumsImage(albumId: albumId)
    }
    //MARK: Poster Image Setting
    private func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
        }
    }
    //MARK: Get Somg Name
    func setAlbumName(albumData: AlbumData) {
        configureSongName(songTitle: albumData._songTitle)
    }
    //MARK: Song Name Setting
    private func configureSongName(songTitle: String) {
        songName = UILabel(frame: .zero)
        addSubview(songName)
        
        songName.translatesAutoresizingMaskIntoConstraints = false
        songName.clipsToBounds = true
        songName.text = songTitle
        songName.font = .systemFont(ofSize: 20)
        songName.numberOfLines = 0
        
        songName.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(posterImageView.snp.right).offset(30)
        }
    }
    //MARK: Get Song Duration
    func setSongDuration(songTime: AlbumData) {
        configureSongDuration(songTime: formatDuration(time: songTime._songDuration))
    }
    private func formatDuration(time: Int) -> String {
        var stringTime: String = ""
        if(time / 60 < 10) {
            stringTime = "0\(time / 60):"
        } else {
            stringTime = "\(time / 60):"
        }
        if(time % 60 < 10) {
            stringTime += "0\(time % 60)\""
        } else {
            stringTime += "\(time % 60)\""
        }
        return stringTime
    }
    //MARK: Song Duration Setting
    private func configureSongDuration(songTime: String) {
        songDuration = UILabel(frame:  .zero)
        addSubview(songDuration)
        
        songDuration.translatesAutoresizingMaskIntoConstraints = false
       // songDuration.text = "Deneme"
        songDuration.text = songTime
        songDuration.font = .boldSystemFont(ofSize: 15)
        songDuration.textColor = .gray
        
        songDuration.snp.makeConstraints { make in
            make.top.equalTo(songName.snp.bottom).offset(20)
            make.left.equalTo(posterImageView.snp.right).offset(30)
        }
    }
    
    //MARK: Favorite Icon
    func favIcon() {
        favoriteIcon = UIButton(frame: .zero)
        addSubview(favoriteIcon)
        
        favoriteIcon.addTarget(self, action: #selector(favTapButton), for: .touchUpInside)
        
        
        if let heartImage = UIImage(systemName: "heart") {
            let resizedHeartImage = heartImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
            favoriteIcon.setImage(resizedHeartImage, for: .normal)
        }
        
        favoriteIcon.sizeToFit()
        favoriteIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    @objc func favTapButton() {
        favoriteIcon.isSelected.toggle()
        print(favoriteIcon.isSelected)
        print("Favorite button")
    }
}
