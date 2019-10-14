//
//  EXExpandableTableViewCell.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/12/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXExpandableTableViewCell: UITableViewCell {
    
    enum MoreOrLess: String {
        case plus = "+"
        case less = "-"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    
    var skill: EXSkill? {
        didSet{
            setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setIdentifiel( .plus)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIdentifiel(_ txt : MoreOrLess){
        plusLabel.text = txt.rawValue
    }
    
    func setup(){
        if let s = skill {
            titleLabel.text = s.title
            descriptionLabel.text = s.tools.joined(separator: "\n")
        }
    }
    
}
