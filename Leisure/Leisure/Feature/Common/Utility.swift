//
//  Utility.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation
import UIKit

enum AppStoryBoard: String {
    case main = "Main"
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        return scene
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    static func instantiateWithStoryboard(fromAppStoryboard appStoryboard: AppStoryBoard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

class Utility {
    class func goToMainScreen() {
        let scene = LETabBar.instantiateWithStoryboard(fromAppStoryboard: .main)
        let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        nav.viewControllers = [scene]
        UIApplication.shared.delegate?.window??.rootViewController = nav
    }
}
