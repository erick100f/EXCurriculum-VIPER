//
//  EXCurriculumViewController.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXCurriculumViewController: UIViewController {

    enum Bridge{
        case header(cv: EXCurriculum)
        case title(txt: String)
        case description (txt: String)
        case dot(txt: String)
        case dotDescription(skill: EXSkill)
        case job(job: EXJob)
        case jobAchievement(text: String)
        case app(app: EXApp)
        case loading
    }
    
    var curriculum: EXCurriculum?
    
    var bridge: [Bridge] = [.loading]{
        didSet{
            tableView.reloadData()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            setupCells()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = EXConstants.cvTitle
        setup()
        getJSON()
    }
    
    func setup(){
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
    }

    func setupCells(){
        tableView.register(cellType: EXHeaderTableViewCell.self)
        tableView.register(cellType: EXTitleTableViewCell.self)
        tableView.register(cellType: EXDescriptionTableViewCell.self)
        tableView.register(cellType: EXDotTableViewCell.self)
        tableView.register(cellType: EXDotDescriptionTableViewCell.self)
        tableView.register(cellType: EXExperticeTableViewCell.self)
        tableView.register(cellType: EXEXperticeDotTableViewCell.self)
        tableView.register(cellType: EXAppTableViewCell.self)
    }
    
    func getJSON() {
        guard let url = URL(string: EXConstants.jsonURL) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {[weak self] (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
               do {
                  let cv = try JSONDecoder().decode(EXCurriculum.self, from: data)
                  print(cv.name)
                self?.curriculum = cv
                self?.makeBridge()
               } catch let error {
                  print(error)
               }
            }
        }.resume()
    }
    
    func makeBridge(){
        DispatchQueue.main.async { // Correct
            var bridge: [Bridge] = []
           
            if let cv = self.curriculum {
               bridge.append(.header(cv: cv))
                if let technical = cv.technical {
                    bridge.append(.title(txt: technical.title))
                    for item in technical.items {
                        bridge.append(.dot(txt: item.title))
                        for skill in item.skills {
                            bridge.append(.dotDescription(skill:skill))
                        }
                    }
                }
                if let ps = cv.professionalSummary {
                    bridge.append(.title(txt: ps.title))
                    for job in ps.jobs {
                        bridge.append(.job(job: job))
                        for ar in job.achievement {
                            bridge.append(.jobAchievement(text: ar))
                        }
                    }
                }
                if let publications = cv.publications {
                    bridge.append(.title(txt: publications.title))
                    for app in publications.apps {
                        bridge.append(.app(app: app))
                    }
                }
            }
           self.bridge = bridge
        }
        
    }


}


extension EXCurriculumViewController: UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bridge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bridgeRow = bridge[indexPath.row]
        
        switch bridgeRow {
        case .header(let cv):
            let cell = tableView.dequeueReusableCell(with: EXHeaderTableViewCell.self, for: indexPath)
            cell.curriculum = cv
            return cell
        case .title(let txt):
            let cell = tableView.dequeueReusableCell(with: EXTitleTableViewCell.self, for: indexPath)
            cell.title = txt
            return cell
        case .dot(let txt):
            let cell = tableView.dequeueReusableCell(with: EXDotTableViewCell.self, for: indexPath)
            cell.label.text = txt
            return cell
        case .dotDescription(let skill):
            let cell = tableView.dequeueReusableCell(with: EXDotDescriptionTableViewCell.self, for: indexPath)
            cell.skill = skill
            return cell
        case .job(let job):
            let cell = tableView.dequeueReusableCell(with: EXExperticeTableViewCell.self, for: indexPath)
            cell.job = job
            return cell
        case .jobAchievement(let text):
            let cell = tableView.dequeueReusableCell(with: EXEXperticeDotTableViewCell.self, for: indexPath)
            cell.label.text = text
            return cell
        case .app(let app):
            let cell = tableView.dequeueReusableCell(with: EXAppTableViewCell.self, for: indexPath)
            cell.app = app
            return cell
        case .loading:
            return EXLoadingTableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}
