//
//  RecordTextView.Model.swift
//  LiftLog
//
//  Created by MacbookPro on 1/28/22.
//

import Foundation
import Combine

extension RecordTextView {
    final class Model: ObservableObject {
        @Published var workoutViewModels: [WorkoutView.Model] = []
        @Published var workoutRepository = WorkoutRepository()
        
        init() {
            workoutRepository.$workout.map { workout in
                workout.map { workout in
                    WorkoutView.Model(workout: workout, workoutRepository: self.workoutRepository)
                }
            }
            .assign(to: &$workoutViewModels)
        }
        
        func add(_ workout: Workout) {
            workoutRepository.add(workout)
        }
    }
}
