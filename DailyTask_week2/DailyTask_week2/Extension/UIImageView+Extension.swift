//
//  UIImageView+Extension.swift
//  DailyTask_week2
//
//  Created by 박신영 on 1/5/25.
//

import UIKit

import Kingfisher

extension UIImageView {
    
    func setImageViewUIWithKF(imageURL: String, cornerRadius: Int) {
        self.kf.setImage(with: URL(string: imageURL))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
}
