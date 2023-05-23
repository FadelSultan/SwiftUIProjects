//
//  NotificationBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel on 20/10/1444 AH.
//

import SwiftUI
import CoreLocation
import UserNotifications


class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        
        
        
        let options:UNAuthorizationOptions = [.alert, .sound , .badge ]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("There is error of request authorization: \(error.localizedDescription)")
            }else {
                print("Success".uppercased())
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was sooo easy!"
        content.sound = .default
        content.badge = 1
        
        
        //Time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //Calendar
//        var component = DateComponents()
//        component.hour = 9
//        component.minute = 40
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        //Location
        
        
        let center = CLLocationCoordinate2D(
            latitude: 37.335400,
            longitude: -122.009201)
        let region = CLCircularRegion(
            center: center,
            radius: 2000.0,
            identifier: "Headquarters")
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

struct NotificationBootcamp: View {
    var body: some View {
        
        VStack(spacing:40) {
            Button("Authorization") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Add Request") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Remove Notification") {
                NotificationManager.instance.removeNotifications()
            }
            
        }.onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        
    }
}

struct NotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBootcamp()
    }
}
