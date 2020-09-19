//
//  MockServerEnvironmentConfiguration.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

class MockServer: ServerEnvironmentConfiguration {
    var headers: [String: String] = ["Framework": "quickhatch"]
    
    var qa: HostEnvironment {
        return GenericHostEnvironment(headers: headers, baseURL: "www.quickhatch.com/qa")
    }
    
    var staging: HostEnvironment {
        return GenericHostEnvironment(headers: headers, baseURL: "www.quickhatch.com/stg")
    }
    
    var production: HostEnvironment {
        return GenericHostEnvironment(headers: headers, baseURL: "www.quickhatch.com/prod")
    }
    
}
