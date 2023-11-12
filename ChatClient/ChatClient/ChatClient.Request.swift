//
//  ChatClient.Request.swift
//  ChatClient
//
//  Created by 현기엽 on 2023/11/12.
//

import Foundation

extension ChatClient {
    struct Request : Encodable {
        let header : RequestHeader
        let id : String
        let length : Int?
        let data : Data?
    }
    
    enum RequestHeader: String, Encodable {
        case login = "0x10"
        case chat = "0x20"
    }

}
