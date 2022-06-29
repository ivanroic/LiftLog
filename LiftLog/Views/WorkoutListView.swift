//
//  WorkoutListView.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-12.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct WorkoutListView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = Model()
    @State var showForm = false
    @State var showUserView = false
    @State var showSignInView = false
    let auth = Auth.auth()
//  @State var user: User?`
  
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical) {
          VStack {
            // TODO: Add cards here!
              ForEach(model.workoutViewModels) { workoutViewModel in
              WorkoutView(model: workoutViewModel)
                .padding([.vertical])
            }
          }
          .frame(width: geometry.size.width)
        }
      }
      .sheet(isPresented: $showForm) {
          NewWorkoutForm(workoutListViewModel: model)
      }
      .navigationTitle("Workout Cards")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(
        leading:
            Button { viewModel.signOut() }
            label: {
              Image(systemName: "person.fill")
                .font(.title)
            },
        trailing:
            Button { showForm.toggle() }
            label: {
                Image(systemName: "plus")
                    .font(.title)
            }
      )
    }
  }
}


struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
      WorkoutListView()
  }
}
