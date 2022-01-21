// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetItemsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getItems {
      allItems {
        __typename
        nameFr
        totalPoste
        unit {
          __typename
          name
          quantity
        }
        unitStr
      }
    }
    """

  public let operationName: String = "getItems"

  public let operationIdentifier: String? = "015f7adfbb0c62a40aade84106e5a08ccc65257948f9e09127a1c7eb757578df"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allItems", type: .list(.object(AllItem.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allItems: [AllItem?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allItems": allItems.flatMap { (value: [AllItem?]) -> [ResultMap?] in value.map { (value: AllItem?) -> ResultMap? in value.flatMap { (value: AllItem) -> ResultMap in value.resultMap } } }])
    }

    public var allItems: [AllItem?]? {
      get {
        return (resultMap["allItems"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllItem?] in value.map { (value: ResultMap?) -> AllItem? in value.flatMap { (value: ResultMap) -> AllItem in AllItem(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllItem?]) -> [ResultMap?] in value.map { (value: AllItem?) -> ResultMap? in value.flatMap { (value: AllItem) -> ResultMap in value.resultMap } } }, forKey: "allItems")
      }
    }

    public struct AllItem: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ItemsType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nameFr", type: .scalar(String.self)),
          GraphQLField("totalPoste", type: .scalar(Double.self)),
          GraphQLField("unit", type: .object(Unit.selections)),
          GraphQLField("unitStr", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nameFr: String? = nil, totalPoste: Double? = nil, unit: Unit? = nil, unitStr: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ItemsType", "nameFr": nameFr, "totalPoste": totalPoste, "unit": unit.flatMap { (value: Unit) -> ResultMap in value.resultMap }, "unitStr": unitStr])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var nameFr: String? {
        get {
          return resultMap["nameFr"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "nameFr")
        }
      }

      public var totalPoste: Double? {
        get {
          return resultMap["totalPoste"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "totalPoste")
        }
      }

      public var unit: Unit? {
        get {
          return (resultMap["unit"] as? ResultMap).flatMap { Unit(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "unit")
        }
      }

      public var unitStr: String? {
        get {
          return resultMap["unitStr"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "unitStr")
        }
      }

      public struct Unit: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UnitsType"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("quantity", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, quantity: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UnitsType", "name": name, "quantity": quantity])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var quantity: String? {
          get {
            return resultMap["quantity"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "quantity")
          }
        }
      }
    }
  }
}
