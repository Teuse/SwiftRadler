import SwiftUI

public protocol Titled {
    var title: String { get }
}

public struct OptionsPicker<T: CaseIterable & RawRepresentable & Titled & Equatable>: View where T.RawValue == Int {
   @Environment(\.colorScheme) var colorScheme
   @Binding var currentValue: T
   
   public var body: some View {
      VStack {
         HStack(spacing: 0) {
            ForEach(0..<T.allCases.count, id: \.self) { index in
               let mode = Array(T.allCases)[index]
               let makeDivider = index < T.allCases.count - 1
               Button {
                  currentValue = mode
               } label: {
                  VStack(spacing: 7) {
                     Text(mode.title)
                        .foregroundStyle(.black)
                  }
                  .frame(maxWidth: .infinity)
                  .frame(height: 30)
                  .padding(5)
                  .contentShape(Rectangle())
               }
               
               if makeDivider {
                  if !(index == currentValue.rawValue || (index + 1) == currentValue.rawValue )  {
                     Divider()
                        .frame(width: 0, height: 30)
                  }
               }
            }
         }
         .frame(maxWidth: .infinity)
         .padding(.horizontal, 2)
         .background(selectionBackground())
         .padding(4)
         .background(toggleBackground())
         .animation(.smooth, value: currentValue)
      }
   }
   
   private func selectionBackground() -> some View {
      GeometryReader { proxy in
         let caseCount = T.allCases.count
         grayDynamic.opacity(0.3)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: proxy.size.width / CGFloat(caseCount))
            .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(currentValue.rawValue))
      }
   }
   
   private func toggleBackground() -> some View {
      Color(.white)
         .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
         .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))
   }
   
   private var grayDynamic  = Color(UIColor(dynamicProvider: {(traitCollection) -> UIColor in
      if traitCollection.userInterfaceStyle == .dark {
         return UIColor(Color(white: 0.227))
      }
      return UIColor(Color(white: 0.95))
   }))
}

//#Preview {
//   enum Dummy: Int, CaseIterable, Titled {
//      case a, b
//      var title: String { return "dummuy" }
//   }
//   OptionsPicker<Dummy>(currentValue: .constant(Dummy.a))
//      .padding()
//}
