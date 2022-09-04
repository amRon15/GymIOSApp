//
//  NumPickModal.swift
//  NumberPicker
//
//  Created by 邱允聰 on 1/9/2022.
//

import SwiftUI

class NumPick: ObservableObject{
    @Published var number = 1...16
    @Published var time = 2700
    @Published var showAlert = false
//    func setTime(_ setTime: Int){
//        time = setTime * 60
//    }
    
    func allowNotice(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]){ succes, err in
            if(succes){
                print("OK")
            }else if let err = err{
                print(err.localizedDescription)
            }
        }
    }
    
    func setNotice(_ chooseNum: Int){
        let content = UNMutableNotificationContent()
        content.title = "健身室月票號碼"
        content.subtitle = String(chooseNum)
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2700, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        showAlert = true
    }
    
    func dateFormat()->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "zh_TW")
        format.timeStyle = .none
        format.dateStyle = .full
        return format.string(from: Date())
    }
}
