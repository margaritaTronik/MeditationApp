//
//  ContentView.swift
//  MeditationApp
//
//  Created by Margarita Tronik on 31/07/2024.
//

import SwiftUI

let meditationDuration = 10.0

struct ContentView: View {
    
    @State private var remainingTime = TimeInterval(meditationDuration)
    @State private var userMeditating = false
    @State private var pause = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: calculateProgress())
                .stroke(lineWidth: 5.0)
                .foregroundColor(.purple)
                .overlay() {
                    
                    VStack {
                        
                        Text(userMeditating ? timeString(time: remainingTime) : String(format: "      %d seconds \n meditation session",Int(meditationDuration)))
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                        
                        HStack {
                            
                            Button {
                                userMeditating = false
                                pause = false
                                remainingTime = meditationDuration
                            } label: {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 100, height: 100)
                                    .overlay() {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .bold()
                                    }
                                    .padding()
                            }
                            
                            Spacer()
                            
                            Button {
                                if userMeditating {
                                    pause = true
                                } else {
                                    userMeditating = true
                                }
                            } label: {
                                Circle()
                                    .foregroundColor(.purple)
                                    .frame(width: 100, height: 100)
                                    .overlay() {
                                        Text(userMeditating ? "Pause" : "Start")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .bold()
                                    }
                                    .padding()
                            }
                            
                        }
                    }
                    
                }
        }
        .padding()
        .onReceive(timer){ _ in
            if userMeditating && !pause {
                if remainingTime == 0 {
                    userMeditating = false
                    remainingTime = meditationDuration
                } else{
                    remainingTime -= 1
                }
            }
        }
    }
    
    func calculateProgress() -> Double {
        return remainingTime / Double(meditationDuration)
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time)/3600 // num of seconds in hour
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    ContentView()
}
