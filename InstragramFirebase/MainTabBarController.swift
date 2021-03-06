//
//  MainTabBarController.swift
//  InstragramFirebase
//
//  Created by freddy on 04/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        
        if index == 2 {
            let photoController = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
            let photoNav = UINavigationController(rootViewController: photoController)
            present(photoNav, animated: true, completion: nil)

            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginViewController()
                let logInnavController = UINavigationController(rootViewController: loginController)
                self.present(logInnavController, animated: true, completion: nil)
            }
            return
        }
        setupControllers()
    }
    
    func setupControllers() {
        
        // home
        let homeNavCoontroller = templateNavController(
            selectedImage: #imageLiteral(resourceName: "home_selected"),
            unSelectedImage: #imageLiteral(resourceName: "home_unselected"),
            rootController: HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        )

        // search
        let searchNavCoontroller = templateNavController(
            selectedImage: #imageLiteral(resourceName: "search_selected"),
            unSelectedImage: #imageLiteral(resourceName: "search_unselected"),
            rootController: UserSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        )
        
        // pluse
        let pluseNavCoontroller = templateNavController(
            selectedImage: #imageLiteral(resourceName: "plus_unselected"),
            unSelectedImage: #imageLiteral(resourceName: "plus_unselected")
        )
        
        // like
        let likeNavCoontroller = templateNavController(
            selectedImage: #imageLiteral(resourceName: "like_selected"),
            unSelectedImage: #imageLiteral(resourceName: "like_unselected")
        )
        
        // profile
        let profileNavCoontroller = templateNavController(
            selectedImage: #imageLiteral(resourceName: "profile_selected"),
            unSelectedImage: #imageLiteral(resourceName: "profile_unselected"),
            rootController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        )
        
        tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        viewControllers = [homeNavCoontroller,
                           searchNavCoontroller,
                           pluseNavCoontroller,
                           likeNavCoontroller,
                           profileNavCoontroller
        ]
        
        // modify tab bar items
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    private func templateNavController(selectedImage: UIImage, unSelectedImage: UIImage, rootController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootController)
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.image = unSelectedImage
        return navController
    }

}




