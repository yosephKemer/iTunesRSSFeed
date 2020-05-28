//
//  iTunes_RSS_FeedTests.swift
//  iTunes_RSS FeedTests
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import XCTest
@testable import iTunes_RSS_Feed

class iTunes_RSS_FeedTests: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    let dashboardViewModel = MainViewModel()
    var expectation : XCTestExpectation?
    
    func testGetPhotos() {
        dashboardViewModel.delegate = self
        expectation = self.expectation(description: "Get RSS")
        dashboardViewModel.fetchRSS()
        self.waitForExpectations(timeout: 50, handler: nil)
        
    }
    
    func testResponseStatus() {

        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json")

        let promise = expectation(description: "Status code: 200")

        let dataTask = sut.dataTask(with: url!) { data, response, error in

            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }
    
    func testCallToiTunesCompletes() {
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
  
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
          
            promise.fulfill()
        }
        dataTask.resume()
       
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
}
extension iTunes_RSS_FeedTests: ITunesViewModelDelegate {
    func fetchRssCallBack(status: Bool, message: String) {
        if status {
            XCTAssertNotNil(self.dashboardViewModel.model)
            expectation?.fulfill()
        } else {
            XCTFail("Get RSS Failed")
        }
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    
    
}
