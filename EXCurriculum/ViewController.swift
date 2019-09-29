//
//  ViewController.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = EXConstants.cvTitle
    }

    @IBAction func startPress(_ sender: Any) {
        let vc = EXCurriculumViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

