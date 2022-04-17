//
//  BaseViewController.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    var TAG: String {
        return String(describing: Self.self)
    }
    var bindings = Set<AnyCancellable>()

    static var identifier: String {
        return String(describing: Self.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setBindings()
    }

    func initView() {}

    func setBindings() {}
}
