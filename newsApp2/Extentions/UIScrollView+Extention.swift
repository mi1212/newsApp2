//
//  UIScrollView+Extention.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 30.09.2022.
//

import UIKit

extension UIScrollView {

    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }

}
