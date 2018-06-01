//
//  Express.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

/// The API for responding to HTTP 1.x requests
class Mormon: Router {
    
    private var hostAdress: String = "localhost"
    private let loopGroup = MultiThreadedEventLoopGroup(numThreads: System.coreCount)
    
    func setHost(to: String) {
        self.hostAdress = to
    }
    
    /**
     Listen to a specific port on the machine for HTTP 1.x requests.
     **Required** method.
     */
    func listen(port: Int, completionHandler: @escaping(Error?) -> ()) {
        let reuseAddrOpt = ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR)
        
        let bootstrap = ServerBootstrap(group: loopGroup)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(reuseAddrOpt, value: 1)
        
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().then { _ in
                    channel.pipeline.add(handler: HTTPHandler(router: self))
                    
                }
            }
            
            .childChannelOption(ChannelOptions.socket(IPPROTO_TCP, TCP_NODELAY), value: 1)
            .childChannelOption(reuseAddrOpt, value: 1)
            .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 1)
        
        
        do {
            //Host: from docker.compose.yml
            let serverChannel = try bootstrap.bind(host: "mormon", port: port).wait()
            completionHandler(nil)
            try serverChannel.closeFuture.wait() // kjører evig
        } catch let error {
            completionHandler(error)
        }
    }
    

}
