//
//  ChatClient.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation
import Network

struct Command : Encodable {
    let header : String
    let id : String
    let length : Int?
    let data : Data?
}

struct CommandResponse : Decodable {
    let header : String
    let id : String
}

public final class ChatClient {
    private let queue = DispatchQueue(label: "com.giyeop.ChatClient")
    private let id = UUID().uuidString
    private var connection: NWConnection!
    
    public func prepare() {
        connect()
        bind()
        login()
    }
    
    private func connect() {
        let endpoint = NWEndpoint.hostPort(host: .ipv4(.loopback), port: 9090)
        self.connection = NWConnection(to: endpoint, using: .init(tls: nil, tcp: .init()))
        connection.start(queue: queue)
    }
    
    private func bind() {
        connection?.receive(minimumIncompleteLength: 4, maximumLength: 1024) { (content, context, isComplete, error) in
            print(content, context, isComplete, error)
            let response = try! JSONDecoder().decode(CommandResponse.self, from: content!)
            print(response)
        }
    }
    
    private func login() {
        let command = Command(header: "0x10", id: id, length: nil, data: nil)
        send(command: command, to: connection)
    }
    
    private func send(command: Command, to: NWConnection) {
        let data = try! JSONEncoder().encode(command)
        connection.send(content: data, completion: .contentProcessed({ error in
            print(error)
        }))
    }
}
