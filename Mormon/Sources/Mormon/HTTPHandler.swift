//
//  HttpHandler.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1



class HTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    
    func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
        let reqPart = unwrapInboundIn(data)
        
        switch reqPart {
        case .head(let header):
            
            let _ = IncommingMessage(header: header)
            let response = ServerResponse(channel: ctx.channel, header: header)
            
            router.routes.forEach { (route) in
                guard route.path == header.uri else { return }
                guard route.method == header.method else { return }
                route.handler(response)
            }
            
        case .body, .end: break
        }
        
    }
}
