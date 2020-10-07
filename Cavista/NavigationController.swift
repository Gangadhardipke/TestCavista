//
//  NavigationController.swift
//  Cavista
//
//  Created by Admin on 06/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "filter"
        // Do any additional setup after loading the view.
    }
    

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        if traitCollection.userInterfaceStyle == .light {
            return .lightContent
        } else {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .default
            }
        }
    }

    public override convenience init(rootViewController: UIViewController) {
        self.init(rootViewController: rootViewController, useLargeTitle: false)
    }

    public init(rootViewController: UIViewController, useLargeTitle: Bool = false) {
        super.init(rootViewController: rootViewController)
        configureAppearance()
        navigationBar.prefersLargeTitles = useLargeTitle
        rootViewController.navigationItem.largeTitleDisplayMode = .always
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    }

    private func configureAppearance() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = UIColor.white
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationBar.isTranslucent = false
            navigationBar.tintColor = UIColor.white
        } else {
            navigationBar.barTintColor = UIColor.white
            navigationBar.tintColor = UIColor.white
            navigationBar.barStyle = .black
            navigationBar.isTranslucent = false
        }
    }

}
