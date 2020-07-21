//
//  MainPresenter.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: class {
    func prepareData()
    func getItemForCell(at index: Int) -> (Bool, String, String)
    func getCount() -> Int
    func cellTapped(index: Int)
}

protocol MainViewProtocol: class {
    func updateTable()
    func failure(error: Error)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol!
    let networkService: NetWorkServiceProtocol!
    
    var data: DataForTable?
    
    required init(view: MainViewProtocol, router: RouterProtocol, networkService: NetWorkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    func prepareData() {
        networkService.getData() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.setTable(data: data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.view?.failure(error: error)
                    }
                }
            }
        }
    }
    
    func setTable(data: DataForTable) {
        self.data = data
        view?.updateTable()
    }
    
    func getItem(at index: Int) -> CommonItem? {
        guard let name = data?.view?[index] else { return nil }
        
        let item = data?.data?.first(where: { $0.name == name })
        return item
    }
    
    func getItemForCell(at index: Int) -> (Bool, String, String) {
        
        var isSelected = false
        var text = "No such data!"
        var url = ""
        
        if let item = getItem(at: index) {
            
            if let t = item.data?.text {
                text = t
            }
            if let u = item.data?.url {
                url = u
            }
            if let selectedId = item.data?.selectedId {
                isSelected = true
                if let t = item.data?.variants?.first(where: { $0.id == selectedId}) {
                    text = t.text
                }
            }
        }
        return (isSelected, text, url)
    }
    
    func getCount() -> Int {
        return data?.view?.count ?? 0
    }
    
    
    func cellTapped(index: Int) {
        guard let item = getItem(at: index) else { return }
        guard let name = data?.view?[index] else { return }
        
        router.showInfo(name: name, selectedId: item.data?.selectedId)
        
    }
    
}
