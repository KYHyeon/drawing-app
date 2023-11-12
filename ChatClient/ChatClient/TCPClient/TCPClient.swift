//
//  TCPClient.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation
import Network

final class TCPClient<Request: Encodable, Response: Decodable, Delegate: TCPClientDelegate> where Delegate.Request == Request, Delegate.Response == Response {
    private let queue = DispatchQueue(label: "com.giyeop.ChatClient.TCPClient")
    private let id = UUID().uuidString
    private let connection: NWConnection
    var delegate: Delegate?
    
    init() {
        let endpoint = NWEndpoint.hostPort(host: .ipv4(.loopback), port: 9090)
        self.connection = NWConnection(to: endpoint, using: .init(tls: nil, tcp: .init()))
        connection.start(queue: queue)
        bind()
    }
    
    private func bind() {
        connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { [weak self] (content, _, _, error) in
            guard let self else { return }
            if let error {
                self.delegate?.receive(tcpClient: self, response: .failure(TCPClientError.nwError(error)))
                return
            }
            guard let content else {
                self.delegate?.receive(tcpClient: self, response: .failure(TCPClientError.contentIsEmpty))
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: content)
                self.delegate?.receive(tcpClient: self, response: .success(response))
                return
            } catch {
                self.delegate?.receive(tcpClient: self, response: .failure(TCPClientError.decodingFail))
                return
            }
        }
    }
    
    func send(command: Request) throws {
        let data = try JSONEncoder().encode(command)
        connection.send(content: data, completion: .contentProcessed { _ in })
    }
}
