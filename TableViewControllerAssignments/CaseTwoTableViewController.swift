//
//  CaseTwoTableViewController.swift
//  TableViewControllerAssignments
//
//  Created by Heedon on 2023/07/27.
//

import UIKit

class CaseTwoTableViewController: UITableViewController {

    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.getSectionCount()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        //단순 String literal, section 구분
//        switch section {
//        case 0: return "전체 설정"
//        case 1: return "개인 설정"
//        case 2: return "기타"
//        default: return "nothing"
//        }
        
        let setting = SectionHeader(rawValue: section)
        return setting?.sectionName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        switch SectionHeader(rawValue: section) {
//        case .wholeSetting:
//            return dataManager.getWholeSetting().count
//        case .personalSetting:
//            return dataManager.getPersonalSetting().count
//        case .remainSetting:
//            return dataManager.getRemainSetting().count
//        default:
//            return 0
//        }

        //enum으로 dataManager 내 Section별 데이터 얻는 함수 하나로 만들기
//        return dataManager.getData(type: SectionDataType ).count
        
        return dataManager.getFromStart(type: SectionHeader(rawValue: section)!).count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "caseTwoCell")!
        
        //1. SectionHeader(rawValue: indexPath.section)으로 해당 section의 case 파악
        //3. SectionDataType의 해당 data case으로 data 얻기
        
        //2. SectionHeader의 case로 SectionDataType의 case 알아야 함

//        cell.textLabel?.text = dataManager.getData(type: )[indexPath.row]

        //아예 SectionHeader에서 바로 data 얻기
        if let sectionHeaderType = SectionHeader(rawValue: indexPath.section) {
            cell.textLabel?.text = dataManager.getFromStart(type: sectionHeaderType)[indexPath.row]
        }
                
//        switch SectionHeader(rawValue: indexPath.section) {
//        case .wholeSetting:
//            cell.textLabel?.text =  dataManager.getWholeSetting()[indexPath.row]
//        case .personalSetting:
//            cell.textLabel?.text = dataManager.getPersonalSetting()[indexPath.row]
//        case .remainSetting:
//            cell.textLabel?.text = dataManager.getRemainSetting()[indexPath.row]
//        default:
//            break
//        }
        
        return cell
    }
    
    

   
}
