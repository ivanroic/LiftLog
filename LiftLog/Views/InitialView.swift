//
//  InitialView.swift
//  LiftLog
//
//  Created by MacbookPro on 5/24/22.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var viewModel = Model()
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                WorkoutListView()
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
