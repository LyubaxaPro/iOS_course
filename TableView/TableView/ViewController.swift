import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = UIView()

        tableView.tableHeaderView = headerView

        //для того чтобы таблица знала что у нее есть такие ячейки необходимо зарегистрировать
        //forCellReuseIdentifier объединяет ячейки, можно переиспользовать. Если в таблице есть разного типа ячейки то понятно что ячейка первого типа не может переиспользоваться для второго типа.
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //для разного количества строк в секции
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 5
        }

        //return 5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //отдает reusable cell которую мы можем перерисовать и что-то свое туда положить
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell
        else {
            return .init()
        }
        cell.textLabel?.text = "Cell (\(indexPath.row))"

        switch indexPath.section {
        case 0:
            cell.backgroundColor = .systemBlue
        case 1:
            cell.backgroundColor = .systemPink
        case 2:
            cell.backgroundColor = .systemTeal
        default:
            cell.backgroundColor = .systemGray
        }

        cell.configure()
        return cell
    }
    //таблица делегировала нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    //высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }

    //разделение секций
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("dkdmldkm")
    }

}

final class MyTableViewCell: UITableViewCell {
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .green
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(){
        textLabel?.text = "My Cell"
        tintColor = .darkGray
        accessoryType = .detailButton
    }
}

