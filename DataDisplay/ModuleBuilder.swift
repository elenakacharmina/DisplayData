//
//  ModuleBuilder.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createInfoModule(router: RouterProtocol, name: String, selectedId: Int?)-> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func createInfoModule(router: RouterProtocol, name: String, selectedId: Int? = nil) -> UIViewController {
        let view = InfoViewController()
        let presenter = InfoPresenter(view: view, router: router, name: name, selectedId: selectedId)
        view.presenter = presenter
        return view
    }
}
