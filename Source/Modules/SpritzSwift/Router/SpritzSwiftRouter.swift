//
//  SpritzSwiftRouter.swift
//  SpritzSwift
//
//  Created by vincent Choubard on 13/04/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation
import UIKit

class SpritzSwiftRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(delegate: SpritzSwiftDelegate? = nil) -> SpritzSwiftViewController {
        let viewController = SpritzSwiftViewController()
        let presenter = SpritzSwiftPresenter()
        let router = SpritzSwiftRouter()
        let interactor = SpritzSwiftInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SpritzSwiftRouter: SpritzSwiftWireframe {
    // TODO: Implement wireframe methods
}
