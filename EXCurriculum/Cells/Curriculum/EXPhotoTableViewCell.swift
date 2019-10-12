//
//  EXPhotoTableViewCell.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXPhotoTableViewCell: UITableViewCell {

    var url: URL? {
        didSet{
            photoImageView.load(url:url)
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
