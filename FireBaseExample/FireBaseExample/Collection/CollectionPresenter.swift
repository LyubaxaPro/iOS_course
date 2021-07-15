//
//  CollectionPresenter.swift
//  FirebaseExample
//
//  Created by Artem Bogachenko on 13.07.2021.
//  
//

import Foundation

final class CollectionPresenter {
	weak var view: CollectionViewInput?
    weak var moduleOutput: CollectionModuleOutput?

	private let router: CollectionRouterInput
	private let interactor: CollectionInteractorInput

    init(router: CollectionRouterInput, interactor: CollectionInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CollectionPresenter: CollectionModuleInput {
}

extension CollectionPresenter: CollectionViewOutput {
}

extension CollectionPresenter: CollectionInteractorOutput {
}
