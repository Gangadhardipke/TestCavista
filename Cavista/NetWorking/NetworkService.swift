//
//  NetworkService.swift
//  Cavista
//
//  Created by Admin on 04/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class NetworkService: NetworkServiceProvider {
 
    @discardableResult
    public func fetchRecords(completion: @escaping (APIResponse<[RecordModel]>) -> Void) -> CancalableRequest {
        let url = Constant.baseUrl
        return AlamofireManager.sessionManager.request(url, method: .get, parameters: nil).responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    if let data = response.data, let paginatedResponse = try? JSONDecoder().decode([RecordModel].self, from: data) {
                        completion(.success(paginatedResponse))
                    } else {
                        let error = NSError(domain: "Connection error", code: -1, userInfo: nil)
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error as NSError))
                }
            }
        }
    }
    
    @discardableResult
    public func fetchAvatar(url: String, completion: @escaping(APIResponse<Image?>) -> Void) -> CancalableRequest {

        let request = AlamofireManager.sessionManager.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
        if cachExsistsForURL(url: url), let image = ImageDownloader.default.imageCache?.image(withIdentifier: url) {
            completion(.success(image))
            return request
        }

        return request.responseImage(completionHandler: { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success (let image):
                    if image.size.width == 0  {
                        let error = NSError(domain: "Unknown Error", code: 0, userInfo: nil)
                        completion(.failure(error))
                        return
                    }else{
                        // Saves image to ImageDownloader cache
                        ImageDownloader.default.imageCache?.add(image, withIdentifier: url)
                        completion(.success(image))
                    }
                case .failure(let error):
                    completion(.failure(error as NSError))
                }
            }
        })
    }
    @discardableResult
       public func cachExsistsForURL(url: String) -> Bool {
           return ImageDownloader.default.imageCache?.image(withIdentifier: url) != nil
       }
    
    @discardableResult
    public func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// Cancel request
public protocol CancalableRequest {
    func cancel()
}

extension DataRequest: CancalableRequest {
    public func cancel() {
        AF.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach {
                if $0.originalRequest?.url?.absoluteString == self.request?.url?.absoluteString {
                    $0.cancel()
                }
            }
            uploadTasks.forEach {
                if $0.originalRequest?.url?.absoluteString == self.request?.url?.absoluteString {
                    $0.cancel()
                }
            }
            downloadTasks.forEach {
                if $0.originalRequest?.url?.absoluteString == self.request?.url?.absoluteString {
                    $0.cancel()
                }
            }
        }
    }
}
