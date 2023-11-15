//
//  SheetPresent.swift
//  Code Buddy
//
//  Created by furkan vural on 12.11.2023.
//

import Foundation
import UIKit

struct SheetPresent {
    
    static let shared = SheetPresent()
    
    func sheetPresentView(vc: UIViewController, identifier: String, customHeight: CGFloat?) {
        
        if identifier == "addAnnotationIdentifier" {
            
            if let addAnnotationVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? AddAnnotationViewController {
                if let sheet = addAnnotationVC.sheetPresentationController{
                    sheet.detents = [.custom(resolver: { context in
                        customHeight
                        
                    })]

                    sheet.preferredCornerRadius = 15.0
                }
                vc.navigationController?.present(addAnnotationVC, animated: true)
            }
            
        } else if identifier == "showUserTableViewID" {
            
            if let userTableVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? UserTableViewController {
                if let sheet = userTableVC.sheetPresentationController{
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 15.0
                }
                vc.navigationController?.present(userTableVC, animated: true)
            }
            
        } else {
            if let showPlacesVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? PlacesTableViewController {
                if let sheet = showPlacesVC.sheetPresentationController{
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 15.0
                }
                vc.navigationController?.present(showPlacesVC, animated: true)
            }
        }
        
        
    }
}
