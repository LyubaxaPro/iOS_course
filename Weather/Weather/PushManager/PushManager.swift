import UserNotifications
import UIKit
//weather://weather.com?screen=city&name=Moskow
enum PushStatus: String {
    case allowed, denied, unknown
}

protocol PushManagerDescription: AnyObject {
    func requestAuth()
    func add(observer: PushStatusObserver)}

protocol PushStatusObserver: AnyObject {
    func didChange(status: PushStatus)
}

final class WeakWrapper {
    weak var observer: PushStatusObserver?
}


final class PushManager {
    private var pushStatus: PushStatus = .unknown {
        didSet {
            if oldValue != pushStatus {
                observers.forEach { $0.observer?.didChange(status: pushStatus)}
            }
        }
    }
    
    private var observers: [WeakWrapper] = []
    
    static let shared: PushManagerDescription = PushManager()
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc
    private func didEnterForeground(){
        UNUserNotificationCenter.current().getNotificationSettings {[weak self] settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized:
                    self?.pushStatus = .allowed
                case .denied:
                    self?.pushStatus = .denied
                case .ephemeral, .notDetermined, .provisional:
                    self?.pushStatus = .unknown
                @unknown default:
                    self?.pushStatus = .unknown
                }
            }
        }
    }
}

extension PushManager: PushManagerDescription {
    
    func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {[weak self] granted, error in
            DispatchQueue.main.async {
                if granted {
                    self?.pushStatus = .allowed
                } else {
                    self?.pushStatus = .denied
                }
            }
        }
    }
    
    func add(observer: PushStatusObserver) {
        let obs = WeakWrapper()
        obs.observer = observer
        observers.append(obs)
    }
}

//добавить это в интерактор
