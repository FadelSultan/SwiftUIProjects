//
//  HapticsBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel on 19/10/1444 AH.
//

import SwiftUI

class HapticsManager {
    static let instance = HapticsManager()
    
    func notification(type:UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact() {
        
    }
    
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack {
            Button("Success") {
                HapticsManager.instance.notification(type: .success)
            }
        }
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
