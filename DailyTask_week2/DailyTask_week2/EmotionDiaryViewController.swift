//
//  EmotionDiaryViewController.swift
//  1st-Task_MovieProject
//
//  Created by 박신영 on 12/26/24.
//

import UIKit

class EmotionDiaryViewController: UIViewController {
    
    @IBOutlet var navLeftItem: UIBarButtonItem!
    
    @IBOutlet var happyBtn: UIButton!
    @IBOutlet var happyBtnLabel: UILabel!
    
    @IBOutlet var loveBtn: UIButton!
    @IBOutlet var loveBtnLabel: UILabel!
    
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var likeBtnLabel: UILabel!
    
    @IBOutlet var panicBtn: UIButton!
    @IBOutlet var panicBtnLabel: UILabel!
    
    @IBOutlet var upsetBtn: UIButton!
    @IBOutlet var upsetBtnLabel: UILabel!
    
    @IBOutlet var depresseBtn: UIButton!
    @IBOutlet var depresseBtnLabel: UILabel!
    
    @IBOutlet var boredBtn: UIButton!
    @IBOutlet var boredBtnLabel: UILabel!
    
    @IBOutlet var languidBtn: UIButton!
    @IBOutlet var languidBtnLabel: UILabel!
    
    @IBOutlet var sadBtn: UIButton!
    @IBOutlet var sadBtnLabel: UILabel!
    
    //    var btnClickCountArr = [0, 0, 0, 0, 0, 0, 0, 0, 0] :배열을 사용한 경우
    var btnClickCounts: [Int: Int] = [:] // :딕셔너리를 사용한 경우 (key = 버튼의 tag, value = 클릭 횟수)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
        navLeftItem.image = UIImage(systemName: "list.triangle")
        navLeftItem.tintColor = .lightGray
        
        setUI()
    }
    
    func setUI() {
        let btnArr = [happyBtn, loveBtn, likeBtn, panicBtn, upsetBtn, depresseBtn, boredBtn, languidBtn, sadBtn]
        
        let btnImageArr = [UIImage(resource: .monoSlime1), UIImage(resource: .monoSlime2), UIImage(resource: .monoSlime3), UIImage(resource: .monoSlime4), UIImage(resource: .monoSlime5), UIImage(resource: .monoSlime6), UIImage(resource: .monoSlime7), UIImage(resource: .monoSlime8), UIImage(resource: .monoSlime9)]
        
        let btnLabelArr = [happyBtnLabel, loveBtnLabel, likeBtnLabel, panicBtnLabel, upsetBtnLabel, depresseBtnLabel, boredBtnLabel, languidBtnLabel, sadBtnLabel]
        
        let btnLabelCommentArr = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "나른해", "슬퍼"]
        
        for index in 0..<btnImageArr.count {
            btnArr[index]?.tag = index
            btnArr[index]?.setImage(btnImageArr[index], for: .normal)
            btnLabelArr[index]?.text = "\(btnLabelCommentArr[index]) 0"
            btnLabelArr[index]?.textAlignment = .center
        }
    }
    
    @IBAction
    func emotionBtnTapped(_ sender: UIButton) {
        //        btnClickCountArr[sender.tag] += 1 // 배열을 사용
        btnClickCounts[sender.tag, default: 0] += 1
        
        let btnLabelCommentArr = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "나른해", "슬퍼"]
        let btnLabelArr = [happyBtnLabel, loveBtnLabel, likeBtnLabel, panicBtnLabel, upsetBtnLabel, depresseBtnLabel, boredBtnLabel, languidBtnLabel, sadBtnLabel]
        
        btnLabelArr[sender.tag]?.text = "\(btnLabelCommentArr[sender.tag]) \(btnClickCounts[sender.tag]!)"
    }
    
}
