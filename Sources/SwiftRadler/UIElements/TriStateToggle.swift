import SwiftUI

public struct TriStateToggle: View {
   @Binding var value: Bool?
   let onColor: Color
   let offColor: Color
   
   public init(_ value: Binding<Bool?>, onColor: Color = .green, offColor: Color = .gray) {
      self._value = value
      self.onColor = onColor
      self.offColor = offColor
   }
   
   // Visuals
   private var trackColor: Color {
      if value == nil { return Color.gray.opacity(0.25) }
      return (value == true) ? onColor : offColor
   }
   
   private var trackBorderColor: Color {
      if value == nil { return Color.gray.opacity(0.4) }
      return (value == true) ? Color.green.opacity(0.8) : Color.gray.opacity(0.6)
   }
   
   private func knobX(width: CGFloat, knobSize: CGFloat) -> CGFloat {
      // Compute left, center, right positions within the track
      let padding: CGFloat = (width - knobSize) / 2 // distance from left to center minus knob radius adjustments
      switch value {
      case .some(true):
         return width - knobSize // right
      case .some(false):
         return 0 // left
      case .none:
         return padding // center
      }
   }
   
   private var accessibilityValue: Text {
      if let val = value {
         return Text(val ? "On" : "Off")
      } else {
         return Text("Indeterminate")
      }
   }
   
   public var body: some View {
      HStack(spacing: 12) {
         let height: CGFloat = 32
         
         GeometryReader { geo in
            let width: CGFloat = max(geo.size.width, 64)
            let knobSize: CGFloat = 30
            let corner: CGFloat = height / 2
            
            ZStack(alignment: .leading) {
               // Track
               RoundedRectangle(cornerRadius: corner)
                  .fill(trackColor)
                  .frame(width: width, height: height)
                  .overlay(
                     RoundedRectangle(cornerRadius: corner)
                        .strokeBorder(trackBorderColor, lineWidth: 1)
                  )
               
               // Knob positions: left (off), center (nil), right (on)
               Circle()
                  .fill(.white)
                  .frame(width: knobSize, height: knobSize)
                  .shadow(radius: 0.5, y: 0.5)
                  .offset(x: knobX(width: width, knobSize: knobSize))
                  .animation(.easeInOut(duration: 0.15), value: value)
            }
            .frame(height: height)
            .contentShape(Rectangle())
            .onTapGesture { location in
               let localX = location.x
               let half = width / 2
               if value == nil {
                  // First interaction decides based on left/right
                  value = (localX >= half) ? true : false
               } else {
                  // Subsequent interactions toggle like normal
                  value?.toggle()
               }
            }
         }
         .frame(width: 72, height: height) // make it slightly wider than default
      }
      .accessibilityElement(children: .combine)
      .accessibilityValue(accessibilityValue)
   }
}

#Preview("TriStateToggle") {
   struct PreviewWrapper: View {
      @State var isOn1: Bool? = nil
      @State var isOn2: Bool? = nil
      @State var isOn3: Bool? = nil
      
      var body: some View {
         VStack {
            TriStateToggle($isOn1)
            TriStateToggle($isOn2)
            TriStateToggle($isOn3)
            Button("Reset All") {
               isOn1 = nil
               isOn2 = nil
               isOn3 = nil
            }
         }
      }
   }
   return PreviewWrapper()
}
