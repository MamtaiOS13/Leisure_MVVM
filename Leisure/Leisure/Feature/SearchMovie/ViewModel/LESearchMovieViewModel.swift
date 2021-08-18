//
//  LESearchMovieViewModel.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func didChangedSearchList()
}

protocol SearchViewModelProtocol {
    var results: [LEMovie] {get}
    var query: String {get set}
    var network: NetworkClientProtocol { get set }
    var delegate: SearchDelegate? {get set}
}

class LESearchMovieViewModel: SearchViewModelProtocol {
    var currentTask: URLSessionDataTask?
    weak var delegate: SearchDelegate?
    var network: NetworkClientProtocol = ServiceManager()
    var results = [LEMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangedSearchList()
            }
        }
    }
    var query: String = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
                if self.query == "" {
                    self.results = []
                } else {
                    self.getSearchedMovies()
                }
            })
        }
    }
    func getSearchedMovies() {
        currentTask?.cancel()
        currentTask = network.start(type: LESearchMovie.self,
                                    SearchMovieRequest(self.query)) { (result: Result<LESearchMovie, Error>) in
            self.manageUIHandling(result: result)
        }
    }
    func manageUIHandling(result: Result<LESearchMovie, Error>) {
        switch result {
        case .success(let movieResponse):
            self.results = movieResponse.results ?? [LEMovie]()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    func getUIModel(_ indexPath: IndexPath) -> LEMovie {
        let model = results[indexPath.row]
        return model
    }
    func getModel(_ action: ActionType, _ indexPath: IndexPath) -> LEMovie {
        let model = results[indexPath.row]
        if action == .fav {
            model.isfav = !model.isfav
        } else {
            model.isWatch = !model.isWatch
        }
        return model
    }
    func numberOfRowsInSection() -> Int {
        return results.count
    }
    func numberOfSection() -> Int {
        return 1
    }
    func makeFavOrWatchList(_ action: ActionType, _ indexPath: IndexPath) {
        let model = results[indexPath.row]
        guard let modelId = model.idValue else {
            return
        }
        var responseDict: [String: Any] = ["media_type": "movie", "media_id": modelId]
        if action == .fav {
            responseDict["favorite"] = model.isfav
        } else {
            responseDict["watchlist"] = model.isWatch
        }
        _ = network.start(type: LEFavModel.self,
                          SearchMovieRequest(action, responseDict)) { (result: Result<LEFavModel, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success, success == false {
                    // is api fail
                    if action == .fav {
                        model.isfav = !model.isfav
                    } else {
                        model.isWatch = !model.isWatch
                    }
                }
            case .failure(let error):
                // is api fail
                if action == .fav {
                    model.isfav = !model.isfav
                } else {
                    model.isWatch = !model.isWatch
                }
                print(error.localizedDescription)
            }
        }
    }
}
