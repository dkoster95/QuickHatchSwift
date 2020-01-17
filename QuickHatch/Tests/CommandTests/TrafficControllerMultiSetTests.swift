//
//  TrafficControllerMultiSetTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 1/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
@testable import QuickHatch

class TrafficControllerMultiSetTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testIsCommandRunning() {
        let command = Command<DataModel>()
        let trafficController = TrafficControllerMultiSet()
        XCTAssert(!trafficController.isCommandRunning(key: "test", command: command))
        trafficController.append(for: "test", command: command)
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command))
    }
    
    func testIsCommand1Running() {
        let command1 = Command<DataModel>()
        let command2 = Command<DataModel>()
        let trafficController = TrafficControllerMultiSet()
        trafficController.append(for: "test", command: command1)
        trafficController.append(for: "test", command: command1)
        trafficController.append(for: "test", command: command2)
        trafficController.printTrace()
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command1))
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command2))
    }
    
    func testResetFlow() {
        let command1 = Command<DataModel>()
        let command2 = Command<DataModel>()
        let trafficController = TrafficControllerMultiSet()
        trafficController.append(for: "test", command: command1)
        trafficController.append(for: "test", command: command2)
        trafficController.printTrace()
        trafficController.resetFlow(key: "test")
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command1))
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command2))
    }
    
    func testResetFlow2() {
        let command1 = Command<DataModel>()
        let command2 = Command<DataModel>()
        let trafficController = TrafficControllerMultiSet()
        trafficController.append(for: "test", command: command1)
        trafficController.append(for: "test2", command: command2)
        trafficController.printTrace()
        trafficController.resetFlow(key: "test")
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command1))
        XCTAssertTrue(trafficController.isCommandRunning(key: "test2", command: command2))
    }
    
    func testResetTraffic() {
        let command1 = Command<DataModel>()
        let command2 = Command<DataModel>()
        let trafficController = TrafficControllerMultiSet()
        trafficController.append(for: "test", command: command1)
        trafficController.append(for: "test2", command: command2)
        trafficController.printTrace()
        trafficController.resetTraffic()
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command1))
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test2", command: command2))
    }

}
