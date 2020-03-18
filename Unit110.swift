// author Amin Zeina
// version 1.0
// since 2020-03-12
// This program uses enums to list the planets, then calculates distance from a planet chosen by the user.

import Foundation

enum Planets: String, CaseIterable  {
  case MERCURY = "MERCURY"
  case VENUS = "VENUS"
  case EARTH = "EARTH"
  case MARS = "MARS"
  case JUPITER = "JUPITER"
  case SATURN = "SATURN"
  case URANUS = "URANUS"
  case NEPTUNE = "NEPTUNE"
  // Used this link to give me the idea to use switch cases for distance
  // https://stackoverflow.com/questions/24113126/how-to-get-the-name-of-enumeration-value-in-swift
  var distanceFromSun: Double {
    get {
      switch self {
        case .MERCURY:
          return 0.387
        case .VENUS:
          return 0.722
        case .EARTH:
          return 1.0
        case .MARS:
          return 1.52
        case .JUPITER:
          return 5.20
        case .SATURN:
          return 9.58
        case .URANUS:
          return 19.2
        case .NEPTUNE:
          return 30.1
      }
    }
  }
}

// Declare variables
var currentPlanet:Planets? = nil
var travelAgain:String? = nil
var programEnded = false
var inputValid = false
var calcualtedDistanceDict: [String: Double] = [:]

// https://developer.apple.com/documentation/foundation/numberformatter
// Creating Decimal formatter to round AU values
let decimalFormatter = NumberFormatter()
decimalFormatter.numberStyle = .decimal
decimalFormatter.maximumFractionDigits = 3

// Creating Scientific notation formatter to round km values and keep them in scientific
let scientificFormatter = NumberFormatter()
scientificFormatter.numberStyle = .scientific
scientificFormatter.maximumSignificantDigits = 3

print("Here are the planets in our solar system from closest to furthest from the sun: ")

// Print all planets from enum
for planet in Planets.allCases {
  // For capitalization
  // https://developer.apple.com/documentation/foundation/nsstring/1416784-capitalized
  print(planet.rawValue.capitalized)
}

while programEnded == false {

  print("Enter the planet you want to travel to: ")

  // Checking that user entered a planet using raw value to compare strings
  if let userPlanet = Planets(rawValue: readLine()!.uppercased()) {
    // Variable that can be used elsewhere
    currentPlanet = userPlanet
  } else {
    print("That is not a planet.")
    // Back to start of loop
    continue
  }
  
  // Create dictionary to store distance relative to the chosen planet
  for planet in Planets.allCases {
    calcualtedDistanceDict[planet.rawValue] = abs(planet.distanceFromSun - currentPlanet!.distanceFromSun)
  }
  
  // Create new dictionary and sort by values
  // https://stackoverflow.com/questions/24090016/sort-dictionary-by-values-in-swift
  let sortedDistanceDict = calcualtedDistanceDict.sorted { $0.1 < $1.1 }
  
  
  print("Now that you are on", currentPlanet!.rawValue.capitalized + ", here are the planets from closest to furthest:" )
  
  // Print planets in new order of closest to furthest
  for (planet, distance) in sortedDistanceDict {
    if distance != 0 {
      print(planet.capitalized, "is", decimalFormatter.string(from: NSNumber(value: distance))!, "AU away (or", scientificFormatter.string(from: NSNumber(value: distance * 1.496E8))!, "km) away.")
    }
  }
  
  print("Do you want to travel somewhere else? (yes/no): ")
  // Check if user wants to play again
  travelAgain = readLine()!.lowercased()
  
  if travelAgain == "yes" {
    programEnded = false
  } else {
    programEnded = true
  }
} 

print("Program End.")