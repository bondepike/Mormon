//
//  main.swift
//  Mormon
//
//  Created by Adrian Evensen on 11/04/2018.
//  Copyright © 2018 Adrianf. All rights reserved.
//

import Foundation


let app = Mormon()

//app.setHost(to: "10.10.3.155") // defaults to 'localhost'

app.get(path: "/hi") { res in
    res.send("Hello")
}

app.get(path: "/") { res in
    let dict: [String: Any] = ["name": "Rick Deckard", "nicknames": ["Mr. Nighttime", "The Boogeyman"], "hair":["color":"brown", "isGraying":true]]
    res.json(dict)
}

app.listen(port: 3000) { err in
    if let err = err {
        print("failed to start server: ", err)
        return
    }
    print("Server running")
}
