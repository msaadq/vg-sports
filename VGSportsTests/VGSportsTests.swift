//
//  VGSportsTests.swift
//  VGSportsTests
//
//  Created by Saad Qureshi on 03/10/2019.
//  Copyright © 2019 Canal Digital. All rights reserved.
//

import XCTest
@testable import VGSports

class VGSportsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScheduleVM() {
        let expectation = XCTestExpectation(description: "Load correct leagues schedule for today")
        
        let remoteDataPublisher = APIService.shared.getAPIResponseMapper(modelObject: [ LeagueListing].self, endpoint: .events, params: ["date": "today"])
            .sink(receiveCompletion: { completion in
                print(".sink() received the completion", String(describing: completion))
                switch completion {
                case .finished: expectation.fulfill()
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }, receiveValue: { listings in
                XCTAssertNotNil(listings)
                XCTAssert(!listings.isEmpty)
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEventDetails() {
        let eventId = 389093
        
        let expectation = XCTestExpectation(description: "Load correct event details for id: \(eventId)")
        
        let remoteDataPublisher = APIService.shared.getAPIResponseMapper(modelObject: EventWrapper.self, endpoint: .eventDetails(eventId: eventId))
            .sink(receiveCompletion: { completion in
                print(".sink() received the completion", String(describing: completion))
                switch completion {
                case .finished: expectation.fulfill()
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }, receiveValue: { eventMapper in
                XCTAssertNotNil(eventMapper.event)
                XCTAssert(eventMapper.event.id == eventId)
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLogoRetrieval() {
        let logoUrl = "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/50/502b4330-16ec-4b30-ab89-8cef350b1c06"
        
        let expectation = XCTestExpectation(description: "Download logo from \(String(describing: logoUrl))")
        
        let remoteDataPublisher = APIService.shared.getLogoImageFetcher(imageUrl: logoUrl, size: APIService.LogoSize.large)
            .sink { image in
                XCTAssert(image != UIImage(named: "FailedPlaceholder")!)
            }
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
}
