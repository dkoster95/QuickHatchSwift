//
//  MockAuthenticationRefresher.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/16/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch



class MockAuthenticationRefresher: RefreshableAuthentication {
    
    private var data: Any? = nil
    private var error: Error? = nil
    
    init(data: Any) {
        self.data = data
    }
    
    init(error: Error) {
        self.error = error
    }
    
    func refresh(params: [String : Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else if let error = error {
            completion(.success(error))
        }
    }
    
}
