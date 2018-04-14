//
//  SpritzSwiftPresenter.swift
//  SpritzSwift
//
//  Created by vincent Choubard on 13/04/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

class SpritzSwiftPresenter {

    // MARK: Properties

    weak var view: SpritzSwiftView?
    var router: SpritzSwiftWireframe?
    var interactor: SpritzSwiftUseCase?
    var delegate: SpritzSwiftDelegate?
}

extension SpritzSwiftPresenter: SpritzSwiftPresentation {
    func viewDidLoad() {
        // TODO: implement when the view did notify it load
    }
    // TODO: implement presentation methods
}

extension SpritzSwiftPresenter: SpritzSwiftInteractorOutput {
    // TODO: implement interactor output methods
}
