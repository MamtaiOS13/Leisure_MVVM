//
//  SearchMovieRequest.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

enum ActionType {
    case fav
    case watchList
}
class SearchMovieRequest: BaseService {
    public init(_ searchquery: String) {
        super.init()
        self.requestURL = Services.baseUrl + Services.searchMovie
        self.requestQueryParam += "&language=en-US&query=" + searchquery + "&page=1"
        self.requestType = .GET
    }
    public  init(_ actionType: ActionType, _ requestBody: [String: Any]) {
        super.init()
        let lastUrl = actionType == .fav ? Services.makeFav : Services.makeWatch
        self.requestURL = Services.baseUrl + lastUrl
        self.requestQueryParam += "&session_id=\(ValidSessionUser.shared.sessionID)"
        self.requestType = .POST
        self.requestParams = requestBody
    }
    public init(_ actionType: ActionType) {
        super.init()
        let lastUrl = actionType == .fav ? Services.getFav : Services.getWatch
        self.requestURL = Services.baseUrl + lastUrl
        self.requestQueryParam += "&session_id=\(ValidSessionUser.shared.sessionID)" + "&page=1"
        self.requestType = .GET
    }

}
