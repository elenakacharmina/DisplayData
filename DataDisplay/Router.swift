//
//  Router.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func showInfo(name: String, selectedId: Int?)
}

class Router: RouterProtocol {
    
    var sceneDelegate: SceneDelegateProtocol?
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init (navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol, sceneDelegate: SceneDelegateProtocol){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.sceneDelegate = sceneDelegate
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showInfo(name: String, selectedId: Int?) {
         if let navigationController = navigationController {
            guard let infoViewController = assemblyBuilder?.createInfoModule(router: self, name: name, selectedId: selectedId) else { return }
             navigationController.pushViewController(infoViewController, animated: true)
         }
    }
}
