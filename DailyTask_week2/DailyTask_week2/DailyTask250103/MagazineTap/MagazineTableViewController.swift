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
        
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let dateStr = format.date(from: date)
        print("🔥 \(dateStr ?? Date())")
        cell.dateLabel.text = "아직"
        cell.dateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        cell.dateLabel.textColor = .black.withAlphaComponent(0.4)
        cell.dateLabel.textAlignment = .right
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
