// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GraphCarbon namespace
public enum GraphCarbon {
  public final class GetCategoriesQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getCategories($cursor: String, $first: Int) {
        categories(after: $cursor, first: $first) {
          __typename
          ...categoryDetails
        }
      }
      """

    public let operationName: String = "getCategories"

    public let operationIdentifier: String? = "6b9a3470480163ec5f11ad7f12412e7d7073ab144594ef9b2007712e2e80f8b3"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + CategoryDetails.fragmentDefinition)
      return document
    }

    public var cursor: String?
    public var first: Int?

    public init(cursor: String? = nil, first: Int? = nil) {
      self.cursor = cursor
      self.first = first
    }

    public var variables: GraphQLMap? {
      return ["cursor": cursor, "first": first]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("categories", arguments: ["after": GraphQLVariable("cursor"), "first": GraphQLVariable("first")], type: .object(Category.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(categories: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
      }

      public var categories: Category? {
        get {
          return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "categories")
        }
      }

      public struct Category: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CategoryNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "CategoryNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var categoryDetails: CategoryDetails {
            get {
              return CategoryDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["CategoryNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "CategoryNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["CategoryNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("parent", type: .object(Parent.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, name: String? = nil, parent: Parent? = nil) {
              self.init(unsafeResultMap: ["__typename": "CategoryNode", "uuid": uuid, "name": name, "parent": parent.flatMap { (value: Parent) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var parent: Parent? {
              get {
                return (resultMap["parent"] as? ResultMap).flatMap { Parent(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "parent")
              }
            }

            public struct Parent: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["CategoryNode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String? = nil, uuid: String) {
                self.init(unsafeResultMap: ["__typename": "CategoryNode", "name": name, "uuid": uuid])
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

              public var uuid: String {
                get {
                  return resultMap["uuid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "uuid")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public final class GetParentCategoriesQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getParentCategories {
        categories(parent_Name_Isnull: true) {
          __typename
          ...categoryDetails
        }
      }
      """

    public let operationName: String = "getParentCategories"

