//
//  AppDelegate.swift
//  Job
//
//  Created by Oleg Shupulin on 14.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let requestSender = RequestSender()
        let requestsFactory = RequestsFactory()
        let vacanciesService = VacanciesService(requestSender: requestSender,
                                                requestsFactory: requestsFactory)
        let vacanciesListDisplaDataFactory = VacanciesListDisplaDataFactory()
        let vacanciesContainer =
            VacanciesListModuleBuilder.InjectContainer(vacanciesService: vacanciesService,
                                                       
                                                       vacanciesListDisplaDataFactory: vacanciesListDisplaDataFactory)
        
        let viewController = VacanciesListModuleBuilder.viewController(container: vacanciesContainer)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let window: UIWindow = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            return window
        }()
        
        self.window = window
        
        return true
    }
}
