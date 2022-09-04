//
//  Home.swift
//  NumberPicker
//
//  Created by 邱允聰 on 1/9/2022.
//

import SwiftUI
import UserNotifications

struct Home: View {
    
    
    @EnvironmentObject var numPick: NumPick
    @AppStorage("chooseNumber") private var chooseNumber = 1
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Namespace private var animation
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading,spacing: 20){
                    Today
                    allowNotice
                }
                changeMode
            }
            NumPick
            notification
        }
        .overlay{
            if(numPick.showAlert){
                alert
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            numPick.showAlert = false
                        }
                    }
                    
            }
        }
        .animation(.linear, value: numPick.showAlert)
    }
    
    var Today: some View{
        Text(numPick.dateFormat())
            .font(.title2)
            .padding(.top)
            .padding(.horizontal)
    }
    
    var allowNotice: some View{
        Button(action:{
            numPick.allowNotice()
        }){
            Text("允許提醒")
        }
        .padding(.horizontal)
    }
    
    
    var notification: some View{
        Button(action:{
            withAnimation{
                numPick.setNotice(chooseNumber)
            }
        }){
            Text("稍後提醒")
                .font(.title3)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 30)
                    .fill(.orange)
                    .padding(.horizontal)
                )
        }
        .padding()
    }
    
    var changeMode: some View{
        VStack(spacing:5){
            Text("外觀顏色")
                .font(.callout)
                .foregroundColor(.secondary)
            Picker("模式",selection: $isDarkMode){
                Text(isDarkMode ? "淺色" : " ")
                    .tag(false)
                Text(isDarkMode ? " " : "深色")
                    .tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())}
        .frame(width: 100)
        .padding(.top)
        .animation(.easeInOut, value: isDarkMode)
    }
    
    var alert: some View{
        Text("45分鐘後通知")
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray5)))
            .padding(.bottom, 320)
        
    }
    
    @ViewBuilder
    var NumPick: some View{
        VStack(alignment: .center){
            Text("存放號碼")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(isDarkMode ? .black : .white)
                        .shadow(color: .secondary, radius: 0.5, y: 1)
                )
            let columns : [GridItem]  = Array(repeating: .init(.flexible()), count: 4)
            LazyVGrid(columns: columns,spacing: 20){
                ForEach((numPick.number), id: \.self){ num in
                    Text("\(num)")
                        .font(.title)
                        .padding()
                        .frame(width: 70)
                        .onTapGesture {
                            withAnimation{
                                chooseNumber = num
                            }
                        }
                        .background{
                            if chooseNumber == num{
                                Circle()
                                    .foregroundColor(chooseNumber == num ? .orange : isDarkMode ? .black : .white)
                                    .matchedGeometryEffect(id: "circle", in: animation)
                            }else{
                                Circle()
                                    .foregroundColor(chooseNumber == num ? .orange : isDarkMode ? .black : .white)
                                    .shadow(color: .secondary, radius: 0.5, x: 0.5, y: 1)
                            }
                        }
                    
                }
            }
        }
        .padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(NumPick())
        
    }
}
