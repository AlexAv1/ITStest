//
//  TableViewController.swift
//  Test
//
//  Created by iMac on 10.07.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // - URLSession
    private let session = URLSession.shared
    private let url = URL(string: "https://my.api.mockaroo.com/persons.json?key=f43efc60")!
    
    // - Data
    var persons = [PersonModel]()
    
    // - Action
    @IBAction func reloadButtonAction(_ sender: Any) {
        configureRequest()
    }
    @IBAction func genderSortButtonAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath ) as! TableViewCell
        let person = persons[indexPath.row]
        cell.textLabel!.text = "\(person.gender) \(person.first_name) \(person.dateOfBirtdh)"
        return cell
    }
    
}

// MARK: -
// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let person = persons[indexPath.row]
        let vc = UIStoryboard(name: "PersonInfo", bundle: nil).instantiateInitialViewController() as! PersonInfoViewController
        vc.persons = persons
        vc.id = person.id
        vc.name = person.first_name
        vc.lastName = person.last_name
        vc.mail = person.email
        vc.gender = person.gender
        vc.dr = person.dateOfBirtdh
        present(vc, animated: true, completion: nil)
    }
}

// MARK: -
// MARK: - Configure

private extension TableViewController {
    
    func configure() {
        configureUI()
        configureTableView()
        configureRequest()
    }
    
    func configureUI() {
        tableView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureRequest() {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                var persons: [PersonModel]?
                
                do {
                    persons = try JSONDecoder().decode([PersonModel].self, from: data)
                } catch {
                    
                }
                
                self?.persons = persons ?? []
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
            
        }
        
        task.resume()
    }
    
    func updateUI() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
}


