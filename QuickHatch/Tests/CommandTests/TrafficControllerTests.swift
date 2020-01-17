//
//  TrafficControllerTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
@testable import QuickHatch

class TrafficControllerTests: XCTestCase {

    func testIsCommandRunning() {
        let command = Command<DataModel>()
        let trafficController = TrafficControllerSet()
        trafficController.append(for: "test", command: command)
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command))
    }
    
    func testResetTrafficForCommand() {
        let command = Command<DataModel>()
        let trafficController = TrafficControllerSet()
        trafficController.append(for: "test", command: command)
        trafficController.printTrace()
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command))
        trafficController.resetFlow(key: "test")
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command))
        
    }
    
    func testResetTraffic() {
        let command = Command<DataModel>()
        let command2 = Command<DataModel>()
        let trafficController = TrafficControllerSet()
        trafficController.append(for: "test", command: command)
        trafficController.append(for: "test", command: command2)
        trafficController.append(for: "test2", command: command2)
        log.warning("commands running")
        XCTAssertTrue(trafficController.isCommandRunning(key: "test", command: command))
        XCTAssertTrue(trafficController.isCommandRunning(key: "test2", command: command2))
        trafficController.resetTraffic()
        log.severe("traffic resetted")
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test", command: command))
        XCTAssertTrue(!trafficController.isCommandRunning(key: "test2", command: command))
    }

}
