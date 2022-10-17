//
//  DownMarkSnapshotTests.swift
//  
//
//  Created by Sabahudin Kodro on 16/10/2022.
//

import XCTest
import SnapshotTesting
@testable import Downmark

final class DownMarkSnapshotTests: XCTestCase {

    override class func setUp() {
        isRecording = false
    }

    func testHeading() throws {
        let label = UILabel()
        let attributedString = Downmark().parse(text: "# Header")
        label.attributedText = attributedString

        assertSnapshot(matching: label, as: .image)
    }

    func testBoldHeading() throws {
        let label = UILabel()
        let attributedString = Downmark().parse(text: "# **Header**")
        label.attributedText = attributedString

        assertSnapshot(matching: label, as: .image)
    }

}
