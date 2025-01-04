//
//  TravelTableViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/4/25.
//

import UIKit

import Kingfisher

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
        
        cell.travelImageView.kf.setImage(with: URL(string: image))
        cell.travelImageView.contentMode = .scaleAspectFill
        cell.travelImageView.layer.cornerRadius = 8
        
        cell.heartButton.setImage(UIImage(systemName: likeImage), for: .normal)
        cell.heartButton.tintColor = .red
        
        cell.titleLabel.text = titleText
        cell.titleLabel.font = .boldSystemFont(ofSize: 16)
        
        cell.subtitleLabel.text = subtitleText
        cell.subtitleLabel.numberOfLines = 2
        cell.subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        cell.subtitleLabel.textColor = .black.withAlphaComponent(0.8)
        
        let starCnt = calculatorStar(grade: grade)
        let reviewCnt = (1...100).randomElement() ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let saveCnt = numberFormatter.string(for: save) ?? "0"
        cell.etcLabel.text = "\(starCnt) (\(reviewCnt)) 저장 \(saveCnt)"
        cell.etcLabel.font = .systemFont(ofSize: 10, weight: .regular)
        cell.etcLabel.textColor = .black.withAlphaComponent(0.4)
        
        [cell.titleLabel, cell.subtitleLabel, cell.etcLabel].forEach {i in
            i?.textAlignment = .left
        }
        
    }
    
    func setAdCellUI(cell: AdTableViewCell) {
        let titleTextArr = ["하와이 여행을 가고 싶다면? 수업이 있는데 떠나실 생각은 아니시죠?", "도쿄 여행 예약은? Xcode로 직접 만드시면 되겠네요!"].randomElement() ?? "adTitleLabel error"
        cell.adTitleLabel.text = titleTextArr
        cell.adTitleLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        cell.adTitleLabel.textAlignment = .center
        cell.adTitleLabel.numberOfLines = 2
        
        let backgroundColor = [UIColor(resource: .adBackground1), UIColor(resource: .adBackground2)].randomElement() ?? .blue
        cell.adBackgroundView.backgroundColor = backgroundColor
        cell.adBackgroundView.layer.cornerRadius = 10
        cell.adBackgroundView.layer.borderWidth = 0
        
        cell.adButton.setTitle("AD", for: .normal)
        cell.adButton.titleLabel?.font = .systemFont(ofSize: 10)
        cell.adButton.setTitleColor(.black, for: .normal)
        cell.adButton.backgroundColor = .white
        cell.adButton.layer.cornerRadius = 8
        cell.adButton.layer.borderWidth = 0
        cell.adButton.isUserInteractionEnabled = false //인터렉션 잠금
    }
    
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
        
        //TravelCell 관련
        travelCell.heartButton.tag = indexPath.row
        travelCell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        let travelRow = travelList[indexPath.row]
        let image = travelRow.travel_image
        let titleText = travelRow.title
        let subtitleText = travelRow.description
        let grade = travelRow.grade // 평점
        let save = travelRow.save
        let likeImage = (travelRow.like ?? false) ? "heart.fill" : "heart"
        
        setTravelCellUI(cell: travelCell, image: image, titleText: titleText, subtitleText: subtitleText, grade: grade, likeImage: likeImage, save: save)
        
        //AdCell 관련
        setAdCellUI(cell: adCell)
        
        
        let isAd = travelRow.ad ? true : false
        
        switch isAd {
        case true:
            return adCell
        case false:
            return travelCell
        }
    }
    
}
