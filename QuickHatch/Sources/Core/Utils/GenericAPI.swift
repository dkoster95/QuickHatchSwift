//
//  GenericAPI.swift
//  QuickHatch
//
//  Created by Daniel Koster on 9/6/18.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol GenericAPI {
    var networkEnvironment: HostEnvironment { get set }
    var path: String { get }
}
