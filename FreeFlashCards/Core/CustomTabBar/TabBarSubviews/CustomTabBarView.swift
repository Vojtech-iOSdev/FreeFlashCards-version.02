//
//  CustomTabBarView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                singleTabCell(tab: tab)
                    .onTapGesture {
                        selection = tab
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .onChange(of: selection, perform: { value in
            withAnimation(.easeInOut) {
                localSelection = value
            }
        })
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .home, .practice, .profile
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}

extension CustomTabBarView {
    
    private func singleTabCell(tab: TabBarItem) -> some View {
        VStack(spacing: 0) {
            Image(systemName: tab.iconName)
                .font(.title3)
            Spacer()
            Text(tab.title)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? Color.indigo : Color.gray)
        .frame(height: 25)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.indigo.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
}
