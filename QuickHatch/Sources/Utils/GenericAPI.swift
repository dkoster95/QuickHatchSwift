//
//  GenericAPI.swift
//  Watch-iOS
//
//  Created by common on 9/6/18.
//  Copyright © 2018 Ford Motor Company. All rights reserved.
//

import Foundation

public protocol GenericAPI {
    var networkEnvironment: HostEnvironment { get set }
    var path: String { get }
}
