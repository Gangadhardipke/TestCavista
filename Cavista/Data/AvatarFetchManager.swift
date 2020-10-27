//
//  AvatarFetchManager.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class AvatarFetchManager: NSObject {
    var recordService: NetworkServiceProvider? {
            return NetworkService()
       }

       var avatarRequests: [CancalableRequest?] = []

       func cancelAllRequests() {
           for request in avatarRequests {
               request?.cancel()
           }
       }
}
