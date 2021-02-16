//
//  ContentView.swift
//  SwiftUI_Sample
//
//  Created by 服部翼 on 2021/02/03.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var newItem: String = ""
    @State var mockItem: [Items] = MockItem().items
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("予定を追加")
                    .bold()
                    .font(.largeTitle)
                    .padding(.leading)
                
                Spacer()
            }
            
            Spacer(minLength: 30)
            
            HStack {
                TextField("新しい予定を入力してください",text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                Button(action:{
                    if !newItem.isEmpty {
                        let item = Items(item: newItem,
                                         date: Date().stringConvert() )
                        mockItem.insert(item, at: 0)
                        newItem = ""
                    }
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 30)
                            .foregroundColor(.blue)
                        
                        Text("追加")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
            }
            
            List {
                ForEach(mockItem, id: \.self) { item in
                    HStack {
                        Text(item.item)
                            .bold()
                        Spacer()
                        Text(item.date)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                }.onDelete(perform: { indexSet in
                    mockItem.remove(atOffsets: indexSet)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
