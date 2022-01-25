//
//  Workout.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import FirebaseFirestoreSwift
import Foundation

struct Workout: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var set: String
    var reps: String
    var weight: String
    var userID: String?
    var created_date: Date
}

let testData = (1...10).map { i in Workout(name: "Name #\(i)", set: "Set #\(i)", reps: "Reps #\(i)", weight: "Weight #\(i)", created_date: Date.now)
}
