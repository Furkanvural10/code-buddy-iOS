//
//  AddAnnotationViewModel.swift
//  Code Buddy
//
//  Created by furkan vural on 14.11.2023.
//

import Foundation
import UIKit

protocol AddAnnotationViewModelProtocol {
    func saveUserInfo()
    func updateUserInfo()
    func updateStatus(index: Int)
    var statusChangedClosure: ((UIColor) -> Void)? { get }
}

class AddAnnotationViewModel: AddAnnotationViewModelProtocol {
    
    var statusChangedClosure: ((UIColor) -> Void)?

    func saveUserInfo() {
        // Verileri db kaydet
    }
    
    func updateUserInfo() {
        // Kullanıcının konumunu vs güncelle
    }
    
    func updateStatus(index: Int) {
        var color: UIColor = .systemRed
        
        switch index {
        case 0:
            color = .systemGreen
        case 1:
            color = .systemYellow
        default:
            color = .systemRed
        }
        
        statusChangedClosure?(color)
    }
}
