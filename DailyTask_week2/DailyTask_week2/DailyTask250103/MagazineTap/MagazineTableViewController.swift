//
//  MagazineTableViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/4/25.
//

import UIKit

import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    var magazineList = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cell 높이 설정
        tableView.rowHeight = 470
    }
    
    func setMagazineCellUI(cell: MagazineTableViewCell, image: String, title: String, subtitle: String, date: String) {
        cell.posterImageView.kf.setImage(with: URL(string: image))
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 20
        
        cell.titleLabel.text = title
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.numberOfLines = 2
        
        cell.subtitleLabel.text = subtitle
        cell.subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        cell.subtitleLabel.textColor = .black.withAlphaComponent(0.4)
        cell.subtitleLabel.textAlignment = .left
        
        cell.dateLabel.text = convertMagazineDate(date: date)
        cell.dateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        cell.dateLabel.textColor = .black.withAlphaComponent(0.4)
        cell.dateLabel.textAlignment = .right
    }
    
    //[yyMMdd] -> [yy년 MM월 dd일] 형식 변환
    func convertMagazineDate(date: String) -> String {
        //yyMMdd 형식 DateFormatter 변수 inputDate 생성
        let inputDate = DateFormatter()
        inputDate.dateFormat = "yyMMdd"
        
        //inputDate를 Date 타입으로 변환하여 date에 대입
        guard let date = inputDate.date(from: date) else {
            print("convertMagazineDate 속 date 변환 실패")
            return ""
        }
        
        //yyMMdd 형식 DateFormatter 변수 outputDate 생성
        //위에서 Date 타입으로 바꾼 date, outputDate string에 대입하여 반환
        let outputDate = DateFormatter()
        outputDate.dateFormat = "yy년 MM월 dd일"
        return outputDate.string(from: date)
    }
    
    
    // MARK: - TableView 관련
    
    //cell 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let magazineCell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell") as! MagazineTableViewCell
        let magazineRow = magazineList[indexPath.row]
        
        let posterImage = magazineRow.photo_image
        let title = magazineRow.title
        let subtitle = magazineRow.subtitle
        let date = magazineRow.date
        
        setMagazineCellUI(cell: magazineCell, image: posterImage, title: title, subtitle: subtitle, date: date)
        
        return magazineCell
    }
    
}
