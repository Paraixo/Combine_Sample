//
//  SwiftUIPopupView.swift
//  Combine_Sample
//
//  Created by 服部翼 on 2021/02/17.
//

import SwiftUI

struct CustomPopupView: View {
    @State var showPopup = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Z-Stack Custom Pop")
                Button(action: {
                    self.showPopup = true
                }, label: {
                     Text("Show Custom Popup")
                })
            }
            
            if showPopup {
                withAnimation {
                    PopupView()
                }
            }
        }
    }
}

struct PopupView: View {
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Custom Pop Up")
                Spacer()
                Button(action: {
                }, label: {
                    Text("Close")
                })
            }.padding()
        }
        .frame(width: 300, height: 200)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}


struct CustomPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopupView()
    }
}
