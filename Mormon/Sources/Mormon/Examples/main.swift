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

app.get(path: "/guess-the-movie") { res in
    let dict: [String: Any] = ["name": "Rick Deckard", "nicknames": ["Mr. Nighttime", "The Boogeyman"], "hair":["color":"brown", "isGraying":true]]
    res.json(dict)
}

app.get(path: "/") { res in
    
    var responseHtml = "<html>"
    responseHtml += "<h1>Hei!</h1>"
    responseHtml += "<style>*{font-family: helvetica; text-align: center}</style>"
    responseHtml += "<p>Jeg er laget i Swift.</p>"
    responseHtml += "<a href='https://github.com/GuleAdrian/Mormon'> > Github</a></br>"
    responseHtml += "<a href='/guess-the-movie'> > Guess The Movie</a>"
    responseHtml += "</html>"
    
    res.send(responseHtml)
}

//Use your Docker-Compose Service name in docker, in order to bind to the correct IP.
app.listen(hostname: "mormon", port: 3000) { err in
    if let err = err {
        print("failed to start server: ", err)
        return
    }
    print("Server running")
}
