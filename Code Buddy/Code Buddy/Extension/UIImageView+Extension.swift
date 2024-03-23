//
//  UIImageView+Extension.swift
//  Code Buddy
//
//  Created by furkan vural on 23.03.2024.
//

import Foundation
import UIKit

extension UIImageView {

   func setRounded() {
      let radius = CGRectGetWidth(self.frame) / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
