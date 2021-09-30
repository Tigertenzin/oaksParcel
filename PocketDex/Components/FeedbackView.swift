//
//  FeedbackView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import UIKit
import MessageUI

struct FeedbackView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    @EnvironmentObject var selectedTheme: UserTheme
    
     var body: some View {
         Button(action: {
             self.isShowingMailView.toggle()
         }) {
             HStack{
                 Image(systemName: "exclamationmark.bubble")
                    .foregroundColor(selectedTheme.themeColor)
                 Text("Feedback & Support")
             }
         }
         .disabled(!MFMailComposeViewController.canSendMail())
         .sheet(isPresented: $isShowingMailView) {
             MailView(result: self.$result)
         }
     }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}


struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(["tenzin.thomas@gmail.com"])
        vc.setSubject("Oak's Parcel Feedback")
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
