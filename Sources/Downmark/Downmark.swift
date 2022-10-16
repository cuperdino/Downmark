import Foundation
import UIKit
import Markdown

public struct Downmark: MarkupVisitor {
    var attributedString: NSAttributedString!

    public init(text: String) {
        let document = Document(parsing: text)
        self.attributedString = self.visit(document)
    }

    public mutating func defaultVisit(_ markup: Markup) -> NSAttributedString {
        let string = NSMutableAttributedString()
        for child in markup.children {
            string.append(visit(child))
        }
        return string
    }

    public func visitHeading(_ heading: Heading) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for child in heading.children {
            attributedString.append(createHeading(child, level: heading.level))
        }
        return attributedString
    }

    public func visitEmphasis(_ emphasis: Emphasis) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 0)
        let text = TextExtractor(markup: emphasis).outputString
        let traits = TraitCreator(markup: emphasis).traits
        return NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont(
                    descriptor: font.fontDescriptor.withSymbolicTraits(traits!)!,
                    size: 16
                )
        ])
    }

    public func visitStrong(_ strong: Strong) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 0)
        let text = TextExtractor(markup: strong).outputString
        let traits = TraitCreator(markup: strong).traits
        return NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont(
                    descriptor: font.fontDescriptor.withSymbolicTraits(traits!)!,
                    size: 16
                )
        ])
    }
}

// MARK: Helpers

extension Downmark {
    private func createHeading(_ markup: Markup, level: Int) -> NSAttributedString {
        let font: UIFont
        let traitFont = UIFont.systemFont(ofSize: 0)
        let traits = TraitCreator(markup: markup).traits
        if level == 1 {
            font = UIFont(
                descriptor: traitFont.fontDescriptor.withSymbolicTraits(traits!)!,
                size: 36
            )
        } else if level == 2 {
            font = UIFont(
                descriptor: traitFont.fontDescriptor.withSymbolicTraits(traits!)!,
                size: 28
            )
        } else if level == 3 {
            font = UIFont(
                descriptor: traitFont.fontDescriptor.withSymbolicTraits(traits!)!,
                size: 24
            )
        } else {
            font = UIFont(
                descriptor: traitFont.fontDescriptor.withSymbolicTraits(traits!)!,
                size: 20
            )
        }

        let text = TextExtractor(markup: markup).outputString

        let string = NSAttributedString(string: text, attributes: [
            .font: font
        ])

        return string
    }
}

public struct TraitCreator: MarkupVisitor {

    var traits: UIFontDescriptor.SymbolicTraits!

    init(markup: Markup) {
        traits = visit(markup)
    }

    public mutating func defaultVisit(_ markup: Markup) -> UIFontDescriptor.SymbolicTraits {
        var traits = UIFontDescriptor.SymbolicTraits()
        for child in markup.children {
            traits.insert(visit(child))
        }
        return traits
    }

    public mutating func visitEmphasis(_ emphasis: Emphasis) -> UIFontDescriptor.SymbolicTraits {
        var traits = UIFontDescriptor.SymbolicTraits(arrayLiteral: .traitItalic)
        for child in emphasis.children {
            traits.insert(visit(child))
        }
        return traits
    }

    public mutating func visitStrong(_ strong: Strong) -> UIFontDescriptor.SymbolicTraits {
        var traits = UIFontDescriptor.SymbolicTraits(arrayLiteral: .traitBold)
        for child in strong.children {
            traits.insert(visit(child))
        }
        return traits
    }
}

public struct TextExtractor: MarkupWalker {

    public var outputString: String = ""

    public init(markup: Markup) {
        self.visit(markup)
    }

    public mutating func visitText(_ text: Text) {
        outputString += text.string
        descendInto(text)
    }
}
