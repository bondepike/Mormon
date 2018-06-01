//
//  ServerResponse.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import NIO
import NIOHTTP1
import Foundation

class ServerResponse {
    
    public var status = HTTPResponseStatus.ok
    public let header: HTTPRequestHead
    public let channel: Channel
    
    init(channel: Channel, header: HTTPRequestHead) {
        self.channel = channel
        self.header = header
    }
    
    /// Sets up the header
    fileprivate func setupHeaderParts() {
        let resHeader = HTTPResponseHead(version: header.version, status: self.status)
        let headerPart = HTTPServerResponsePart.head(resHeader)
        _ = channel.write(headerPart)
    }
    
    /// Writes the Header end-part, then flushes and closes the channel.
    fileprivate func flushChannel() {
        let endPart = HTTPServerResponsePart.end(nil)
        _ = channel.writeAndFlush(endPart).map {
            self.channel.close(promise: nil)
        }
    }
    
    func send(_ s: String) {
        setupHeaderParts()
        
        let utf8 = s.utf8
        var buffer = channel.allocator.buffer(capacity: utf8.count)
        buffer.write(string: s)
        let bodyPart = HTTPServerResponsePart.body(.byteBuffer(buffer))
        _ = channel.write(bodyPart)
        
        self.flushChannel()
    }
    
    /// Converts the Dictionary to a json format and sends it to the client
    func json(_ dictToJson: [String : Any]) {
        setupHeaderParts()
        do {
            let json = try JSONSerialization.data(withJSONObject: dictToJson, options: .prettyPrinted)
            var buffer = channel.allocator.buffer(capacity: json.count)
            buffer.write(bytes: json)
            let bodyPart = HTTPServerResponsePart.body(.byteBuffer(buffer))
            _ = channel.write(bodyPart)
            self.flushChannel()
        } catch let error {
            print("failed to encode json: ", error)
        }
    }

}
