//
//  CityWebViewController.swift
//  WheatherAppViper
//
//  Created by Artem Bogachenko on 15.07.2021.
//  
//

import UIKit

final class CityWebViewController: UIViewController {
	private let output: CityWebViewOutput

    init(output: CityWebViewOutput) {
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

extension CityWebViewController: CityWebViewInput {
}
