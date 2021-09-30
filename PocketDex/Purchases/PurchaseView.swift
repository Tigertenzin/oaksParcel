//
//  TipJarView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Purchases
import SwiftUI
//import StoreKit

struct PurchaseView : View {
    
    enum Source: String {
        case dashboard, turnip, turnipForm, list, musics
    }
    
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject private var subscriptionManager: SubscriptionManager
    
    let source: Source = .list
    
    private var littleTip: Purchases.Package? {
        subscriptionManager.littleTip
    }
    
    private var moderateTip: Purchases.Package? {
        subscriptionManager.moderateTip
    }
    
    private var bigTip: Purchases.Package? {
        subscriptionManager.bigTip
    }
    
//    private var sub: Purchases.Package? {
//        subscriptionManager.monthlySubscription
//    }
//
//    private var yearlySub: Purchases.Package? {
//        subscriptionManager.yearlySubscription
//    }
    
    private func formattedPrice(for package: Purchases.Package) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = littleTip!.product.priceLocale
        return formatter.string(from: package.product.price)!
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                self.content
                    .frame(width: proxy.size.width)
                
                self.paymentButtons
                    .frame(width: proxy.size.width,
                           height: 170)
//                    .background(selectedTheme.themeColor)
                
                
            }
        }
        .navigationBarTitle(Text("Tip Jar"),
                            displayMode: .inline)
    }
    
    private var content: some View {
        VStack {
            HStack(alignment: .center, spacing: 4) {
                Text("Support Development")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 12)
            
            VStack(alignment: .center){
                Image("Professor_Oak(GS)Sprite")
                HStack{
                    Image("128")
                    Image("103")
                    Image("59")
                    Image("3")
                    Image("130")
                }
            }
            
            Text("If you're feeling extra nice, have some extra cash, and would like to support future development, any tip at all helps a ton. ")
                .fixedSize(horizontal: false, vertical: true)
                
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.top)
        .padding(.horizontal)
        .padding(.bottom)
    }
        
    private var paymentButtons: some View {
        VStack {
            littleTip.map{ sub in
                makeBorderedButton(action: {
                                    self.buttonAction(purchase: sub)
                }, label: self.subscriptionManager.subscriptionStatus == .subscribed ?
                    "Thanks!" :
                    "\(formattedPrice(for: sub)) one-time")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
            }
            
            moderateTip.map{ sub in
                makeBorderedButton(action: {
                                    self.buttonAction(purchase: sub)
                }, label: self.subscriptionManager.subscriptionStatus == .subscribed ?
                    "Thanks!" :
                    "\(formattedPrice(for: sub)) one-time")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
            }
            .padding(.top, 16)
            
            bigTip.map{ sub in
                makeBorderedButton(action: {
                                    self.buttonAction(purchase: sub)
                }, label: self.subscriptionManager.subscriptionStatus == .subscribed ?
                    "Thanks!" :
                    "\(formattedPrice(for: sub)) one-time")
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                    .disabled(subscriptionManager.inPaymentProgress)
            }
            .padding(.top, 16)
        }
    }
    
    private func buttonAction(purchase: Purchases.Package) {
        if subscriptionManager.subscriptionStatus == .subscribed {
            print("Test1")
        } else {
            subscriptionManager.purchase(source: self.source.rawValue,
                                         product: purchase)
        }
    }
    
    private func makeBorderedButton(action: @escaping () -> Void, label:
        LocalizedStringKey) -> some View {
        Button(action: action) {
            Text(label)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .frame(maxWidth: .infinity,
                       maxHeight: 60)
                .background(selectedTheme.themeColor)
                .cornerRadius(8)
                .padding(.horizontal)
        }
//            .buttonStyle(PlainRoundedButton()).accentColor(.acTabBarTint).safeHoverEffect()
    }
}
