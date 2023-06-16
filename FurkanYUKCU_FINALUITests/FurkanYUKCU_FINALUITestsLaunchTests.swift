//
//  FurkanYUKCU_FINALUITestsLaunchTests.swift
//  FurkanYUKCU_FINALUITests
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import XCTest

final class FurkanYUKCU_FINALUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
