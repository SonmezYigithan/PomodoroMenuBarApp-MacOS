//
//  NSImage+Extensions.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 11.02.2024.
//

import AppKit

extension NSImage {
    func setColor(color: NSColor) -> NSImage {
        return NSImage(size: size, flipped: false) { (rect) -> Bool in
            color.set()
            rect.fill()
            self.draw(in: rect, from: NSRect(origin: .zero, size: self.size), operation: .destinationIn, fraction: 1.0)
            return true
        }
    }
}
