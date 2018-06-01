//
//  Router.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

struct Route {
    var method: HTTPMethod
    var path: String
    var handler: (ServerResponse) -> ()
}

class Router {
    
    typealias Middleware = (IncommingMessage, ServerResponse) -> ()
    private var middleware = [ Middleware ]()
    
    var routes = [Route]()
    
    /*
    func use(_ middleware: Middleware...) {
        self.middleware.append(contentsOf: middleware)
    }
    */
    
    func get(path: String, comletionHandler: @escaping (ServerResponse) -> () ) {
        let newRoute = Route(method: .GET, path: path, handler: comletionHandler)
        routes.append(newRoute)
    }
    
    func handle(request: IncommingMessage, response: ServerResponse) {
        
    }
}
