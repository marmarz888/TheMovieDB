//
//  Network.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/16/22.
//

import Foundation
import Network

class Network: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Network")
    @Published var isConnected: Bool = true
    
    var connectionDescription: String {
        if isConnected {
            return "Internet Connection Established."
        } else {
            return "Check Internet Connection."
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
