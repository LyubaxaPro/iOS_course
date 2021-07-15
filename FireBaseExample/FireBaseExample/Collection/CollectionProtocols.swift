//
//  CollectionProtocols.swift
//  FirebaseExample
//
//  Created by Artem Bogachenko on 13.07.2021.
//  
//

import Foundation

protocol CollectionModuleInput {
	var moduleOutput: CollectionModuleOutput? { get }
}

protocol CollectionModuleOutput: class {
}

protocol CollectionViewInput: class {
}

protocol CollectionViewOutput: class {
}

protocol CollectionInteractorInput: class {
}

protocol CollectionInteractorOutput: class {
}

protocol CollectionRouterInput: class {
}
