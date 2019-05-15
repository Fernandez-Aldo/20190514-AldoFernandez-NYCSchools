//
//  School.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import Foundation

@objcMembers
class School : NSObject, Codable {
    
    enum CodingKeys : String, CodingKey {
        case schoolId = "dbn"
        case name = "school_name"
        case boro
        case overview = "overview_paragraph"
        case schoolSeats = "school_10th_seats"
        case academics = "academicopportunities1"
        
        case numOfParticipantsSAT = "num_of_sat_test_takers"
        case critcalReadAvgScoresSAT = "sat_critical_reading_avg_score"
        case mathAvgScoresSAT = "sat_math_avg_score"
        case writingAvgScoresSAT = "sat_writing_avg_score"
    }
    
    var schoolId : String
    var name : String
    var boro : String?
    var overview : String?
    var schoolSeats : String?
    var academics : String?
    
    var numOfParticipantsSAT : String?
    var critcalReadAvgScoresSAT : String?
    var mathAvgScoresSAT : String?
    var writingAvgScoresSAT : String?
}

extension School {
    static func +(lhs: School, rhs: School) -> School {
        if lhs.schoolId != rhs.schoolId { return lhs }
        if lhs.boro == nil {
            lhs.boro = rhs.boro
        }
        if lhs.overview == nil {
            lhs.overview = rhs.overview
        }
        if lhs.schoolSeats == nil {
            lhs.schoolSeats = rhs.schoolSeats
        }
        if lhs.academics == nil {
            lhs.academics = rhs.academics
        }
        if lhs.numOfParticipantsSAT == nil {
            lhs.numOfParticipantsSAT = rhs.numOfParticipantsSAT
        }
        if lhs.critcalReadAvgScoresSAT == nil {
            lhs.critcalReadAvgScoresSAT = rhs.critcalReadAvgScoresSAT
        }
        if lhs.mathAvgScoresSAT == nil {
            lhs.mathAvgScoresSAT = rhs.mathAvgScoresSAT
        }
        if lhs.writingAvgScoresSAT == nil {
            lhs.writingAvgScoresSAT = rhs.writingAvgScoresSAT
        }
        return lhs
    }
}
