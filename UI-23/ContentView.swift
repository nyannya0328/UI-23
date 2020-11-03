//
//  ContentView.swift
//  UI-23
//
//  Created by にゃんにゃん丸 on 2020/11/03.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @StateObject var delegate = notificationdelegate()
    var body: some View{
        
        Button(action: {createnofication()}, label: {
            
            VStack{
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 10, x: 10, y: 10)
            
            }
            
            
            
        })
        .onAppear(perform: {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert,.badge,.sound]) { (_, _) in
                    
                }
            UNUserNotificationCenter.current().delegate = delegate
        
            
            
        })
        
        .alert(isPresented: $delegate.alert, content: {
            Alert(title: Text("github"), message: Text("23"), dismissButton: .destructive(Text("test")))
        })
            
            
            
        
        
        
    }
    
    func createnofication(){
        
        let content = UNMutableNotificationContent()
        content.title = "テスト"
        content.subtitle = "試験"
        content.categoryIdentifier = "Action"
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let requset = UNNotificationRequest(identifier: "test", content: content, trigger: triger)
        
        let close = UNNotificationAction(identifier: "Close", title: "close", options: .destructive)
        let reply = UNNotificationAction(identifier: "REPLY", title: "reply", options: .foreground)
        
        
        let category = UNNotificationCategory(identifier: "Action", actions: [close,reply], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        
        
        UNUserNotificationCenter.current().add(requset,withCompletionHandler: nil)
        
        
    }
    
    
}

class notificationdelegate : NSObject,ObservableObject,UNUserNotificationCenterDelegate{
    
    @Published var alert = false
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge,.banner,.sound])
        
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        
        if response.actionIdentifier == "REPLY"{
            
            
            
            
            print("Error")
            
            self.alert.toggle()
            
        }
        completionHandler()
        
    }
   
    
    
}



