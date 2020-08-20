//
//  Extensions.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return top + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return left + frame.size.width
    }
    
    public var safeAreaTopInset: CGFloat {
        return safeAreaInsets.top
    }
    
    public var safeAreaBottomInset: CGFloat {
        return safeAreaInsets.bottom
    }
    
    public var safeAreaLeftInset: CGFloat {
        return safeAreaInsets.left
    }
    
    public var safeAreaRightInset: CGFloat {
        return safeAreaInsets.right
    }
    
}

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
