//
//  CountUpView2.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/11.
//

import SwiftUI
import Combine

struct CountUpView: View {
    var cancellables = Set<AnyCancellable>()
    
    @ObservedObject var viewModel = CountUpViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 30) {
                Button(action: {
                    viewModel.input.tapCountBtn.send(Void())
                }, label: {
                    Text("CountUp")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.purple)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 5)
                        )
                })
                
                Button(action: {
                    viewModel.input.tapResetBtn.send(Void())
                }, label: {
                    Text("Reset")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 5)
                            
                        )
                })
            }
            
            Text(viewModel.countText)
                .padding(.top, 60.0)
                .font(.title)
        }
    }
}

struct CountUpView_Previews: PreviewProvider {
    static var previews: some View {
        CountUpView()
    }
}

