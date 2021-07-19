import UIKit
import WebKit

final class CityWebViewController: UIViewController {
    private let output: CityWebViewOutput
    let webConfiguration = WKWebViewConfiguration()
    lazy var webView: WKWebView = WKWebView(frame: .zero, configuration: webConfiguration)

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
        view.backgroundColor = .white
        webView.uiDelegate = self
        view.addSubview(webView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        webView.pin
            .top(navigationController?.navigationBar.frame.size.height ?? 15)
            .left(0)
            .right(0)
            .bottom(0)
    }
    
    @objc private func didTapRefresh(){
        output.didTapRefresh()
    }
}

extension CityWebViewController: CityWebViewInput {
    func loadWebView(with request: URLRequest) {
        webView.load(request)
    }
}

extension CityWebViewController: WKUIDelegate {
    
}
