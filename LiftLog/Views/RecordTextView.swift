//
//  RecordTextView.swift
//  LiftLog
//
//  Created by MacbookPro on 1/26/22.
//

import SwiftUI
import Speech


struct RecordTextView: View {
    @State var showForm = false
    @State var showUserView = false
    @State private var isShowingDetailedView = false
    @ObservedObject var model = Model()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack {
                NavigationView {
                    VStack{
                    NavigationLink(destination: WorkoutListView(), isActive: $isShowingDetailedView) { EmptyView() }
                  .navigationTitle("Record Your Workout")
                  .navigationBarTitleDisplayMode(.inline)
                  .navigationBarItems(
                    leading:
                      Button { showUserView = true }
                        label: {
                          Image(systemName: "person.fill")
                            .font(.title)
                        },
                    trailing:
                        Button {isShowingDetailedView=true}
                                label: {
                                    Image(systemName: "chevron.right.circle")
                                        .font(.title)
                                    }
                  )
                
                VStack{
                    Text("\(swiftUISpeech.outputText)")// prints results to screen
                        .font(.title)
                        .bold()
                }.frame(width: 300,height: 200)
                
                VStack {// Speech button
                    
                    swiftUISpeech.getButton()
                    Spacer()
                }
                }
                }
            }
    }
}

struct RecordTextView_Previews: PreviewProvider {
    static var previews: some View {
        RecordTextView().environmentObject(SwiftUISpeech())
    }
}
