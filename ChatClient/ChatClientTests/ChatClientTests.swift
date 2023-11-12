//
//  ChatClientTests.swift
//  ChatClientTests
//
//  Created by 현기엽 on 2023/11/12.
//

import XCTest
@testable import ChatClient

final class ChatClientTests: XCTestCase {
    func testA() async {
        let client = ChatClient()
        client.prepare()
        try? await Task.sleep(until: .now + .seconds(31.0), clock: .continuous)

    }
}
