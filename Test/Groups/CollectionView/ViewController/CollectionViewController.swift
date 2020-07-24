//
//  CollectionViewController.swift
//  Test
//
//  Created by iMac on 10.07.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    // - UI
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // - Data
    private var persons = [PersonModel]()
    
    // - URLSession
    private let session = URLSession.shared
    private let url = URL(string: "https://my.api.mockaroo.com/persons.json?key=f43efc60")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - CollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.showsVerticalScrollIndicator = false
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let person = persons[indexPath.row]
        cell.nameLabel.text = person.first_name
        cell.lastNameLabel.text = person.last_name
        cell.drLabel.text = person.dateOfBirtdh
        return cell
    }
    
}

// MARK: -
// MARK: - CollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 20)
        let height = width / 4
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

private extension CollectionViewController {
    
    func configure() {
        configureUI()
        configureCollectionView()
        configureURL()
    }
    
    func configureUI() {
        collectionView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureURL() {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                var persons: [PersonModel]?
                
                do {
                    persons = try JSONDecoder().decode([PersonModel].self, from: data)
                    self?.persons = persons ?? []
                    DispatchQueue.main.async {
                        self?.updateUI()
                    }
                } catch {
                    
                }
            }
            
        }
        
        task.resume()
    }
    
    func updateUI() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
}
