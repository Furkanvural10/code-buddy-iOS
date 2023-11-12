//
//  SheetPresent.swift
//  Code Buddy
//
//  Created by furkan vural on 12.11.2023.
//

import Foundation
import UIKit

struct SheetPresent {
    
    static func sheetPresentView(vc: UIViewController, identifier: String) {
    
        
        if let addAnnotationVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? AddAnnotationViewController {
            if let sheet = addAnnotationVC.sheetPresentationController{
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 15.0
            }
            
            
            
            vc.navigationController?.present(addAnnotationVC, animated: true)
        }
    }
}
