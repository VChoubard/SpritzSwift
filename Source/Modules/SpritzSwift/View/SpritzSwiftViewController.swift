//
//  SpritzSwiftViewController.swift
//  SpritzSwift
//
//  Created by vincent Choubard on 13/04/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation
import UIKit

class SpritzSwiftViewController: UIViewController {

    // MARK: Properties

    var presenter: SpritzSwiftPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SpritzSwiftViewController: SpritzSwiftView {
    // TODO: implement view output methods
}
