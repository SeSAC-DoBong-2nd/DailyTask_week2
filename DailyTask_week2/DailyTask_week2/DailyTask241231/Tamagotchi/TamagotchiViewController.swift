//
//  TamagotchiViewController.swift
//  DailyTask_week2
//
//  Created by 박신영 on 12/31/24.
//

import UIKit

class TamagotchiViewController: UIViewController {

    var nickname = ""
    var riceCount = 0
    var waterCount = 0
    var level = 0
    
    @IBOutlet var underLineView: UIView!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var navRightButton: UIBarButtonItem!
    @IBOutlet var bubbleImageView: UIImageView!
    
    @IBOutlet var tamagotchiImageView: UIImageView!
    
    @IBOutlet var bubbleLabel: UILabel!
    
    @IBOutlet var tamagotchiButton: UIButton!
    
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var underLineView2: UIView!
    @IBOutlet var riceContainer: UIView!
    
    @IBOutlet var waterContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserdefaults()
        setBackgroundView()
        setNavUI()
        setTamagotchiUI()
        setBottomUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUserdefaults()
        bubbleLabel.text = setTamagotchiComment()
        navItem.title = "\(self.nickname)님의 다마고치"
    }
    
    func setUserdefaults() {
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        self.nickname = nickname.isEmpty ? "대장" :
        nickname
        
        let riceCount = UserDefaults.standard.integer(forKey: "riceCount")
        self.riceCount = riceCount
        
        let waterCount = UserDefaults.standard.integer(forKey: "waterCount")
        self.riceCount = waterCount
        
        let level = UserDefaults.standard.integer(forKey: "level")
        self.level = level
    }
    
    func setBackgroundView() {
        view.backgroundColor = .background241231
    }
    
    func setNavUI() {
        navItem.setRightBarButton(navRightButton, animated: true)
        navItem.title = "\(self.nickname)님의 다마고치"
        
        navRightButton.image = UIImage(systemName: "person.circle")
        navRightButton.tintColor = .lightGray
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .lightGray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setTamagotchiUI() {
        bubbleImageView.contentMode = .scaleAspectFill
        bubbleImageView.image = .bubble
        
        bubbleLabel.numberOfLines = 0
        bubbleLabel.text = setTamagotchiComment()
        bubbleLabel.textAlignment = .center
        
        tamagotchiImageView.contentMode = .scaleAspectFit
        tamagotchiImageView.image = ._2_1
        
        tamagotchiButton.setTitle("방실방실 다마고치", for: .normal)
        tamagotchiButton.isUserInteractionEnabled = false
        tamagotchiButton.setTitleColor(.primary241231, for: .normal)
        tamagotchiButton.layer.cornerRadius = 10
        tamagotchiButton.layer.borderWidth = 1
        tamagotchiButton.layer.borderColor = UIColor.primary241231.cgColor
        
        infoLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        infoLabel.textColor = .primary241231
        infoLabel.textAlignment = .center
        infoLabel.text = "LV\(level) • 밥알 \(riceCount)개 • 물방울 \(waterCount)개"
    }
    
    func setBottomUI() {
        [underLineView, underLineView2].forEach({ i in
            i?.layer.borderWidth = 1
            i?.layer.borderColor = UIColor.primary241231.cgColor
        })
        
        riceTextField.placeholder = "밥 주세용"
        waterTextField.placeholder = "물 주세용"
        [riceTextField, waterTextField].forEach {i in
            i?.borderStyle = .none
            i?.keyboardType = .numberPad
        }
        
        [riceButton, waterButton].forEach { i in
            i?.layer.borderWidth = 1
            i?.layer.borderColor = UIColor.primary241231.cgColor
            i?.layer.cornerRadius = 10
            i?.setTitleColor(.primary241231, for: .normal)
        }
        riceButton.setTitle("밥 먹기", for: .normal)
        waterButton.setTitle("물 먹기", for: .normal)
    }
    
    func setTamagotchiComment() -> String{
        let tamagotchiMessages: [String] = [
            "배고파요, \(self.nickname)님! 밥 주세요!",
            "오늘도 힘내봐요, \(self.nickname)님!",
            "\(self.nickname)님, 저랑 놀아주세요!",
            "저는 행복해요, \(self.nickname)님 덕분에!",
            "\(self.nickname)님, 제 기분은 최고예요!",
            "잘 자요, \(self.nickname)님! 내일 또 봐요.",
            "운동은 했나요, \(self.nickname)님? 저도 같이 할래요!",
            "\(self.nickname)님, 밥 먹었어요? 저도 먹고 싶어요!",
            "우와, \(self.nickname)님 최고예요! 저도 닮고 싶어요.",
            "\(self.nickname)님, 오늘도 저를 돌봐줘서 고마워요!"
        ]

        return tamagotchiMessages.randomElement() ?? ""
    }
    
    @IBAction
    func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction
    func ricewaterButtonTapped(_ sender: UIButton) {
        bubbleLabel.text = setTamagotchiComment()
    }
    
    @IBAction func unwindToPracticeViewController(_ sender: UIStoryboardSegue) {
        print(#function)
    }

}


/** 질문 모음
 1. navBar에 underLine이 필요하여 스토리보드에서 uiview로 추가한다고 가정하였을 때, 스토리보드 constraints로는 nav를 잡을 수 없던데 어떻게 해야할까?
 2. 스토리보드에 navBar에 shadowColor를 직접 주어도 적용되지 않아 let appearance = UINavigationBarAppearance() 코드를 활용하였는데, 스토리보드 상으로 설정한건 왜 적용되지 않았을까?
 */
