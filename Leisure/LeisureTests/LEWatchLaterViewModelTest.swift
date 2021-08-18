//
//  LEWatchLaterViewModelTest.swift
//  LeisureTests
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation
import XCTest
@testable import Leisure

class LEWatchLaterViewModelTest: BaseTestCase {
    lazy var viewModel = LEWatchLaterViewModel()
    override func setUp() {
        super.setUp()
        setUpData()
    }
    func setUpData() {
        getResponseModel(type: LESearchMovie.self, fileName: "Movies") { (result: Result<LESearchMovie, Error>) in
            self.viewModel.manageUIHandling(result: result)
        }
    }
    func testSetManageUIHandling() {
        XCTAssertTrue(self.viewModel.results.count > 0)
    }
    func testGetUIModel() {
        let index =  IndexPath(item: 1, section: 0)
        XCTAssertNotNil(viewModel.getUIModel(index))
    }
    func testNumberOfRowsInSection() {
        XCTAssertEqual(self.viewModel.numberOfRowsInSection(), 20)
    }
    func testNumberOfSection() {
        XCTAssertEqual(self.viewModel.numberOfSection(), 1)
    }
}
