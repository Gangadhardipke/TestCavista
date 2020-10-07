//
//  Extension.swift
//  Cavista
//
//  Created by Admin on 05/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
public extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadingView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

public protocol ReusableView {
    static var defaultReuseIdentifier: String {
        get
    }
}

extension ReusableView where Self: UIView{
    public static var defaultReuseIdentifier: String{
        return String(describing: self)
    }
}
public protocol NibLoadingView {
    static var nibName: String{
        get
    }
}

public extension NibLoadingView where Self: UIView{
    static var nibName: String{
        return String(describing: self)
    }
}

public extension UIImageView {
    func configureForUser(url: String, recordService: CavistaServiceProvider?, completion: ((_ response: Bool) -> Void)?) -> CancalableRequest? {
        self.image = nil
        guard let userService = recordService else { return nil }
        return userService.fetchAvatar(url: url) { [weak self] response in
            switch response {
            case .success(let image):
                self?.image = image
                completion?(true)
            case .failure:
                completion?(false)
            }
        }
    }
}
