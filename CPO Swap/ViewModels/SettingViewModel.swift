//
//  SettingViewModel.swift
//  CPO Swap
//
//  Created by Jaden Lee on 2023-09-07.
//

import Foundation
import Firebase
import UserNotifications

@MainActor final
class SettingViewModel : ObservableObject{
    @Published var hasPermission = false
        
        func getAuthStatus() async {
            let status = await UNUserNotificationCenter.current().notificationSettings()
            switch status.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                self.hasPermission = true
            default:
                self.hasPermission = false
            }
        }
        
        func requestNotificationPermission() async {
            do {
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                self.hasPermission = try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions)

                 UIApplication.shared.registerForRemoteNotifications()
            } catch {
                print(error.localizedDescription)
            }
        }
    
    
}
