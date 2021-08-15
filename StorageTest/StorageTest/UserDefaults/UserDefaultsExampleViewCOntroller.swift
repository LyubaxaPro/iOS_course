import UIKit
import PinLayout

final class UserDefaultsExampleViewController: UIViewController {
    private let mySwitch = UISwitch()
    private let key: String = "switchActive"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mySwitch)
        
        mySwitch.isOn = UserDefaults.standard.bool(forKey: key)
        mySwitch.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
    }
    
    @objc
    private func didChangeSwitch(){
        let isOn: Bool = mySwitch.isOn
        UserDefaults.standard.setValue(isOn, forKey: key)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mySwitch.pin
            .left(20)
            .top(view.pin.safeArea.top + 20)
    }
}
