//
//  SchoolListViewModel.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//
 
import Foundation

protocol SchoolListViewModelDelegate: AnyObject {
    func schoolsChanged()
}

class SchoolListViewModel {
    private var allSchools = [School]() {
        didSet {
            retrieveScores()
        }
    }
    private var schools : [School] {
        didSet {
            delegate?.schoolsChanged()
        }
    }
    
    var client : SchoolAPIClient
    weak var delegate: SchoolListViewModelDelegate?
    
    init(Schools: [School] = [School](), Client: SchoolAPIClient = NYCSchoolAPIClient()){
        schools = Schools
        client = Client
    }
    
    func updateSchools(){
        client.retrieveSchools { NYCschools in
            guard let listOfSchools = NYCschools else {
                self.noSchoolData()
                return
            }
            DispatchQueue.main.async {
                self.allSchools = listOfSchools
                self.schools = listOfSchools
            }
        }
    }
    func retrieveScores(){
        //given more time these type of calls would scale better in the model Layer 
        client.retrieveSATSchools{ NYCschools in
            guard let listOfSchools = NYCschools else {
                self.noSchoolData()
                return
            }
            var tempSchools = self.allSchools
            var satSchools = [String:School]()
            satSchools.reserveCapacity(tempSchools.count)
            
            for school in listOfSchools {
                satSchools[school.schoolId] = school
            }
            
            for (i, school) in tempSchools.enumerated() {
                if let satSchool = satSchools[school.schoolId] {
                    tempSchools[i] = school + satSchool
                }
            }
            
            DispatchQueue.main.async {
                self.allSchools = tempSchools
            }
        }
    }
    func noSchoolData(){
        print("No data available for this school")
    }
    
    func filter(with searchText: String){
        if searchText.isEmpty == true{
            schools = allSchools
        }
        else {
            let searchTerm = searchText.lowercased()
            schools = allSchools.filter { $0.name.lowercased().contains(searchTerm) }
        }
    }
}


extension SchoolListViewModel {
    
    var numberOfSchools: Int {
        return schools.count
    }
    
    func schoolNames(index : Int) -> String {
        return schools[index].name
    }
    
    func schoolDatabaseNumber(index : Int) -> String {
        return schools[index].schoolId
    }
    
    func schoolDetailMethod(index : Int) -> School? {
        return schools[index]
    }
}
