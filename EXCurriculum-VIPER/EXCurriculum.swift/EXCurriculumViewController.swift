//
//  EXCurriculumViewController.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

class EXCurriculumViewController: UIViewController {

    enum EXCurriculumRoll{
        case photo(url: URL?)
        case header(cv: EXCurriculum)
        case title(txt: String)
        case description (txt: String)
        case dot(txt: String)
        case dotDescription(skill: EXSkill)
        case job(job: EXJob)
        case jobAchievement(text: String)
        case app(app: EXApp)
        case loading
        case separator
    }
    
    var presentor:ViewToPresenterProtocol?
    
    var curriculum:EXCurriculum?
    var rolls: [EXCurriculumRoll] = [.loading]{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var indexPathExpander: IndexPath? = nil{
        didSet{
            if let oldValue = oldValue {
                let cell = tableView.cellForRow(at: oldValue) as? EXExpandableTableViewCell
                cell?.plusLabel.text = "+"
            }
        }
    }
            
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = EXConstants.cvTitle
        presentor?.startFetchingCv()
        setup()
    }
    
    func setup(){
//        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        setupCells()
    }

    func setupCells(){
        tableView.register(cellType: EXPhotoTableViewCell.self)
        tableView.register(cellType: EXHeaderTableViewCell.self)
        tableView.register(cellType: EXTitleTableViewCell.self)
        tableView.register(cellType: EXDescriptionTableViewCell.self)
        tableView.register(cellType: EXDotTableViewCell.self)
        tableView.register(cellType: EXExpandableTableViewCell.self)
        tableView.register(cellType: EXExperticeTableViewCell.self)
        tableView.register(cellType: EXEXperticeDotTableViewCell.self)
        tableView.register(cellType: EXAppTableViewCell.self)
        tableView.register(cellType: EXSeparatorTableViewCell.self)
        
        
    }

}

extension EXCurriculumViewController:PresenterToViewProtocol{
    func showCv(cv: EXCurriculum) {
        self.curriculum = cv
        var rolls: [EXCurriculumRoll] = []
        
         if let cv = self.curriculum {
            rolls.append(.photo(url: cv.photoURL))
            rolls.append(.header(cv: cv))
             if let technical = cv.technical {
                rolls.append(.title(txt: technical.title))
                 for item in technical.items {
                    
                     rolls.append(.dot(txt: item.title))
                     for skill in item.skills {
                         rolls.append(.dotDescription(skill:skill))
                     }
                 }
             }
             if let ps = cv.professionalSummary {
                 rolls.append(.title(txt: ps.title))
                 for job in ps.jobs {
                     rolls.append(.job(job: job))
                     for ar in job.achievement {
                         rolls.append(.jobAchievement(text: ar))
                     }
                 }
             }
             if let publications = cv.publications {
                 rolls.append(.title(txt: publications.title))
                 for app in publications.apps {
                     rolls.append(.app(app: app))
                 }
             }
         }
        self.rolls = rolls
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EXCurriculumViewController: UITableViewDelegate,UITableViewDataSource  {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rollRow = rolls[indexPath.row]
        
        switch rollRow {
        case .dotDescription:
            if let indexPathExpander = self.indexPathExpander {
                if indexPath == indexPathExpander{
                    return UITableView.automaticDimension
               }
            }
            return 44
        default:
            return  UITableView.automaticDimension
        }
//        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rolls.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       didPress(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rollRow = rolls[indexPath.row]
        
        switch rollRow {
        case .photo(let url):
            let cell = tableView.dequeueReusableCell(with: EXPhotoTableViewCell.self, for: indexPath)
            cell.url = url
            return cell
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
            let cell = tableView.dequeueReusableCell(with: EXExpandableTableViewCell.self, for: indexPath)
            cell.skill = skill
            if let indexPathExpander = self.indexPathExpander, indexPath.row == indexPathExpander.row{
//                cell.plusLabel.text = "-"
            }else {
                cell.plusLabel.text = "+"
            }
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
        case .separator:
            return tableView.dequeueReusableCell(with: EXSeparatorTableViewCell.self, for: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func didPress(indexPath: IndexPath) {
        
        if let indexPathExpander = self.indexPathExpander, indexPath.row == indexPathExpander.row{
            self.indexPathExpander = nil
            let cell = tableView.cellForRow(at: indexPath) as? EXExpandableTableViewCell
            cell?.plusLabel.text = "+"
        }else {
            self.indexPathExpander = indexPath
            let cell = tableView.cellForRow(at: indexPath) as? EXExpandableTableViewCell
            cell?.plusLabel.text = "-"
        }
        
        UIView.animate(withDuration: 0.1) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
}


