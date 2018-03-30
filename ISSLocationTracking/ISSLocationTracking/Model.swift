//
//  Model.swift
//  ISSLocationTracking
//
//  Created by Emayavaramban Srinivasan on 3/25/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import Foundation


/// Model object ISSJsonData

struct ISSJsonData: Codable {
    var message: String
    var request: Request
    var response: [Response]
}

///  Model object REquest

struct Request: Codable {
    var altitude, datetime: Int
    var latitude, longitude: Double
    var passes: Int
}

/// Model object Response

struct Response: Codable {
    var duration:Int , risetime: Double
}

// MARK: Convenience initializers

extension ISSJsonData {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ISSJsonData.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Request {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Request.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Response {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Response.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



