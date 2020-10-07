//
//  AlamofireManager.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager {
    private struct Constants {
        static let timeOutIntervalForResources = TimeInterval(3600)
        static let timeOutIntervalForRequest = TimeInterval(3600)
    }
    /// Creates an instance of session manager will default values set for time outs.
    static var sessionManager: Session = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = Constants.timeOutIntervalForResources
        sessionConfiguration.timeoutIntervalForRequest = Constants.timeOutIntervalForRequest
        return Alamofire.Session(configuration: sessionConfiguration)
    }()
}

/// Generic API response that is either success or failure
///
/// - success: generic type
/// - failure: error type
public enum APIResponse<T> {
    case success(T)
    case failure(NSError)
}
