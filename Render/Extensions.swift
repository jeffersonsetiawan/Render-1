import Foundation
import UIKit

extension CGFloat {
  public static let undefined: CGFloat = RYGNaNSize.width
  public static let max: CGFloat = CGFloat(Float.greatestFiniteMagnitude)
  public static let epsilon: CGFloat = CGFloat(Float.ulpOfOne)
}

extension CGSize {
  public static let undefined: CGSize = CGSize(width: CGFloat.undefined, height: CGFloat.undefined)
  public static let max: CGSize =  CGSize(width: CGFloat.max, height: CGFloat.max)
  public static let epsilon: CGSize =  CGSize(width: CGFloat.epsilon, height: CGFloat.epsilon)
}

extension CGRect {
  public mutating func normalize() {
    self.origin.x = self.origin.x.isNormal ? self.origin.x : 0
    self.origin.y = self.origin.y.isNormal ? self.origin.y : 0
    self.size.width = self.size.width.isNormal ? self.size.width : 0
    self.size.height = self.size.height.isNormal ? self.size.height : 0
  }
}

fileprivate var handleAnimatable: UInt8 = 0
fileprivate var handleHasNode: UInt8 = 0
fileprivate var handleNewlyCreated: UInt8 = 0

extension UIView {

  public var isAnimatable: Bool {
    get {
      return (objc_getAssociatedObject(self, &handleAnimatable) as? NSNumber)?.boolValue ?? true
    }
    set {
      objc_setAssociatedObject(self,
                               &handleAnimatable,
                               NSNumber(value: newValue),
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  internal var hasNode: Bool {
    get {
      return (objc_getAssociatedObject(self, &handleHasNode) as? NSNumber)?.boolValue ?? false
    }
    set {
      objc_setAssociatedObject(self,
                               &handleHasNode,
                               NSNumber(value: newValue),
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }


  internal var isNewlyCreated: Bool {
    get {
      return (objc_getAssociatedObject(self, &handleNewlyCreated) as? NSNumber)?.boolValue ?? false
    }
    set {
      objc_setAssociatedObject(self,
                               &handleNewlyCreated,
                               NSNumber(value: newValue),
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
