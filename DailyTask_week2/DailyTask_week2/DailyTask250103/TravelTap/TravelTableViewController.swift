//
//  TravelTableViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/4/25.
//

import UIKit

import Kingfisher
import SnapKit

class TravelTableViewController: UITableViewController {
    
    var travelList = TravelInfo().travel {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTravelCellUI(cell: TravelTableViewCell, image: String?, titleText: String?, subtitleText: String?, grade: Double?, likeImage: String, save: Int?) {
        guard let image,
              let titleText,
              let subtitleText,
              let grade,
              let save else {
            print("setTravelCellUI() guard let Error")
            return
        }
        
        cell.travelImageView.setImageViewUIWithKF(imageURL: image, cornerRadius: 8)
        cell.travelImageView.backgroundColor = .black
        
        cell.heartButton.setButtonUIWithImage(image: likeImage, tintColor: .red)
        
        cell.titleLabel.setLabelUI(titleText, font: .boldSystemFont(ofSize: 16))
        
        cell.subtitleLabel.setLabelUI(subtitleText,
                                      font: .systemFont(ofSize: 13, weight: .regular),
                                      textColor: .black.withAlphaComponent(0.8),
                                      numberOfLines: 2)
        
//        cell.heartButton.backgroundColor = .white
//        cell.heartButton.imageView?.backgroundColor = .white
//        cell.heartButton.layer.backgroundColor = UIColor.white.cgColor
        
        
        let starCnt = calculatorStar(grade: grade)
        let reviewCnt = (1...100).randomElement() ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let saveCnt = numberFormatter.string(for: save) ?? "0"
        cell.etcLabel.setLabelUI("\(starCnt) (\(reviewCnt)) 저장 \(saveCnt)",
                                 font: .systemFont(ofSize: 10, weight: .regular),
                                 textColor: .black.withAlphaComponent(0.4))
    }
    
    func setAdCellUI(cell: AdTableViewCell) {
        let randomTitleText = ["하와이 여행을 가고 싶다면? 수업이 있는데 떠나실 생각은 아니시죠?", "도쿄 여행 예약은? Xcode로 직접 만드시면 되겠네요!"].randomElement() ?? "adTitleLabel error"
        cell.adTitleLabel.setLabelUI(randomTitleText,
                                     font: .systemFont(ofSize: 14, weight: .heavy),
                                     alignment: .center,
                                     numberOfLines: 2)
        
        let backgroundColor = [UIColor(resource: .adBackground1), UIColor(resource: .adBackground2)].randomElement() ?? .blue
        cell.adBackgroundView.backgroundColor = backgroundColor
        cell.adBackgroundView.layer.cornerRadius = 10
        cell.adBackgroundView.layer.borderWidth = 0
        
        cell.adButton.setButtonUIWithTitle(title: "AD", backgroundColor: .white, cornerRadius: 8)
        cell.adButton.titleLabel?.font = .systemFont(ofSize: 10)
        cell.adButton.isUserInteractionEnabled = false //인터렉션 잠금
    }
    
    //평점 기준 별 개수 반환 함수
    func calculatorStar(grade: Double) -> String {
        let num = round(grade) //소수점 반올림
        switch num {
        case 1:
            return "⭐️"
        case 2:
            return "⭐️⭐️"
        case 3:
            return "⭐️⭐️⭐️"
        case 4:
            return "⭐️⭐️⭐️⭐️"
        case 5:
            return "⭐️⭐️⭐️⭐️⭐️"
        default:
            return "실패"
        }
    }
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        travelList[sender.tag].like?.toggle()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isAd = travelList[indexPath.row].ad
        if isAd {
            return 110
        } else {
            return 140
        }
    }
    
    
    // MARK: - TableView 연관
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travelCell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell") as! TravelTableViewCell
        let adCell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell") as! AdTableViewCell
        let travelRow = travelList[indexPath.row]
        
        let isAd = travelRow.ad ? true : false
        let noSeparatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        switch isAd {
        case true:
            //adCell UI 함수
            setAdCellUI(cell: adCell)
            
            //adCell일 경우 cell 하단 separator 표시 x
            adCell.separatorInset = noSeparatorInset
            return adCell
        case false:
            travelCell.heartButton.tag = indexPath.row
            travelCell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
            
            let image = travelRow.travel_image
            let titleText = travelRow.title
            let subtitleText = travelRow.description
            let grade = travelRow.grade // 평점
            let save = travelRow.save
            let likeImage = (travelRow.like ?? false) ? "heart.fill" : "heart"
            
            //travelCell UI 함수
            setTravelCellUI(cell: travelCell, image: image, titleText: titleText, subtitleText: subtitleText, grade: grade, likeImage: likeImage, save: save)
            
            //현재 indexPath.row가 travelList index의 마지막 원소가 아니고,
            //현재 indexPath.row 이후 나올 cell이 adCell일 경우 cell 하단 separator 표시 x
            if indexPath.row != (travelList.count-1) && travelList[indexPath.row + 1].ad == true {
                travelCell.separatorInset = noSeparatorInset
            }
            return travelCell
        }
    }
    
}
