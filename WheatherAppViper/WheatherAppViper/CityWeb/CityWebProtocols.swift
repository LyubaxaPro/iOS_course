//
//  CityWebProtocols.swift
//  WheatherAppViper
//
//  Created by Artem Bogachenko on 15.07.2021.
//  
//

import Foundation

protocol CityWebModuleInput {
	var moduleOutput: CityWebModuleOutput? { get }
}

protocol CityWebModuleOutput: class {
}

protocol CityWebViewInput: class {
}

protocol CityWebViewOutput: class {
}

protocol CityWebInteractorInput: class {
}

protocol CityWebInteractorOutput: class {
}

protocol CityWebRouterInput: class {
}
