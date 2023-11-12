//
//  ChatClientTests.swift
//  ChatClientTests
//
//  Created by 현기엽 on 2023/11/12.
//

import XCTest
@testable import ChatClient

final class ChatClientTests: XCTestCase, TCPClientDelegate {
    typealias Request = ChatClient.Request
    typealias Response = ChatClient.Response
    
    func testA() async throws {
        let client = TCPClient<ChatClient.Request, ChatClient.Response, ChatClientTests>()
        client.delegate = self
        try? client.send(command: .init(header: .login, id: "0x11", length: nil, data: nil))
        try? await Task.sleep(until: .now + .seconds(31.0), clock: .continuous)
    }
    
    func receive(tcpClient: TCPClient<Request, Response, ChatClientTests>, response: Result<Response, Error>) {
        print(response)
    }
}
