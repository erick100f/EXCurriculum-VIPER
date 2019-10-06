//
//  EXHeaderTableViewCell.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXHeaderTableViewCell: UITableViewCell {

    var curriculum: EXCurriculum? {
        didSet{
            setup()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        if let cv = curriculum {
            nameLabel.text = cv.name
            tituloLabel.text = cv.titulo
            birthdayLabel.text = cv .birthday
            languagesLabel.text = cv.topLanguages.joined(separator: " /")
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
