//
//  ShoppingTableViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/3/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setShoppingHeaderCell
    (cell: ShoppingTableViewHeaderCell) {
        cell.contentView.backgroundColor = .background0103
        
        cell.shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        cell.shoppingTextField.borderStyle = .none
        
        cell.addButton.setTitle("추가", for: .normal)
        cell.addButton.backgroundColor = .addButton0103
        cell.addButton.layer.cornerRadius = 10
        cell.addButton.setTitleColor(.black, for: .normal)
    }
    
    func setShoppingMainCell(cell: ShoppingTableViewCell) {
        cell.contentView.backgroundColor = .background0103
        
        cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        cell.checkButton.tintColor = .black
        
        cell.shoppingLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cell.shoppingLabel.textAlignment = .left
        
        cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        cell.starButton.tintColor = .black
    }
    
    @objc
    func addButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
    }
    
    
    //MARK: - TableView 관련 함수
    
    //section 개수 설정
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //섹션 1과 섹션 2 사이 여백을 위해 footerHeight 설정
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    //cell 높이 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 50
        }
    }
    
    //cell 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return shoppingList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewHeaderCell") as! ShoppingTableViewHeaderCell
        setShoppingHeaderCell(cell: headerCell)
        headerCell.addButton.tag = indexPath[0]
        headerCell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let mainCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        setShoppingMainCell(cell: mainCell)
        
        switch indexPath.section {
        case 0:
            return headerCell
        case 1:
            mainCell.shoppingLabel.text = shoppingList[indexPath.row]
            return mainCell
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.shoppingList.remove(at: indexPath.row)
            print("delete 실행 완료")
            success(true)
        }
        delete.image = UIImage(systemName: "trash.fill")
        delete.image?.withTintColor(.white)
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(#function, indexPath.row)
//        
//        tableView.reloadData()
//    }
    
    //HeaderCell textField 액션 함수
    @IBAction
    func shoppingTextFieldEditingChanged(_ sender: UITextField) {
        print(#function)
    }
    
}
