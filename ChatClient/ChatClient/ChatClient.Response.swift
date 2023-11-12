//
//  ChatClient.Response.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation

extension ChatClient {
    struct Response : Decodable {
        let header : ResponseHeader
        let id : String
    }
    
    enum ResponseHeader: String, Decodable {
        case login = "0x11"
        case chat = "0x21"
    }
}
