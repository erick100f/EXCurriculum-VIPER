//
//  UIImage+Extensions.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

public extension UIImageView {

    func setCustomImage(_ imgURL: URL?) {
        guard let imgURL = imgURL else {
            self.image = UIImage(named: "noImage")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imgURL)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "noImage")
            }
        }
    }
}
