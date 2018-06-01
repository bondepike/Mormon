//
//  IncomingMessage.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import NIOHTTP1

class IncommingMessage {
    
    public let header: HTTPRequestHead
    public var userInfo = [String: Any]()
    
    
    init(header: HTTPRequestHead) {
        self.header = header
    }
    
}
