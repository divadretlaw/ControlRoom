//
//  PreferencesView.swift
//  ControlRoom
//
//  Created by Dave DeLong on 2/16/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import KeyboardShortcuts
import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var preferences: Preferences
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            GroupBox {
                Form {
                    Section(header: Text("Main Window").font(.headline)) {
                        Toggle("Keep window on top", isOn: $preferences.wantsFloatingWindow)
                        Toggle("Show Default simulator", isOn: $preferences.showDefaultSimulator)
                        Toggle("Show booted devices first", isOn: $preferences.showBootedDevicesFirst)
                    }

                    Spacer()
                        .frame(height: 30)

                    Section(header: Text("Menu Bar").font(.headline)) {
                        Toggle("Show icon in menu bar", isOn: $preferences.wantsMenuBarIcon)
                    }

                    Spacer()
                        .frame(height: 30)

                    Section(header: Text("Keyboard shortcuts").font(.headline)) {
                        HStack {
                            Text("Resend last push notification")
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .resendLastPushNotification)
                        }

                        HStack {
                            Text("Restart last selected app")
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .restartLastSelectedApp)
                        }

                        HStack {
                            Text("Reopen last URL")
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .reopenLastURL)
                        }
                    }
                }
                .padding(8)
            }

            Spacer()
                .frame(height: 20)

            HStack {
                Spacer()

                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding(20)
        .frame(minWidth: 400, maxWidth: .infinity)
        .onChange(of: preferences.wantsMenuBarIcon) { newValue in
            guard let appDelegate = NSApp.delegate as? AppDelegate else { return }

            if newValue {
                appDelegate.addMenuBarItem()
            } else {
                appDelegate.removeMenuBarItem()
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
            .environmentObject(Preferences())
    }
}