    public let operationIdentifier: String? = "b6a3f89635099c043eedf5105259fea39de5e35c2ed8b6fa5291b349d2d7bae1"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + CategoryDetails.fragmentDefinition)
      return document
    }

    public init() {
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("categories", arguments: ["parent_Name_Isnull": true], type: .object(Category.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(categories: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
      }

      public var categories: Category? {
        get {
          return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "categories")
        }
      }

      public struct Category: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CategoryNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "CategoryNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var categoryDetails: CategoryDetails {
            get {
              return CategoryDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["CategoryNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "CategoryNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["CategoryNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("parent", type: .object(Parent.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, name: String? = nil, parent: Parent? = nil) {
              self.init(unsafeResultMap: ["__typename": "CategoryNode", "uuid": uuid, "name": name, "parent": parent.flatMap { (value: Parent) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var parent: Parent? {
              get {
                return (resultMap["parent"] as? ResultMap).flatMap { Parent(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "parent")
              }
            }

            public struct Parent: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["CategoryNode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String? = nil, uuid: String) {
                self.init(unsafeResultMap: ["__typename": "CategoryNode", "name": name, "uuid": uuid])
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

              public var uuid: String {
                get {
                  return resultMap["uuid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "uuid")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public final class GetCategoriesForParentQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getCategoriesForParent($parentName: String!, $cursor: String, $first: Int!) {
        categories(parent_Name: $parentName, after: $cursor, first: $first) {
          __typename
          ...categoryDetails
        }
      }
      """

    public let operationName: String = "getCategoriesForParent"

    public let operationIdentifier: String? = "12419fbbd07343730c52af16f325cf7f2107f365eb7cdc05defa8548085f2b87"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + CategoryDetails.fragmentDefinition)
      return document
    }

    public var parentName: String
    public var cursor: String?
    public var first: Int

    public init(parentName: String, cursor: String? = nil, first: Int) {
      self.parentName = parentName
      self.cursor = cursor
      self.first = first
    }

    public var variables: GraphQLMap? {
      return ["parentName": parentName, "cursor": cursor, "first": first]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("categories", arguments: ["parent_Name": GraphQLVariable("parentName"), "after": GraphQLVariable("cursor"), "first": GraphQLVariable("first")], type: .object(Category.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(categories: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
      }

      public var categories: Category? {
        get {
          return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "categories")
        }
      }

      public struct Category: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CategoryNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "CategoryNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var categoryDetails: CategoryDetails {
            get {
              return CategoryDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["CategoryNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "CategoryNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["CategoryNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("parent", type: .object(Parent.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, name: String? = nil, parent: Parent? = nil) {
              self.init(unsafeResultMap: ["__typename": "CategoryNode", "uuid": uuid, "name": name, "parent": parent.flatMap { (value: Parent) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var parent: Parent? {
              get {
                return (resultMap["parent"] as? ResultMap).flatMap { Parent(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "parent")
              }
            }

            public struct Parent: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["CategoryNode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String? = nil, uuid: String) {
                self.init(unsafeResultMap: ["__typename": "CategoryNode", "name": name, "uuid": uuid])
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

              public var uuid: String {
                get {
                  return resultMap["uuid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "uuid")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public final class GetItemsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getItems($cursor: String, $first: Int) {
        items(after: $cursor, first: $first) {
          __typename
          ...itemDetails
        }
      }
      """

    public let operationName: String = "getItems"

    public let operationIdentifier: String? = "c7e9411654e7de3e1273d5f297ede6a9db3bda0717976d72245447131e9610f0"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ItemDetails.fragmentDefinition)
      document.append("\n" + UnitDetails.fragmentDefinition)
      return document
    }

    public var cursor: String?
    public var first: Int?

    public init(cursor: String? = nil, first: Int? = nil) {
      self.cursor = cursor
      self.first = first
    }

    public var variables: GraphQLMap? {
      return ["cursor": cursor, "first": first]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("items", arguments: ["after": GraphQLVariable("cursor"), "first": GraphQLVariable("first")], type: .object(Item.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: Item? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "items": items.flatMap { (value: Item) -> ResultMap in value.resultMap }])
      }

      public var items: Item? {
        get {
          return (resultMap["items"] as? ResultMap).flatMap { Item(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ItemNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "ItemNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var itemDetails: ItemDetails {
            get {
              return ItemDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ItemNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "ItemNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ItemNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("nameFr", type: .scalar(String.self)),
                GraphQLField("totalPoste", type: .scalar(Double.self)),
                GraphQLField("unitStr", type: .scalar(String.self)),
                GraphQLField("categoryStr", type: .scalar(String.self)),
                GraphQLField("confidence", type: .scalar(Int.self)),
                GraphQLField("tagFr", type: .scalar(String.self)),
                GraphQLField("attributeFr", type: .scalar(String.self)),
                GraphQLField("unit", type: .object(Unit.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, nameFr: String? = nil, totalPoste: Double? = nil, unitStr: String? = nil, categoryStr: String? = nil, confidence: Int? = nil, tagFr: String? = nil, attributeFr: String? = nil, unit: Unit? = nil) {
              self.init(unsafeResultMap: ["__typename": "ItemNode", "uuid": uuid, "nameFr": nameFr, "totalPoste": totalPoste, "unitStr": unitStr, "categoryStr": categoryStr, "confidence": confidence, "tagFr": tagFr, "attributeFr": attributeFr, "unit": unit.flatMap { (value: Unit) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var unitStr: String? {
              get {
                return resultMap["unitStr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "unitStr")
              }
            }

            public var categoryStr: String? {
              get {
                return resultMap["categoryStr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "categoryStr")
              }
            }

            public var confidence: Int? {
              get {
                return resultMap["confidence"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "confidence")
              }
            }

            public var tagFr: String? {
              get {
                return resultMap["tagFr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "tagFr")
              }
            }

            public var attributeFr: String? {
              get {
                return resultMap["attributeFr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "attributeFr")
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

            public struct Unit: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["UnitNode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("quantity", type: .scalar(String.self)),
                  GraphQLField("numerator", type: .scalar(String.self)),
                  GraphQLField("denominator", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(uuid: String, name: String? = nil, quantity: String? = nil, numerator: String? = nil, denominator: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "UnitNode", "uuid": uuid, "name": name, "quantity": quantity, "numerator": numerator, "denominator": denominator])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var uuid: String {
                get {
                  return resultMap["uuid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "uuid")
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

              public var numerator: String? {
                get {
                  return resultMap["numerator"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "numerator")
                }
              }

              public var denominator: String? {
                get {
                  return resultMap["denominator"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "denominator")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var unitDetails: UnitDetails {
                  get {
                    return UnitDetails(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public final class GetItemsByCategoryQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getItemsByCategory($categoryName: String!, $cursor: String, $first: Int) {
        items(itemsByCategoryName: $categoryName, after: $cursor, first: $first) {
          __typename
          ...itemDetails
        }
      }
      """

    public let operationName: String = "getItemsByCategory"

    public let operationIdentifier: String? = "1c1389685780411e2479d24640262a9cc0f86e390f480b3364886bfa130a50e0"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ItemDetails.fragmentDefinition)
      document.append("\n" + UnitDetails.fragmentDefinition)
      return document
    }

    public var categoryName: String
    public var cursor: String?
    public var first: Int?

    public init(categoryName: String, cursor: String? = nil, first: Int? = nil) {
      self.categoryName = categoryName
      self.cursor = cursor
      self.first = first
    }

    public var variables: GraphQLMap? {
      return ["categoryName": categoryName, "cursor": cursor, "first": first]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("items", arguments: ["itemsByCategoryName": GraphQLVariable("categoryName"), "after": GraphQLVariable("cursor"), "first": GraphQLVariable("first")], type: .object(Item.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: Item? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "items": items.flatMap { (value: Item) -> ResultMap in value.resultMap }])
      }

      public var items: Item? {
        get {
          return (resultMap["items"] as? ResultMap).flatMap { Item(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ItemNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "ItemNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var itemDetails: ItemDetails {
            get {
              return ItemDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ItemNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "ItemNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ItemNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("nameFr", type: .scalar(String.self)),
                GraphQLField("totalPoste", type: .scalar(Double.self)),
                GraphQLField("unitStr", type: .scalar(String.self)),
                GraphQLField("categoryStr", type: .scalar(String.self)),
                GraphQLField("confidence", type: .scalar(Int.self)),
                GraphQLField("tagFr", type: .scalar(String.self)),
                GraphQLField("attributeFr", type: .scalar(String.self)),
                GraphQLField("unit", type: .object(Unit.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, nameFr: String? = nil, totalPoste: Double? = nil, unitStr: String? = nil, categoryStr: String? = nil, confidence: Int? = nil, tagFr: String? = nil, attributeFr: String? = nil, unit: Unit? = nil) {
              self.init(unsafeResultMap: ["__typename": "ItemNode", "uuid": uuid, "nameFr": nameFr, "totalPoste": totalPoste, "unitStr": unitStr, "categoryStr": categoryStr, "confidence": confidence, "tagFr": tagFr, "attributeFr": attributeFr, "unit": unit.flatMap { (value: Unit) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var unitStr: String? {
              get {
                return resultMap["unitStr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "unitStr")
              }
            }

            public var categoryStr: String? {
              get {
                return resultMap["categoryStr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "categoryStr")
              }
            }

            public var confidence: Int? {
              get {
                return resultMap["confidence"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "confidence")
              }
            }

            public var tagFr: String? {
              get {
                return resultMap["tagFr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "tagFr")
              }
            }

            public var attributeFr: String? {
              get {
                return resultMap["attributeFr"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "attributeFr")
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

            public struct Unit: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["UnitNode"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("quantity", type: .scalar(String.self)),
                  GraphQLField("numerator", type: .scalar(String.self)),
                  GraphQLField("denominator", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(uuid: String, name: String? = nil, quantity: String? = nil, numerator: String? = nil, denominator: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "UnitNode", "uuid": uuid, "name": name, "quantity": quantity, "numerator": numerator, "denominator": denominator])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var uuid: String {
                get {
                  return resultMap["uuid"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "uuid")
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

              public var numerator: String? {
                get {
                  return resultMap["numerator"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "numerator")
                }
              }

              public var denominator: String? {
                get {
                  return resultMap["denominator"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "denominator")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var unitDetails: UnitDetails {
                  get {
                    return UnitDetails(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public final class GetUnitsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getUnits($cursor: String, $first: Int) {
        units(after: $cursor, first: $first) {
          __typename
          edges {
            __typename
            node {
              __typename
              ...unitDetails
            }
            cursor
          }
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
        }
      }
      """

    public let operationName: String = "getUnits"

    public let operationIdentifier: String? = "15ce07e93055b8ec4c9bacf5b5662e67ab8dfeaa3cc70bf2f5f497df673be9f8"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + UnitDetails.fragmentDefinition)
      return document
    }

    public var cursor: String?
    public var first: Int?

    public init(cursor: String? = nil, first: Int? = nil) {
      self.cursor = cursor
      self.first = first
    }

    public var variables: GraphQLMap? {
      return ["cursor": cursor, "first": first]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("units", arguments: ["after": GraphQLVariable("cursor"), "first": GraphQLVariable("first")], type: .object(Unit.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(units: Unit? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "units": units.flatMap { (value: Unit) -> ResultMap in value.resultMap }])
      }

      public var units: Unit? {
        get {
          return (resultMap["units"] as? ResultMap).flatMap { Unit(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "units")
        }
      }

      public struct Unit: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UnitNodeConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?], pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "UnitNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Contains the nodes in this connection.
        public var edges: [Edge?] {
          get {
            return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
          }
        }

        /// Pagination data for this connection.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["UnitNodeEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "UnitNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["UnitNode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("quantity", type: .scalar(String.self)),
                GraphQLField("numerator", type: .scalar(String.self)),
                GraphQLField("denominator", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(uuid: String, name: String? = nil, quantity: String? = nil, numerator: String? = nil, denominator: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UnitNode", "uuid": uuid, "name": name, "quantity": quantity, "numerator": numerator, "denominator": denominator])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var uuid: String {
              get {
                return resultMap["uuid"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "uuid")
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

            public var numerator: String? {
              get {
                return resultMap["numerator"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "numerator")
              }
            }

            public var denominator: String? {
              get {
                return resultMap["denominator"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "denominator")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var unitDetails: UnitDetails {
                get {
                  return UnitDetails(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }

  public struct CategoryDetails: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment categoryDetails on CategoryNodeConnection {
        __typename
        edges {
          __typename
          node {
            __typename
            uuid
            name
            parent {
              __typename
              name
              uuid
            }
          }
          cursor
        }
        pageInfo {
          __typename
          endCursor
          hasNextPage
        }
      }
      """

    public static let possibleTypes: [String] = ["CategoryNodeConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(edges: [Edge?], pageInfo: PageInfo) {
      self.init(unsafeResultMap: ["__typename": "CategoryNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Contains the nodes in this connection.
    public var edges: [Edge?] {
      get {
        return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
      }
    }

    /// Pagination data for this connection.
    public var pageInfo: PageInfo {
      get {
        return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
      }
    }

    public struct Edge: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CategoryNodeEdge"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
          GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(node: Node? = nil, cursor: String) {
        self.init(unsafeResultMap: ["__typename": "CategoryNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The item at the end of the edge
      public var node: Node? {
        get {
          return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "node")
        }
      }

      /// A cursor for use in pagination
      public var cursor: String {
        get {
          return resultMap["cursor"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "cursor")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CategoryNode"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("parent", type: .object(Parent.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(uuid: String, name: String? = nil, parent: Parent? = nil) {
          self.init(unsafeResultMap: ["__typename": "CategoryNode", "uuid": uuid, "name": name, "parent": parent.flatMap { (value: Parent) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var uuid: String {
          get {
            return resultMap["uuid"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "uuid")
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

        public var parent: Parent? {
          get {
            return (resultMap["parent"] as? ResultMap).flatMap { Parent(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "parent")
          }
        }

        public struct Parent: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["CategoryNode"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil, uuid: String) {
            self.init(unsafeResultMap: ["__typename": "CategoryNode", "name": name, "uuid": uuid])
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

          public var uuid: String {
            get {
              return resultMap["uuid"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "uuid")
            }
          }
        }
      }
    }

    public struct PageInfo: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PageInfo"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(endCursor: String? = nil, hasNextPage: Bool) {
        self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// When paginating forwards, the cursor to continue.
      public var endCursor: String? {
        get {
          return resultMap["endCursor"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "endCursor")
        }
      }

      /// When paginating forwards, are there more items?
      public var hasNextPage: Bool {
        get {
          return resultMap["hasNextPage"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasNextPage")
        }
      }
    }
  }

  public struct ItemDetails: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment itemDetails on ItemNodeConnection {
        __typename
        edges {
          __typename
          node {
            __typename
            uuid
            nameFr
            totalPoste
            unitStr
            categoryStr
            confidence
            tagFr
            attributeFr
            unit {
              __typename
              ...unitDetails
            }
          }
          cursor
        }
        pageInfo {
          __typename
          endCursor
          hasNextPage
        }
      }
      """

    public static let possibleTypes: [String] = ["ItemNodeConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .nonNull(.list(.object(Edge.selections)))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(edges: [Edge?], pageInfo: PageInfo) {
      self.init(unsafeResultMap: ["__typename": "ItemNodeConnection", "edges": edges.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, "pageInfo": pageInfo.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Contains the nodes in this connection.
    public var edges: [Edge?] {
      get {
        return (resultMap["edges"] as! [ResultMap?]).map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } }, forKey: "edges")
      }
    }

    /// Pagination data for this connection.
    public var pageInfo: PageInfo {
      get {
        return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
      }
    }

    public struct Edge: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ItemNodeEdge"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
          GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(node: Node? = nil, cursor: String) {
        self.init(unsafeResultMap: ["__typename": "ItemNodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The item at the end of the edge
      public var node: Node? {
        get {
          return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "node")
        }
      }

      /// A cursor for use in pagination
      public var cursor: String {
        get {
          return resultMap["cursor"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "cursor")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ItemNode"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
            GraphQLField("nameFr", type: .scalar(String.self)),
            GraphQLField("totalPoste", type: .scalar(Double.self)),
            GraphQLField("unitStr", type: .scalar(String.self)),
            GraphQLField("categoryStr", type: .scalar(String.self)),
            GraphQLField("confidence", type: .scalar(Int.self)),
            GraphQLField("tagFr", type: .scalar(String.self)),
            GraphQLField("attributeFr", type: .scalar(String.self)),
            GraphQLField("unit", type: .object(Unit.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(uuid: String, nameFr: String? = nil, totalPoste: Double? = nil, unitStr: String? = nil, categoryStr: String? = nil, confidence: Int? = nil, tagFr: String? = nil, attributeFr: String? = nil, unit: Unit? = nil) {
          self.init(unsafeResultMap: ["__typename": "ItemNode", "uuid": uuid, "nameFr": nameFr, "totalPoste": totalPoste, "unitStr": unitStr, "categoryStr": categoryStr, "confidence": confidence, "tagFr": tagFr, "attributeFr": attributeFr, "unit": unit.flatMap { (value: Unit) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var uuid: String {
          get {
            return resultMap["uuid"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "uuid")
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

        public var unitStr: String? {
          get {
            return resultMap["unitStr"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "unitStr")
          }
        }

        public var categoryStr: String? {
          get {
            return resultMap["categoryStr"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "categoryStr")
          }
        }

        public var confidence: Int? {
          get {
            return resultMap["confidence"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "confidence")
          }
        }

        public var tagFr: String? {
          get {
            return resultMap["tagFr"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "tagFr")
          }
        }

        public var attributeFr: String? {
          get {
            return resultMap["attributeFr"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "attributeFr")
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

        public struct Unit: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["UnitNode"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("quantity", type: .scalar(String.self)),
              GraphQLField("numerator", type: .scalar(String.self)),
              GraphQLField("denominator", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(uuid: String, name: String? = nil, quantity: String? = nil, numerator: String? = nil, denominator: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UnitNode", "uuid": uuid, "name": name, "quantity": quantity, "numerator": numerator, "denominator": denominator])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var uuid: String {
            get {
              return resultMap["uuid"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "uuid")
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

          public var numerator: String? {
            get {
              return resultMap["numerator"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "numerator")
            }
          }

          public var denominator: String? {
            get {
              return resultMap["denominator"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "denominator")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var unitDetails: UnitDetails {
              get {
                return UnitDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }

    public struct PageInfo: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PageInfo"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(endCursor: String? = nil, hasNextPage: Bool) {
        self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// When paginating forwards, the cursor to continue.
      public var endCursor: String? {
        get {
          return resultMap["endCursor"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "endCursor")
        }
      }

      /// When paginating forwards, are there more items?
      public var hasNextPage: Bool {
        get {
          return resultMap["hasNextPage"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasNextPage")
        }
      }
    }
  }

  public struct UnitDetails: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment unitDetails on UnitNode {
        __typename
        uuid
        name
        quantity
        numerator
        denominator
      }
      """

    public static let possibleTypes: [String] = ["UnitNode"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("quantity", type: .scalar(String.self)),
        GraphQLField("numerator", type: .scalar(String.self)),
        GraphQLField("denominator", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(uuid: String, name: String? = nil, quantity: String? = nil, numerator: String? = nil, denominator: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "UnitNode", "uuid": uuid, "name": name, "quantity": quantity, "numerator": numerator, "denominator": denominator])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var uuid: String {
      get {
        return resultMap["uuid"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "uuid")
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

    public var numerator: String? {
      get {
        return resultMap["numerator"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "numerator")
      }
    }

    public var denominator: String? {
      get {
        return resultMap["denominator"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "denominator")
      }
    }
  }
}
