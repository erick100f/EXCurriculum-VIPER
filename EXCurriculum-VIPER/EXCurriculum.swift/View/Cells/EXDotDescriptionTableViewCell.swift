//
//  EXDotDescriptionTableViewCell.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXDotDescriptionTableViewCell: UITableViewCell {

    var skill: EXSkill? {
        didSet{
            setup()
        }
    }
    
    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var descripitionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(){
        if let s = skill {
            txtLabel.text = s.title
            descripitionLabel.text = s.tools.joined(separator: "\n")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
