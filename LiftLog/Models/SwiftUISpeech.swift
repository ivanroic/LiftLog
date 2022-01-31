//
//  SpeechSwiftUI.swift
//  LiftLog
//
//  Created by MacbookPro on 1/25/22.
//

import Speech
import SwiftUI
import Foundation

public class SwiftUISpeech: ObservableObject{
    init(){
        
        //Requests auth from User
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                    case .authorized:
                        break

                    case .denied:
                        break
                    
                    case .restricted:
                        break
                      
                    case .notDetermined:
                        break
                      
                    default:
                        break
                }
            }
        }// end of auth request
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
    }
    
    func getButton()->SpeechButton{ // returns the button
        return button
    }// end of get button
    
    func startRecording(){// starts the recording sequence
        //print test
        // restarts the text
        outputText = "";
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
        // try catch to start audio session
        do{
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            print("ERROR: - Audio Session Failed!")
        }
        
        // Configure the microphone input and request auth
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Create a recognition task for the speech recognition session.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ result, error in
            if (result != nil){
                self.outputText = (result?.transcriptions[0].formattedString)!
            }
            if let result = result{
                // Update the text view with the results.
                self.outputText = result.transcriptions[0].formattedString
            }
            if error != nil {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
    }// end of stop recording
    
    func stopRecording() -> Workout{// end recording
        
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        
        //Create a workout from the provided outputText
        var set:String = ""
        var rep:String = ""
        var workout:String = ""
        var weight:String = ""
        if self.outputText.lowercased().contains("bench press") {
            workout = "Bench Press"
        }
        if self.outputText.lowercased().contains("set 1") {
            set = "Set 1"
        }
        if self.outputText.lowercased().contains("10 reps") {
            rep = "10"
        }
        if self.outputText.lowercased().contains("135 pounds") {
            weight = "135"
        }
        
        let userID = "1"
        let date = Date.now
        self.workout_obj = Workout(name: workout, set: set, reps: rep, weight: weight, userID: userID, created_date: date)
        return workout_obj
    }// restarts the variables
    
    
    func getSpeechStatus()->String{// gets the status of authorization
        
        switch authStat{
            
            case .authorized:
                return "Authorized"
            
            case .notDetermined:
                return "Not yet Determined"
            
            case .denied:
                return "Denied - Close the App"
            
            case .restricted:
                return "Restricted - Close the App"
            
            default:
                return "ERROR: No Status Defined"
    
        }// end of switch
        
    }// end of get speech status
    
    /* Variables **/
    @Published var isRecording:Bool = false
    @Published var button = SpeechButton(workoutListViewModel: WorkoutListView.Model())
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let authStat = SFSpeechRecognizer.authorizationStatus()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let workout_Names:[String] = ["bench press", "squat", "deadlift", "shoulder press", "barbell rows"]
    private var workout_obj = Workout(name: "default", set: "def", reps: "def", weight: "def", created_date: Date.now)
    public var outputText:String = "";
}
