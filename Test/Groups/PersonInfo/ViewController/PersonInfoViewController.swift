//
//  PersonInfoViewController.swift
//  Test
//
//  Created by iMac on 10.07.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit

class PersonInfoViewController: UIViewController {

    // - UI
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var drLabel: UILabel!
    
    // - Data
    let tableViewControllerCell = TableViewCell()
    let tableViewController = TableViewController()
    var persons = [PersonModel]()
    
    var id = 0
    var name = ""
    var lastName = ""
    var mail = ""
    var gender = ""
    var dr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }


}

// MARK: -
// MARK: - Configure

private extension PersonInfoViewController {
    
    func configure() {
        configureLabel()
    }
    
    func configureLabel() {
        idLabel.text = String("id: \(id)")
        nameLabel.text = "Имя: \(name)"
        lastNameLabel.text = "Фамилия: \(lastName)"
        mailLabel.text = "Email: \(mail)"
        genderLabel.text = "Пол: \(gender)"
        drLabel.text = "Дата рождения: \(dr)"
    }
    
}
