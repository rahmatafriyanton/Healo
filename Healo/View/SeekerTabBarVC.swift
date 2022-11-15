//
//  SeekerTabBarVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import Foundation
import UIKit

class SeekerTabBarVC : UITabBarController{
    
    var numOfAllMMessageRec : Int = 0 //Total number of active chat
    var viewModel = ChatListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarUI()
        setupVC()
        setupBadge()
        viewModel.fetchChats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBadge()
    }
    
    func configureTabBarUI(){
        view.backgroundColor = .tabBarGreyBack
        UITabBar.appearance().barTintColor = .tabBarGreyBack
        tabBar.tintColor = .darkPurple
        tabBar.isTranslucent = false
    }
    
    func setupVC(){
        viewControllers = [
            createNavController(for: ChatListVC(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "bubble.right")!, selImage: UIImage(systemName: "bubble.right.fill")!),
            createNavController(for: JournalVC(), title: NSLocalizedString("Journal", comment: ""), image: UIImage(systemName: "book.closed")!, selImage: UIImage(systemName: "book.closed.fill")!),
            createNavController(for: DataProfileVC(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!, selImage: UIImage(systemName: "person.fill")!)
        ]
    }
    
    func setupBadge(){
        var chats = viewModel.allChats
        
        for chat in chats {
            if(chat.chatStatus == "active"){
                numOfAllMMessageRec += chat.numOfMesReceived
            }
        }
        
        if numOfAllMMessageRec > 0 {
            tabBar.items![0].badgeValue = String(numOfAllMMessageRec)
            tabBar.items![0].badgeColor = .redNotif
        }
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage,
                                                    selImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selImage
        return navController
    }
    
}
