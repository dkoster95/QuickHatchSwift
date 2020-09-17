//
//  WebSocket.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol WebSocket {
    func close()
    func connect()
    func send(data: Data)
    func receive(didReceive: @escaping (Result<Data,Error>) -> Void)
    var onConnected: (() -> Void)? { get set }
    var onClosed: ( (Error?) -> Void )? { get set }
}
