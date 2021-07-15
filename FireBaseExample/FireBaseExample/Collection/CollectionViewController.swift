import UIKit
import PinLayout

final class CollectionViewController: UIViewController {
    private let createButton = UIButton()
	private let output: CollectionViewOutput
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()

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
        setupCollectionView()
        setupCreateButton()
        
        output.didLoadView()

	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.pin.all()
        createButton.pin
            .bottom(view.pin.safeArea.bottom + 16)
            .height(48)
            .horizontally(16)
    }
    
    private func setupCreateButton() {
        createButton.backgroundColor = .systemTeal
        createButton.setTitle("Create", for: .normal)
        createButton.layer.cornerRadius = 8
        createButton.layer.masksToBounds = true
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        view.addSubview(createButton)
        
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionCell")
        
        view.addSubview(collectionView)
    }
    
    @objc private func didTapCreateButton(){
        output.didTapCreateButton()
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionCell", for: indexPath) as? MyCollectionViewCell
        else {
            return .init()
        }
        
        let item = output.item(at: indexPath.item)
        cell.configure(with: item.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.bounds.width - 2
        let sideLength = availableWidth / 3
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension CollectionViewController: CollectionViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
    
}
