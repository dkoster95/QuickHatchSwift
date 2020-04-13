//
//  Response.swift
//  QuickHatch
//
//  Created by Daniel Koster on 3/30/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public struct Response<Value> {
    public var data: Value
    public var httpResponse: URLResponse
    
    public func map<NewValue>(transform: (Value) -> NewValue) -> Response<NewValue> {
        return Response<NewValue>(data: transform(data), httpResponse: httpResponse)
    }
    
    public func flatMap<NewValue> (transform: (Value) -> Response<NewValue>) -> Response<NewValue> {
        return transform(data)
    }
    
    public func filter(query: (Value) -> Bool) -> Response<Value?> {
        return query(data) ? Response<Value?>(data: data, httpResponse: httpResponse) : Response<Value?>(data: nil, httpResponse: httpResponse)
    }
}
