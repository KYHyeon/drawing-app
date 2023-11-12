//
//  TCPClientDelegate.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation

protocol TCPClientDelegate: AnyObject {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    
    func receive(tcpClient: TCPClient<Request, Response, Self>, response: Result<Response, Error>)
}
