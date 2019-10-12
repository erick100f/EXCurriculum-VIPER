//
//  EXAppTableViewCell.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXAppTableViewCell: UITableViewCell {

    var app: EXApp? {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        if let app = app {
            nameLabel.text = app.name
            appImageView.load(url: app.imageURL)
            appImageView.contentMode = .scaleAspectFill
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
