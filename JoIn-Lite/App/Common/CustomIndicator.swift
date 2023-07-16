//
//  CustomIndicator.swift
//  CompleteApp1
//
//  Created by Yusuf Ali Cezik on 16.06.2023.
//

import SwiftUI
import CoreUtils

struct CustomIndicator: View {
    let totalIndex: Int
    let selectedIndex: Int
    
    @Namespace private var animation
    
    var body: some View {
        HStack {
            ForEach(0..<totalIndex, id: \.self) { index in
                if selectedIndex == index {
                    Rectangle().fill(.gray.opacity(0.3)).frame(height: 5).clipShape(RoundedRectangle(cornerRadius: 3)).overlay {
                        Rectangle().fill(.appPrimary).frame(height: 5).clipShape(RoundedRectangle(cornerRadius: 3)).matchedGeometryEffect(id: "IndicatorAnimationId", in: animation)
                    }
                } else {
                    Rectangle().fill(.gray.opacity(0.3)).frame(height: 5).clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }
        }.animation(.spring(), value: UUID())
    }
}

struct CustomIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomIndicator(totalIndex: 3, selectedIndex: .zero)
    }
}
