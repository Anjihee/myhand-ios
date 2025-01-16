//
//  ExpCell.swift
//  Ddabong2
//
//  Created by 이윤주 on 1/15/25.
//

import UIKit
class ExpCell:UITableViewCell{
    
    @IBOutlet weak var lblExp: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgCircle: UIImageView!
    @IBOutlet weak var lblBg: UILabel!
    
    func configure(with quest: Exp) {
        print("난 셀이야", quest)
        lblBg.layer.cornerRadius = 10
        lblBg.layer.masksToBounds = true
        
        var title:String = ""
        if quest.questType == "hr" {
            title = "인사평가"
        }else if quest.questType == "job"{
            title = "직무별 퀘스트"
        }else if quest.questType == "leader" {
            title = "리더부여 퀘스트"
        }else{
            title = "전사 프로젝트"
        }
        
        
        if quest.grade == "MAX" {
            lblBg.backgroundColor = UIColor(hex: "fff4f4")
            imgCircle.image = UIImage(named: "imgFullRedSmall")
        } else if quest.grade == "MED" {
            lblBg.backgroundColor = UIColor(hex: "fffceb")
            imgCircle.image = UIImage(named: "imgFullYellowSmall")
        }
        else{
            lblBg.backgroundColor = UIColor(hex: "e9f9ff")
            imgCircle.image = UIImage(named: "imgFullBlueSmall")
        }
        
        
        lblExp.text = "\(quest.expAmount)D"
        lblTime.text = "\(quest.completedAt)"
        lblContent.text = quest.name
        lblTitle.text = title
    }
}
