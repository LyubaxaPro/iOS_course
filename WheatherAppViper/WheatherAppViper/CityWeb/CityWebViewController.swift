import UIKit
import WebKit

final class CityWebViewController: UIViewController {
	private let output: CityWebViewOutput
    private var webView: WKWebView?

    init(output: CityWebViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        view = webView
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
		super.viewDidLoad()
	}
}

extension CityWebViewController: CityWebViewInput {
}

extension CityWebViewController: WKUIDelegate{
    
}
