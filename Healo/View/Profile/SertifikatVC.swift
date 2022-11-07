//
//  SertifikatVC().swift
//  Healo
//
//  Created by Hana Salsabila on 21/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class SertifikatVC : UIViewController {
    
    private var viewModel = CollectionViewModel()
    private var bag = DisposeBag()
    lazy var sertifikatCV : UICollectionView = {
        let cv = UICollectionView(frame: self.view.frame) //(frame: self.view.frame, style: .insetGrouped)
        cv.backgroundColor = .none
//        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SertifikatCollectionViewCell.self, forCellWithReuseIdentifier: "SertifikatCollectionViewCell")
        return cv
    }()
    
    private let secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var sertifikatCollectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        view.backgroundColor = .white
//        self.title = "Users"
//        setupNavBar()
        self.view.addSubview(sertifikatCV)
        viewModel.fetchUsers()
        bindTableView()
        
    }
    
    private func setupNavBar() {
        navigationItem.title = "Sertifikat"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    func setupUI() {
        view.backgroundColor = .lightPurple
        
        setupNavBar()
        
        view.addSubview(secondView)
        secondViewConstraints()
//        view.addSubview(sertifikatCollectionView)
//        collectionViewConstraints()
        
    }
    
    func secondViewConstraints() {
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func bindTableView() {
        sertifikatCV.rx.setDelegate(self).disposed(by: bag)
        viewModel.users.bind(to: sertifikatCV.rx.items(cellIdentifier: "SertifikatCollectionViewCell",cellType: SertifikatCollectionViewCell.self)) { (index,item,cell) in
//            cell.hexLabel.text.text =     item.title
//            cell.detailTextLabel?.text = "\(item.id)"
        }.disposed(by: bag)
    }
}

//extension SertifikatVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//
//}
    
extension SertifikatVC: UITableViewDelegate{}

class CollectionViewModel {
    var users = BehaviorSubject(value: [myUser]())
    
    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let responseData = try JSONDecoder().decode([myUser].self, from: data)
                self.users.on(.next(responseData))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

struct myUser: Codable {
    let userID, id: Int
    var title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

