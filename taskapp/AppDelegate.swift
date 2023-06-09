//
//  AppDelegate.swift
//  taskapp
//
//  Created by PC-SYSKAI556 on 2023/03/16.
//

import UIKit
import UserNotifications
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // ユーザに通知の許可を求める
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization
        }
        center.delegate = self
        
        // マイグレーション処理
        migration()
        //let realm = try! Realm()

        return true
    }
    // Realmマイグレーション処理
    func migration() {
      // 次のバージョン（現バージョンが０なので、１をセット）
        let nextSchemaVersion = 1

      // マイグレーション設定
      let config = Realm.Configuration(
        schemaVersion: UInt64(nextSchemaVersion),
        migrationBlock: { migration, oldSchemaVersion in
          if (oldSchemaVersion < nextSchemaVersion) {
          }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    // MARK: UISceneSession Lifecycle
    
    // アプリがフォアグラウンドの時に通知を受け取ると呼ばれるメソッド --- ここから ---
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

