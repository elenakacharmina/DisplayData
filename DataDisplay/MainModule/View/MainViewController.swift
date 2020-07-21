//
//  MainViewController.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var presenter: MainPresenterProtocol!
    
    var imageView: UIImageView!
    var label: UILabel!
    
    var tableView: UITableView!
    
    var customIdentifier = "ImageTableViewCell"
    
    var tableData: DataForTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createConstraints()
        presenter.prepareData()
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func updateTable() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: customIdentifier, for: indexPath)
        if let customTableViewCell = tableViewCell as? ImageTableViewCell {
            let item = presenter.getItemForCell(at: indexPath.row)
            customTableViewCell.fillCell(text: item.1, imageURL: item.2)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.cellTapped(index: indexPath.row)
    }
}

// MARK: - Create UI

extension MainViewController {

    private func setupUI() {
        view.backgroundColor = BACKGROUND_COLOR
        navigationController?.navigationBar.barTintColor = BACKGROUND_COLOR
        navigationController?.navigationBar.topItem?.title = "List"
        let textAttributes = [NSAttributedString.Key.foregroundColor: TEXT_LABEL_COLOR]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = TEXT_LABEL_COLOR
        navigationItem.backBarButtonItem = backItem
        
        tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = BACKGROUND_COLOR
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: customIdentifier, bundle: nil), forCellReuseIdentifier: customIdentifier)
        tableView.isUserInteractionEnabled = true
        view.addSubview(tableView)
    }

    private func createConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
}
