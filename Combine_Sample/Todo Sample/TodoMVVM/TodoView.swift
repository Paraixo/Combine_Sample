//
//  TodoView.swift
//  SwiftUI_Sample
//
//  Created by 服部翼 on 2021/02/06.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject private var vm = ViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Text("予定を追加")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                
                Spacer()
            }
            
            HStack {
                TextField("入力",text: $vm.bindText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                
                Button(action: {
                    vm.addBtnTaped.send()
                    vm.bindText = ""
                }, label: {
                    Text("追加")
                        .foregroundColor(.black)
                })
            }
            
            List {
                ForEach(vm.items, id: \.self) { item in
                    Text(item)
                }
            }
            
            Spacer()
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoView()
                
        }
    }
}
