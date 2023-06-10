//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by Carlos Cardoso on 6/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var roundsPlayed = 0
    @State private var roundsWon = 0
    
    private let handOptions =   ["✊", "🖐️", "✌️"]
    
    private let outcomeOptions = ["Beats", "Looses for"]

    @State private var challengeHand = "✊"
    @State private var challengeOutcome = "Beats"
    @State private var challengeAnswer = "🖐️"
    @State private var userAnswer = "🖐️"
    
    init() {
        randomizeNewChallenge()
    }
    
    func randomizeNewChallenge() {
        let randomHand = Int.random(in: 0..<3)
        let randomOutcome = Int.random(in: 0..<2 )
         
        challengeHand = handOptions[randomHand]
        challengeOutcome = outcomeOptions[randomOutcome]

        challengeAnswer = (randomOutcome == 0) /* win */ ?
            handOptions[(randomHand+1)%handOptions.count] : /* circular 1 step to the right  */
            handOptions[(randomHand+2)%handOptions.count]   /* circular 2 steps to the right */
        }

    func showChallengeResults() {
        roundsPlayed += 1
        if userAnswer == challengeAnswer {
            roundsWon += 1
        }

        randomizeNewChallenge()
    }
    
    func restartChallenge() {
        roundsPlayed = 0
        roundsWon = 0

        randomizeNewChallenge()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Rounds played: \(roundsPlayed)")
                        .animation(.easeInOut(duration: 1.0))
                    Text("Rounds won: \(roundsWon)")
                } header: {
                    Text("Game Status")
                }
                
                Section {
                    Text("\(challengeOutcome) \(challengeHand)")
                        .font(.largeTitle)
                        .padding()
                    
                    Picker("", selection: $userAnswer) {
                        ForEach(handOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    HStack {
                        Button("Check result") {
                            showChallengeResults()
                        }
                        .buttonStyle(.bordered)
                        .padding()
                        
                        Spacer()
                        
                        Button("Restart") {
                            restartChallenge()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                } header: {
                    Text("Current match")
                }
                
                Section {
                    Text("Computer will randomly pick a game hand, either 'rock' ✊, 'paper' 🖐️ or 'scissors' ✌️) and an expected outcome ('beats' or 'loose for' ).")

                    Text("Your job is to match the second hand to accumulate points")
                } header: {
                    Text("Help")
                }
            }
            .navigationTitle("RPS Trainer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
