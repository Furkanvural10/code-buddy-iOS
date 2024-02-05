#warning("Fixed hard coded")

import Foundation
import UIKit

struct SheetPresent {
    
    static let shared = SheetPresent()
    
    func sheetPresentView(vc: UIViewController, identifier: String, customHeight: CGFloat?, latitude: Double?, longitude: Double?) {
        
        if identifier == "addAnnotationIdentifier" {
            
            if let addAnnotationVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? AddAnnotationViewController {
                addAnnotationVC.latitude = latitude
                addAnnotationVC.longitude = longitude
                if let sheet = addAnnotationVC.sheetPresentationController{
                    sheet.detents = [.custom(resolver: { context in
                        customHeight
                    })]
                    
                    sheet.preferredCornerRadius = 15.0
                }
                vc.navigationController?.present(addAnnotationVC, animated: true)
            }
            
        } else if identifier == "showUsersID" {
            
            if let userTableVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? UsersViewController {
                if let sheet = userTableVC.sheetPresentationController{
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 15.0
                }
                vc.navigationController?.present(userTableVC, animated: true)
            }
        }
        
    }
}
