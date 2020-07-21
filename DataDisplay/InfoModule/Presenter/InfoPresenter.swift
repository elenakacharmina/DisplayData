//
//  InfoPresenter.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import Foundation
protocol InfoPresenterProtocol {
    func getInfo()
}

protocol InfoViewProtocol: class {
    func addInfo(firstString: String, secondString: String)
}

class InfoPresenter: InfoPresenterProtocol {
    
    weak var view: InfoViewProtocol?
    var router: RouterProtocol!
    
    var selectedId: Int?
    var name: String
    
    required init(view: InfoViewProtocol, router: RouterProtocol, name: String, selectedId: Int?){
        self.view = view
        self.router = router
        self.name = name
        self.selectedId = selectedId
    }
    
    func getInfo() {
        view?.addInfo(firstString: "Name:", secondString: name)
        if let id = selectedId {
            view?.addInfo(firstString: "ID:", secondString: String(describing: id))
        }
    }
}
