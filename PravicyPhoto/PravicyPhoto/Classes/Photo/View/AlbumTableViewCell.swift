//
//  AlbumTableViewCell.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2018/1/6.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit

let kAlbumTableViewCell = "kAlbumTableViewCell"

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var album: Album? {
        didSet {
            coverImageView.image = UIImage(named: "album_thumb_placeholder")
            nameLabel.text = album?.name
            countLabel.text = "\(album?.photos?.count ?? 0) 张照片"
        }
    }
    
}
