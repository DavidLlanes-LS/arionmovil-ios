//
//  Banner.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 11/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import SwiftUI
struct BannerData {
        var title: String
        var detail: String
        var type: BannerType
    }

    enum BannerType {
        case info
        case warning
        case success
        case error

        var tintColor: Color {
            switch self {
            case .info:
                return Color("toast")
            case .success:
                return Color.green
            case .warning:
                return Color.yellow
            case .error:
                return Color.red
            }
        }
    }

struct BannerModifier: ViewModifier {

    @Binding var data: BannerData
    @Binding var show: Bool


    @State var task: DispatchWorkItem?

    func body(content: Content) -> some View {
        ZStack {
            if show {
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 2) {
                            Text(data.title)
                                .bold().frame(alignment:.center)
//                            Text(data.detail)
//                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }.frame(alignment:.center)
                        Spacer()
                    }
                    .foregroundColor(Color("background"))
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    .shadow(radius: 20)
                    Spacer()
                }
                .padding()
                .animation(.easeInOut(duration: 1.2))
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity)).zIndex(5)

                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear {
                    self.task = DispatchWorkItem {
                        withAnimation {
                            self.show = false
                        }
                    }
                    // Auto dismiss after 5 seconds, and cancel the task if view disappear before the auto dismiss
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.task!)
                }
                .onDisappear {
                    self.task?.cancel()
                }
            }
            content
        }
    }
}

extension View {
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}
