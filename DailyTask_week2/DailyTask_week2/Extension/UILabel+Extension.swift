//
//  UILabel+Extension.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/3/25.
//

import UIKit

extension UILabel {
    
    //self를 사용하는 것은 extension으로 확장하는 UILabel 스스로의 label을 뜻함
    func setPrimaryLabel(_ text: String) {
        self.text = text
        self.font = .systemFont(ofSize: 14, weight: .medium)
        self.textColor = .black
        self.textAlignment = .left
    }
    
}

