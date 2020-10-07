//
//  CavistaServiceProvider.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import AlamofireImage
public protocol CavistaServiceProvider{
    @discardableResult
    func fetchRecords(completion: @escaping (APIResponse<[RecordModel]>) -> Void) -> CancalableRequest
    @discardableResult
    func fetchAvatar(url: String, completion: @escaping(APIResponse<Image?>) -> Void) -> CancalableRequest
    @discardableResult
    func isConnectedToInternet() ->Bool
}
