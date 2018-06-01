//
//  notes.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import Foundation

/*
let head = HTTPResponseHead(version: header.version, status: .ok)
let part = HTTPServerResponsePart.head(head)
_ = ctx.channel.write(part)

let sendString = "Dette er en fungerende HTTP server!"
var buffer = ctx.channel.allocator.buffer(capacity: sendString.utf8.count)
buffer.write(string: sendString)

let bodypart = HTTPServerResponsePart.body(.byteBuffer(buffer))
_ = ctx.channel.write(bodypart)

let endpart = HTTPServerResponsePart.end(nil)
_ = ctx.channel.writeAndFlush(endpart).then {
    ctx.channel.close()
}
*/
