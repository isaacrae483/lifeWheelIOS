//
//  ContentView.swift
//  Shared
//
//  Created by Isaac Rae on 10/22/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: ViewModel

  init() {
    self._viewModel = .init(wrappedValue: .init())
  }

  var body: some View {
    wheel
  }
}

extension ContentView {
  var wheel: some View {
    let size: CGFloat = 200
    let arcLength: Double = 60
    let animationDuration: Double = 1.0
    return VStack {
      Text("Some Company Life Wheel")
      ZStack {

        ForEach(Label.allCases, id: \.self) { label in
          CurvedText(text: label.rawValue, radius: max(viewModel.getSliderState(for: label), 5) * 10 + 20).zIndex(1.0).rotationEffect(Angle(degrees: viewModel.getTextAngle(for: label)))
        }

//        CurvedText(text: "Friends", radius: 150).zIndex(1.0).rotationEffect(Angle(degrees: 90))
//        CurvedText(text: "Love", radius: 150).zIndex(1.0).rotationEffect(Angle(degrees: 150))
//        CurvedText(text: "Spiritual", radius: 150).zIndex(1.0).rotationEffect(Angle(degrees: 210))
//        CurvedText(text: "Career", radius: 150).zIndex(1.0).rotationEffect(Angle(degrees: 270))
//        CurvedText(text: "Money", radius: 150).zIndex(1.0).rotationEffect(Angle(degrees: 330))

        ForEach(Label.allCases, id: \.self) { label in
          Wedge(radius: viewModel.getSliderState(for: label) * 10, startAngle: viewModel.getStartAngle(for: label), angleChange: arcLength)
          .fill(viewModel.getWedgeColor(for: label))
//          .frame(width: size, height: size)
          .animation(.easeInOut(duration: animationDuration))

          Wedge(radius: viewModel.getSliderState(for: label) * 10, startAngle: viewModel.getStartAngle(for: label), angleChange: arcLength)
          .stroke(Color.black, lineWidth: 1)
//          .frame(width: size, height: size)
          .animation(.easeInOut(duration: animationDuration))

        }
      }
      .frame(width: size, height: size)
      .padding(.vertical)
      ForEach(Label.allCases, id: \.self) { label in
        slider(for: label)
      }

      Text("Link to your website").foregroundColor(.blue)
    }
  }
}

extension ContentView {
  func slider(for label: Label) -> some View {
    HStack {
      Text(label.rawValue + ":")
      Slider(value: sliderState(for: label), in: 1...10)
      .padding(.horizontal)
    }
    .padding(.horizontal)
  }

  func sliderState(for label: Label) -> Binding<Double> {
    Binding<Double>(
    get: { viewModel.getSliderState(for: label) },
    set: { viewModel.setSliderState(for: label, to: $0) }
    )
  }
}

struct Wedge: Shape {
  var radius: Double
  var startAngle: Double
  var angleChange: Double

  func path(in rect: CGRect) -> Path {
    var path = Path()

    let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)

    path.move(to: center)
    path.addArc(center: center, radius: radius, startAngle: .degrees(startAngle), endAngle: .degrees(startAngle + angleChange), clockwise: false)
    path.addLine(to: center)

    return path
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
