//
//  InfoViewController.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var presenter: InfoPresenterProtocol!
    
    var stackViewVert: UIStackView!
    var stackViewHoriz: UIStackView!
    
    var firstLabel: UILabel!
    var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        navigationController?.navigationBar.barTintColor = BACKGROUND_COLOR
        let title = UILabel()
        title.text = "Info"
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.textColor = TEXT_LABEL_COLOR
        
        navigationItem.titleView = title
        
        createStackView()
        presenter.getInfo()
    }
    
    func createStackView() {
        stackViewVert   = UIStackView()
        stackViewVert.axis  = NSLayoutConstraint.Axis.vertical
        stackViewVert.distribution  = UIStackView.Distribution.fillEqually
        stackViewVert.alignment = UIStackView.Alignment.center
        stackViewVert.spacing   = 16.0
        self.view.addSubview(stackViewVert)
        
        stackViewVert.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewVert.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackViewVert.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackViewVert.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
        stackViewVert.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - InfoViewProtocol

extension InfoViewController: InfoViewProtocol {
    
    func addInfo(firstString: String, secondString: String) {
        firstLabel = UILabel()
        firstLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        firstLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        firstLabel.text = firstString
        firstLabel.textAlignment = .right
        
        secondLabel = UILabel()
        secondLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        secondLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        secondLabel.text = secondString
        secondLabel.textAlignment = .left
        
        stackViewHoriz = UIStackView()
        stackViewHoriz.axis = NSLayoutConstraint.Axis.horizontal
        stackViewHoriz.distribution = UIStackView.Distribution.fillEqually
        stackViewHoriz.alignment = UIStackView.Alignment.center
        stackViewHoriz.spacing = 16.0
        
        [firstLabel,
         secondLabel].forEach {
            $0?.font = UIFont.systemFont(ofSize: 20)
            $0?.textColor = TEXT_LABEL_COLOR
        }
        
        stackViewHoriz.addArrangedSubview(firstLabel)
        stackViewHoriz.addArrangedSubview(secondLabel)
        
        stackViewVert.addArrangedSubview(stackViewHoriz)
        
    }
}
