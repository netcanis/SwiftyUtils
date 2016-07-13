//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Tom Baranes. All rights reserved.
//

import Foundation

public extension NSURL {

    public var queryParameters: [String: String]? {
        guard let components = NSURLComponents(url: self as URL, resolvingAgainstBaseURL: true), queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        queryItems.forEach {
            parameters[$0.name] = $0.value
        }
        return parameters
    }

    public func addSkipBackupAttribute() throws {
        try setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
    }

}
