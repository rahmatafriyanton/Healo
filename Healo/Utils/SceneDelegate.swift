//
//  SceneDelegate.swift
//  Healo
//
//  Created by Rahmat Afriyanton on 03/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
		guard let scene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: scene)
        print("token pas login:" + UserProfile.shared.token)
        let validity = VerifyToken.shared.verify(myStruct: [String].self)
        if (validity == "success"){
            if(UserProfile.shared.userRole == 1){
                if(UserProfile.shared.isEmailValidated == false){
                    window?.rootViewController = UINavigationController(rootViewController: VerifyEmailVC())
                } else if (UserProfile.shared.userYearBorn == 0) {
                    window?.rootViewController = UINavigationController(rootViewController: SetProfileVC())
                }
                
                if (UserProfile.shared.userAssessStatus == "Success"){
                    window?.rootViewController = UINavigationController(rootViewController: ListenerTabBarVC())
                } else {
                    window?.rootViewController = UINavigationController(rootViewController: TestExplanationVC())
                }
            } else if (UserProfile.shared.userRole == 2){
                if(UserProfile.shared.isEmailValidated == false){
                    window?.rootViewController = UINavigationController(rootViewController: VerifyEmailVC())
                } else if (UserProfile.shared.userYearBorn == 0) {
                        window?.rootViewController = UINavigationController(rootViewController: SetProfileVC())
                } else {
                    window?.rootViewController = UINavigationController(rootViewController: SeekerTabBarVC())
                }
            } else {
                window?.rootViewController = UINavigationController(rootViewController: OnboardingVC())
            }
        } else if (validity == "Failed"){
            if(UserProfile.shared.userId > 0 ){
                window?.rootViewController = UINavigationController(rootViewController: LoginVC())
            } else {
                window?.rootViewController = UINavigationController(rootViewController: OnboardingVC())
            }
        } else {
            window?.rootViewController = UINavigationController(rootViewController: OnboardingVC())
        }
//        window?.rootViewController = UINavigationController(rootViewController: SetProfileVC())
		window?.makeKeyAndVisible()
	}
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

