//
//  WorkoutRepository.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class WorkoutRepository: ObservableObject {
    private let store = Firestore.firestore()
    private let path = "workout"
    
    @Published var workout: [Workout] = []
    
    init() {
        get()
    }
    
    func get() {
        print("DRASKO IS GAAAAAYYYYY")
        store.collection(path)
            .addSnapshotListener { querySnapShot, error in
                if let error = error {
                    print("Error getting workout: \(error.localizedDescription)")
                    return
                }
                self.workout = querySnapShot?.documents.compactMap {
                    document in
                    try? document.data(as: Workout.self)
                } ?? []
                print(self.workout)
            }
    }
    
    func add(_ workout: Workout) {
        do {
            _ = try store.collection(path).addDocument(from: workout)
        } catch {
            fatalError("Unable to add workout: \(error.localizedDescription)")
        }
    }
    
    func update(_ workout: Workout) {
      guard let workoutId = workout.id else { return }

      do {
        try store.collection(path).document(workoutId).setData(from: workout)
      } catch {
        fatalError("Unable to update workout: \(error.localizedDescription).")
      }
    }
    
    func remove(_ workout: Workout) {
      guard let workoutId = workout.id else { return }

      store.collection(path).document(workoutId).delete { error in
        if let error = error {
          print("Unable to remove workout: \(error.localizedDescription)")
        }
      }
    }
}
