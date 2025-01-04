//
//  ShoppingTableViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/3/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppingList: [ShoppingToDoModel] = shoppingToDoDummy {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentTextFieldText: String = ""
    
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
    
    func setShoppingMainCell(cell: ShoppingTableViewCell, checkImage: String, starImage: String) {
        cell.contentView.backgroundColor = .background0103
        
        cell.checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        cell.checkButton.tintColor = .black
        
        cell.shoppingLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cell.shoppingLabel.textAlignment = .left
        
        cell.starButton.setImage(UIImage(systemName: starImage), for: .normal)
        cell.starButton.tintColor = .black
    }
    
    @objc
    func addButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        shoppingList.append(ShoppingToDoModel(isChecked: false, shoppingToDo: currentTextFieldText, isStared: false))
    }
    
    @objc
    func checkButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        shoppingList[sender.tag].isChecked.toggle()
    }
    
    @objc
    func starButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        shoppingList[sender.tag].isStared.toggle()
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
        let checkStateImage = shoppingList[indexPath.row].isChecked ? "checkmark.square.fill" :
        "checkmark.square"
        let starStateImage = shoppingList[indexPath.row].isStared ? "star.fill" :
        "star"
        setShoppingMainCell(cell: mainCell, checkImage: checkStateImage, starImage: starStateImage)
        
        
        mainCell.checkButton.setImage(UIImage(systemName: checkStateImage), for: .normal)
        
        
        switch indexPath.section {
        case 0:
            return headerCell
        case 1:
            mainCell.shoppingLabel.text = shoppingList[indexPath.row].shoppingToDo
            mainCell.checkButton.tag = indexPath.row
            mainCell.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
            
            mainCell.starButton.tag = indexPath.row
            mainCell.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
            
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
    
    //HeaderCell textField 액션 함수
    @IBAction
    func shoppingTextFieldEditingChanged(_ sender: UITextField) {
        print(#function)
        self.currentTextFieldText = sender.text ?? "허걱"
    }
    
}
