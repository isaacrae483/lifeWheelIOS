//
//  ContentViewModel.swift
//  lifeWheelIOS
//
//  Created by Isaac Rae on 10/22/21.
//

import Foundation
import SwiftUI

extension ContentView {
  enum Label: String, CaseIterable {
    case family = "Family"
    case friends = "Friends"
    case love = "Love"
    case spiritual = "Spiritual"
    case money = "Money"
    case career = "Career"
  }
}

extension ContentView {
  class ViewModel: ObservableObject {
    @Published var familySliderState: Double = 5
    @Published var sliderStates: [Label: Data] = [
      .family: Data(value: 5, color: Color.blue, startAngle: 270, textAngle: 30),
      .friends: Data(value: 5, color: Color.yellow, startAngle: 330, textAngle: 90),
      .love: Data(value: 5, color: Color.red, startAngle: 30, textAngle: 150),
      .spiritual: Data(value: 5, color: Color.purple, startAngle: 90, textAngle: 210),
      .money: Data(value: 5, color: Color.green, startAngle: 150, textAngle: 270),
      .career: Data(value: 5, color: Color.orange, startAngle: 210, textAngle: 330)
    ]

    func getSliderState(for label: Label) -> Double {
      guard let data = sliderStates[label] else { return 50 }
      return data.value
    }

    func setSliderState(for label: Label, to value: Double) {
      guard var data = sliderStates[label] else { return }
      data.value = value
      sliderStates[label] = data
    }

    func getWedgeColor(for label: Label) -> Color {
      guard let data = sliderStates[label] else { return Color.black }
      return data.color
    }

    func getStartAngle(for label: Label) -> Double {
      guard let data = sliderStates[label] else { return 0 }
      return data.startAngle
    }

    func getTextAngle(for label: Label) -> Double {
      guard let data = sliderStates[label] else { return 0 }
      return data.textAngle
    }
  }
}

extension ContentView {
  struct Data {
    var value: Double
    var color: Color
    var startAngle: Double
    var textAngle: Double
  }
}
