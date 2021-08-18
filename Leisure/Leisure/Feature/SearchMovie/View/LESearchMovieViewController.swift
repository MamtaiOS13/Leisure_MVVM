//
//  LESearchMovieViewController.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import UIKit
import AVFoundation
import AVKit

class LESearchMovieViewController: UIViewController, SearchDelegate {
    let viewModel = LESearchMovieViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let playerViewController = AVPlayerViewController()

    let kSearchCell = "SearchMovieCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: kSearchCell, bundle: nil)
        viewModel.delegate = self
        self.tableView?.register(nib, forCellReuseIdentifier: kSearchCell)
    }
    func didChangedSearchList() {
        self.tableView?.reloadData()
    }
}

extension LESearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count == 0 {
            viewModel.query = ""
        }
        if searchText.count > 2 {
            viewModel.query = searchText
        }

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.query = searchBar.text ?? ""
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

extension LESearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
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

extension LESearchMovieViewController: SearchMovieCellDelegate {
    func btnActionCallApi(_ action: ActionType,
                          _ indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        if let cell = tableView?.cellForRow(at: indexPath) as? SearchMovieCell {
            let model = viewModel.getModel(action, indexPath)
            cell.setUpCell(model, indexPath: indexPath)
        }
        viewModel.makeFavOrWatchList(action, indexPath)
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
