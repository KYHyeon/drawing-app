//
//  TCPClientError.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation
import Network

enum TCPClientError: Error {
    case nwError(NWError)
    case contentIsEmpty
    case decodingFail
}
