//
//  CityWebPresenter.swift
//  WheatherAppViper
//
//  Created by Artem Bogachenko on 15.07.2021.
//  
//

import Foundation

final class CityWebPresenter {
	weak var view: CityWebViewInput?
    weak var moduleOutput: CityWebModuleOutput?

	private let router: CityWebRouterInput
	private let interactor: CityWebInteractorInput

    init(router: CityWebRouterInput, interactor: CityWebInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CityWebPresenter: CityWebModuleInput {
}

extension CityWebPresenter: CityWebViewOutput {
}

extension CityWebPresenter: CityWebInteractorOutput {
}
