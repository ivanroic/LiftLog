//
//  CardView.Model.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import Foundation
import Combine

extension WorkoutView {
  final class Model: ObservableObject, Identifiable {
    private let workoutRepository: WorkoutRepository
    @Published var workout: Workout
    private var cancellables: Set<AnyCancellable> = []
    var id = ""

    func update(workout: Workout) {
        workoutRepository.update(workout)
    }
    
    func remove() {
        workoutRepository.remove(workout)
    }
    
    init(workout: Workout, workoutRepository: WorkoutRepository) {
        self.workoutRepository = workoutRepository
        self.workout = workout
      
      $workout
        .compactMap { $0.id }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
  }
}
