//
//  LELoginViewController.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import UIKit

class LELoginViewController: UIViewController, LELoginViewModelDelegate {
    let viewModel = LELoginViewModel()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        self.activityIndicator?.isHidden = true
        super.viewDidLoad()
    }

    @IBAction func getValidSessionIdAction(_ sender: Any) {
        self.activityIndicator?.isHidden = false
        self.activityIndicator?.startAnimating()
        viewModel.getValidSessionId()
    }
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
}
