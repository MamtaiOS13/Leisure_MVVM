//
//  LEFavoriteViewModel.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

protocol LEFavoriteDelegate: AnyObject {
    func didChangedList()
    func hideLoader()
}
class LEFavoriteViewModel {
    var currentTask: URLSessionDataTask?
    weak var delegate: LEFavoriteDelegate?
    var network: NetworkClientProtocol = ServiceManager()
    var results = [LEMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangedList()
            }
        }
    }
    func getfavMovies() {
        currentTask?.cancel()
        currentTask = network.start(type: LESearchMovie.self,
                                    SearchMovieRequest(.fav)) { [weak self] (result: Result<LESearchMovie, Error>) in
            self?.manageUIHandling(result: result)
        }
    }
    func manageUIHandling(result: Result<LESearchMovie, Error>) {
        switch result {
        case .success(let movieResponse):
            self.results = movieResponse.results ?? [LEMovie]()
            self.delegate?.hideLoader()
        case .failure(let error):
            print(error.localizedDescription)
            self.delegate?.hideLoader()
        }
    }
    func getUIModel(_ indexPath: IndexPath) -> LEMovie {
        let model = results[indexPath.row]
        model.isfav = true
        return model
    }
    func numberOfRowsInSection() -> Int {
        return results.count
    }
    func numberOfSection() -> Int {
        return 1
    }
}
