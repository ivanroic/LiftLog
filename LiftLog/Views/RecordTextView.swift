//
//  RecordTextView.swift
//  LiftLog
//
//  Created by MacbookPro on 1/26/22.
//

import SwiftUI
import Speech


struct RecordTextView: View {
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            VStack{
                Text("\(swiftUISpeech.outputText)")// prints results to screen
                    .font(.title)
                    .bold()
                
            }.frame(width: 300,height: 400)
            
            VStack {// Speech button
                
                swiftUISpeech.getButton()
                Spacer()
            }
            
        }
    }
}

struct RecordTextView_Previews: PreviewProvider {
    static var previews: some View {
        RecordTextView().environmentObject(SwiftUISpeech())
    }
}
