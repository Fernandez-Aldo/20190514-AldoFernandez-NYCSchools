//
//  SchoolListViewController.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

protocol SchoolListViewControllerDelegate: class {
    func didSelect(indexPath: Int)
}

class SchoolListViewController: UIViewController {
    
    @IBOutlet weak var schoolTableView : UITableView! {
        didSet {
            schoolTableView.delegate = self
            schoolTableView.dataSource = self
        }
    }
    @IBOutlet weak var searchBar : UISearchBar! {
        didSet {
            searchBar.returnKeyType = UIReturnKeyType.done
            searchBar.delegate = self
        }
    }
    var dismissGesture: UITapGestureRecognizer!
    
    weak var delegate : SchoolListViewControllerDelegate?
    var viewModel : SchoolListViewModel = SchoolListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasDismissed),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        dismissGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        dismissGesture.isEnabled = false
        view.addGestureRecognizer(dismissGesture)
        viewModel.delegate = self
        viewModel.updateSchools()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWasShown() {
        dismissGesture.isEnabled = true
    }
    
    @objc func keyboardWasDismissed() {
        dismissGesture.isEnabled = false
    }
}

extension SchoolListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(with: searchText)
    }
}

extension SchoolListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSchools
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = schoolTableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as! SchoolTableViewCell
        
        let title = viewModel.schoolNames(index:indexPath.row)
        let id = viewModel.schoolDatabaseNumber(index: indexPath.row)
        
        cell.configureCell(title: title, id: id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "SchoolDetailViewController") as! SchoolDetailViewController
        detailVC.school = viewModel.schoolDetailMethod(index: indexPath.row)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SchoolListViewController: SchoolListViewModelDelegate {
    func schoolsChanged() {
        self.schoolTableView.reloadData()
    }
}
