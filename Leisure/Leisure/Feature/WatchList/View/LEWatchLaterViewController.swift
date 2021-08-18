//
//  LEWatchLaterViewController.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import UIKit
import AVFoundation
import AVKit

class LEWatchLaterViewController: UIViewController, LEWatchLaterDelegate {
    let viewModel = LEWatchLaterViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let playerViewController = AVPlayerViewController()
    let kSearchCell = "SearchMovieCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: kSearchCell, bundle: nil)
        viewModel.delegate = self
        self.tableView?.register(nib, forCellReuseIdentifier: kSearchCell)
    }
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator?.startAnimating()
        viewModel.getWatchListMovies()
    }
    func didChangedList() {
        self.tableView?.reloadData()
    }
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
}
extension LEWatchLaterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kSearchCell,
                                                       for: indexPath) as? SearchMovieCell else {
            return UITableViewCell()
        }
        let model = viewModel.getUIModel(indexPath)
        cell.setUpCell(model, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
         return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LEWatchLaterViewController: SearchMovieCellDelegate {
    func btnActionCallApi(_ action: ActionType,
                          _ indexPath: IndexPath?) {
    }
    func playDummyTrailer() {
        guard let movieURL = URL(string: Services.dummyTrailer) else {
            return
        }
        let player = AVPlayer(url: movieURL as URL)
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }
}
