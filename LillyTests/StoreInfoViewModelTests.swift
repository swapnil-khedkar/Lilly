//
//  DataServiceTests.swift
//  LillyTests
//
//  Created by swapnil khedkar on 5/19/22.
//

import XCTest
@testable import Lilly

class StoreInfoViewModelTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

  func testFetchStoreInfoSuccess() {

    let fetchInfoExpectation = expectation(description: "Fetch store info expectation")

    let handler = DataServiceFakeImpl()

    let expectedStoreInfo = StoreInfo(name: "TestStore")

    handler.fetchStoreInfoHandler = { completion in
      completion(.success(StoreInfoResponse(storeInfo: expectedStoreInfo)))
      fetchInfoExpectation.fulfill()
    }

    let storeViewModel = StoreViewModel(dataHandler: handler)
    storeViewModel.fetchStoreInfo()

    wait(for: [fetchInfoExpectation], timeout: 0.5)

    // Validate store info
    let storeInfo = storeViewModel.storeInfo

    XCTAssertEqual(storeInfo.name, expectedStoreInfo.name, "Wrong store info fetched")

  }

}
