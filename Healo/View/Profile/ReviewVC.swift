////
////  ReviewVC.swift
////  Healo
////
////  Created by Hana Salsabila on 21/10/22.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//
//class ReviewVC : UIViewController {
//    
////    private var viewModel = TableViewModel()
////    private var bag = DisposeBag()
////    lazy var tableView : UITableView = {
////        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
////        tv.backgroundColor = .none
////        tv.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")
////        return tv
////    }()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .white
////        self.view.addSubview(tableView)
////        viewModel.fetchUsers()
////        bindTableView()
////
////    }
////
////    func bindTableView() {
////        tableView.rx.setDelegate(self).disposed(by: bag)
////        viewModel.users.bind(to: tableView.rx.items(cellIdentifier: "RatingTableViewCell",cellType: RatingTableViewCell.self)) { (row,item,cell) in
////            cell.textLabel?.text = item.title
////            cell.detailTextLabel?.text = "\(item.id)"
////        }.disposed(by: bag)
////    }
////
////    func setupNavBar() {
////        navigationItem.title = "Ulasan"
////        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
//////        navigationController?.navigationBar.tintColor = .darkPurple
////    }
//}
//
//extension ReviewVC: UITableViewDelegate{}
//
//class TableViewModel {
//    var users = BehaviorSubject(value: [User]())
//    
//    func fetchUsers() {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            guard let data = data else {
//                return
//            }
//            do {
//                let responseData = try JSONDecoder().decode([User].self, from: data)
//                self.users.on(.next(responseData))
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
//}
//
//struct User: Codable {
//    let userID, id: Int
//    var title, body: String
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case id, title, body
//    }
//}
