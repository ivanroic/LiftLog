//
//  NewWorkoutForm.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import Foundation
import SwiftUI

struct NewWorkoutForm: View {
    @State var name: String = ""
    @State var set: String = ""
    @State var reps: String = ""
    @State var weight: String = ""
    @State var userID: String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var workoutListViewModel: WorkoutListView.Model

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Workout Name")
                  .foregroundColor(.gray)
                TextField("Enter Your Workout", text: $name)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  }
            VStack(alignment: .leading, spacing: 10) {
                Text("Set")
                  .foregroundColor(.gray)
                TextField("Enter Set Number", text: $set)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            VStack(alignment: .leading, spacing: 10) {
                  Text("Reps")
                    .foregroundColor(.gray)
                  TextField("Enter Number of Reps", text: $reps)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            VStack(alignment: .leading, spacing: 10) {
                  Text("Weight")
                    .foregroundColor(.gray)
                  TextField("Enter Weight", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            
            Button(action: addWorkout) {
                    Text("Add New Workout")
                        .foregroundColor(.blue)
                }
                Spacer()
                }
                .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
                }

    private func addWorkout() {
        let userID = "1"
        let date = Date.now
        let workout = Workout(name: name, set: set, reps: reps, weight: weight, userID: userID, created_date: date)
        workoutListViewModel.add(workout)
        presentationMode.wrappedValue.dismiss()
        }
    }

struct NewWorkoutForm_Previews: PreviewProvider {
  static var previews: some View {
    NewWorkoutForm(workoutListViewModel: WorkoutListView.Model())
  }
}
