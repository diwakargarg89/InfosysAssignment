//
//  InfosysAssignmentTests.swift
//  InfosysAssignmentTests
//
//  Created by Diwakar Garg on 09/12/2019.
//  Copyright © 2019 Diwakar Garg. All rights reserved.
//

import XCTest
@testable import InfosysAssignment

class InfosysAssignmentTests: XCTestCase {

    var tableViewController = TableViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdateUserInterface() {
        //Check the network connection method
        XCTAssertNotNil(tableViewController.updateUserInterface())
        // Status manager method
        XCTAssertNotNil(tableViewController.statusManager())
    }
    func testViewDidLoad() {
        //test view did load
        XCTAssertNotNil(tableViewController.viewDidLoad())
        XCTAssertNotNil(tableViewController.setupTableView())
        XCTAssertNotNil(tableViewController.pullToRefresh(sender: self))
        XCTAssertNotNil(tableViewController.apiCallingUsingNativeMethods())
        XCTAssertNotNil(tableViewController.numberOfSections(in: tableViewController.customTableView))
    }
    func testViewWillAppear() {
        //test view will appear
        XCTAssertNotNil(tableViewController.viewWillAppear(true))
    }

    //Unit test case reachability
    func testRreachabilityMethods() {
             // testcase for network variable
             XCTAssertFalse((Network.reachability?.isDirect)!)
             XCTAssertFalse((Network.reachability?.isLocalAddress)!)
             XCTAssertFalse((Network.reachability?.interventionRequired)!)
             XCTAssertFalse((Network.reachability?.connectionOnDemand)!)
             XCTAssertFalse((Network.reachability?.connectionRequired)!)
             XCTAssertFalse((Network.reachability?.connectionOnTraffic)!)
             XCTAssertFalse((Network.reachability?.transientConnection)!)
             XCTAssertTrue((Network.reachability?.isConnectedToNetwork)!)
             XCTAssertFalse((Network.reachability?.isRequiredAndTransientConnection)!)
             XCTAssertTrue((Network.reachability?.isReachable)!)
             XCTAssertTrue((Network.reachability?.isRunning)!)
        }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
