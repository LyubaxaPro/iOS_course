//
//  CollectionViewController.swift
//  FirebaseExample
//
//  Created by Artem Bogachenko on 13.07.2021.
//  
//

import UIKit

final class CollectionViewController: UIViewController {
	private let output: CollectionViewOutput

    init(output: CollectionViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension CollectionViewController: CollectionViewInput {
}
