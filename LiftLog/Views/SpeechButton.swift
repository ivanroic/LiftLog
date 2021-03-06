//
//  SpeechButton.swift
//  LiftLog
//
//  Created by MacbookPro on 1/25/22.
//

import Speech
import SwiftUI
import Foundation

struct SpeechButton: View {
    
    @State var isPressed:Bool = false
    @State var actionPop:Bool = false
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @ObservedObject var workoutListViewModel: WorkoutListView.Model
    
    
    var body: some View {
        VStack {
            Button(action:{// Button
                if(self.swiftUISpeech.getSpeechStatus() == "Denied - Close the App"){// checks status of auth if no auth pop up error
                    self.actionPop.toggle()
                }else{
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.swiftUISpeech.isRecording.toggle()}// button animation
                    self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() :
                    self.swiftUISpeech.stopRecording().name=="" || self.swiftUISpeech.stopRecording().set=="" || self.swiftUISpeech.stopRecording().reps=="" || self.swiftUISpeech.stopRecording().weight=="" ? self.swiftUISpeech.stopRecordingWithoutObject() :
                    workoutListViewModel.add(self.swiftUISpeech.stopRecording())
                }
                }){
                Image(systemName: "waveform")// Button Image
                    .resizable()
                    .frame(width: 80, height: 40)
                    .foregroundColor(.white)
                    .background(swiftUISpeech.isRecording ? Circle().foregroundColor(.red).frame(width: 85, height: 85) : Circle().foregroundColor(.blue).frame(width: 70, height: 70))
                }.actionSheet(isPresented: $actionPop){
                    ActionSheet(title: Text("ERROR: - 1"), message: Text("Access Denied by User"), buttons: [ActionSheet.Button.destructive(Text("Reinstall the Appp"))])// Error catch if the auth failed or denied
                }
                Spacer()
                    .frame(height: 30)
                VStack {
                    Text("Press Button to Start Recording")
                    Spacer()
                        .frame(height: 15)
                    Text("Ex: \"Benchpress, Set 1, Reps 6, Pounds 200\"")
                        .allowsTightening(true)
                    Spacer()
                        .frame(height: 15)
                    Text("Press Button to Stop Recording")
                }
            }
        }
    }

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        SpeechButton( workoutListViewModel: WorkoutListView.Model()).environmentObject(SwiftUISpeech())
    }
}
