//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kirill Baranov on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userScore = 0
    @State private var roundCount = 0
    
    
    @State private var countries = ["Estonia",
                                    "France",
                                    "Germany",
                                    "Ireland",
                                    "Italy",
                                    "Nigeria",
                                    "Poland",
                                    "Spain",
                                    "UK",
                                    "US"]
        .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // animation
    @State private var rotation = 0.0
    @State private var selected = -1
    @State private var tapped = false
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .blueLargeTitle()
                        
                    }
                    
                    //When you tap a flag, make it spin around 360 degrees on the Y axis.
                    
                    ForEach(0..<3) { number in
                            Button {
                                tapped.toggle()
                                selected = number
                                rotation += 360
                                flagTapped(number)
                                scale -= 0.5
                                
                            } label: {
                                Image(countries[number].lowercased())
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                                    .opacity(tapped && selected != number ? 0.25 : 1)
                                    .scaleEffect(tapped && selected != number ? scale : 1)
                                    .animation(.easeIn, value: scale)
                                    .rotation3DEffect(.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
                            }
                        }
                    }
                    
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            } // VStack
            .padding()
            
        } // ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                askQuestion()
                selected = -1
                scale = 1.0
                tapped.toggle()
            }
            
        } message: {
            Text("Round \(roundCount) of 8. \n Your score is \(userScore)")
        }
        
    }//body
    
    func flagTapped(_ number: Int) {
        if roundCount < 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                userScore += 1
            } else {
                scoreTitle = "Wrong, that's the flag of \(countries[number])"
            }
            roundCount += 1
            showingScore = true
        } else {
            roundCount = 0
            userScore = 0
            flagTapped(number)
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

#Preview {
    ContentView()
}

struct BlueLargeTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueLargeTitle() -> some View {
        modifier(BlueLargeTitle())
    }
}
