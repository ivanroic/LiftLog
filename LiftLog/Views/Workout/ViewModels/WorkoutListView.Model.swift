//
//  WorkoutListView.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import Foundation
import Combine

extension WorkoutListView {
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
