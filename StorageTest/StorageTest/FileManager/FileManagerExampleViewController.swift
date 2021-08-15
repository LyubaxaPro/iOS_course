import UIKit
import PinLayout

final class FileManagerExampleViewController: UIViewController {
    private let textField = UITextField()
    private let saveButton = UIButton()
    private let textLabel = UILabel()
    private let fileName: String = "test.txt"
    private let encoding: String.Encoding = .utf8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [textLabel, saveButton, textField].forEach({
            view.addSubview($0)
        })
        setup()
        restoreLabel()
    }
    
    private func setup() {
        saveButton.backgroundColor = .systemIndigo
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        textField.layer.borderWidth = 1
    }
    
    // функция генерирует базовый путь до того места где будем сохранять файл
    private func documentDirUrl() -> URL?{
        return try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    private func restoreLabel() {
        guard let url = documentDirUrl() else {
            return
        }
        
        let fileUrl = url.appendingPathComponent(fileName)
        guard let content = try? String(contentsOf: fileUrl, encoding: encoding) else {
            textLabel.text = "File is empty or not created"
            return
        }
        textLabel.text = content
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textField.pin
            .top(view.pin.safeArea.top + 30)
            .horizontally(30)
            .height(44)
        
        saveButton.pin
            .below(of: textField)
            .marginTop(20)
            .height(40)
            .horizontally(30)
        
        textLabel.pin
            .below(of: saveButton)
            .horizontally(20)
            .sizeToFit()
    }
    
    @objc
    private func didTapSaveButton() {
        guard let userInput = textField.text, !userInput.isEmpty else {
            return
        }
        
        guard let url = documentDirUrl() else {
            return
        }
        
        let fileUrl = url.appendingPathComponent(fileName)
        
        do {
            try userInput.write(to: fileUrl, atomically: true, encoding: encoding)
            textLabel.text = userInput
        } catch {
            debugPrint(error)
        }
    }
}
