import XCTest
import Markdown
@testable import Downmark
import UIKit

final class DownmarkTests: XCTestCase {
    func testMarkdownHeaderLevel1Parsing() throws {
        let parsedString = Downmark().parse(text: "# Header")
        let attributedString = NSAttributedString(string: "Header").withFont(size: 36)

        XCTAssertEqual(attributedString, parsedString)
    }

    func testMarkdownHeaderLevel2Parsing() throws {
        let parsedString = Downmark().parse(text: "## Header")
        let attributedString = NSAttributedString(string: "Header").withFont(size: 28)
        XCTAssertEqual(attributedString, parsedString)
    }

    func testMarkdownHeaderLevel3Parsing() throws {
        let parsedString = Downmark().parse(text: "### Header")
        let attributedString = NSAttributedString(string: "Header").withFont(size: 24)
        XCTAssertEqual(attributedString, parsedString)
    }

    func testMarkdownHeaderDefaultLevelParsing() throws {
        let parsedString = Downmark().parse(text: "#### Header")
        let attributedString = NSAttributedString(string: "Header").withFont(size: 20)
        XCTAssertEqual(attributedString, parsedString)
    }

    func testEmphasisedText() throws {
        let parsedString = Downmark().parse(text: "*Text*")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 16, traits: .traitItalic)

        XCTAssertEqual(attributedString, parsedString)
    }

    func testBoldText() throws {
        let parsedString = Downmark().parse(text: "**Text**")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 16, traits: .traitBold)

        XCTAssertEqual(attributedString, parsedString)
    }

    func testBoldEmphasisedText() throws {
        let parsedString = Downmark().parse(text: "***Text***")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 16, traits: [.traitItalic, .traitBold])

        XCTAssertEqual(attributedString, parsedString)
    }

    func testBoldHeader() throws {
        let parsedString = Downmark().parse(text: "# **Text**")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 36, traits: .traitBold)

        XCTAssertEqual(attributedString, parsedString)
    }

    func testEmphasisedHeader() throws {
        let parsedString = Downmark().parse(text: "# *Text*")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 36, traits: .traitItalic)

        XCTAssertEqual(attributedString, parsedString)
    }

    func testBoldEmphasisedHeader() throws {
        let parsedString = Downmark().parse(text: "# ***Text***")
        let attributedString = NSAttributedString(string: "Text").withFont(size: 36, traits: [.traitItalic, .traitBold])

        XCTAssertEqual(attributedString, parsedString)
    }

    func testHeaderWithChildren() throws {
        let parsedString = Downmark().parse(text: "# **Bold** *italic*")
        let attributedString1 = NSMutableAttributedString(string: "Bold").withFont(size: 36, traits: .traitBold)
        let attributedString2 = NSAttributedString(string: " ").withFont(size: 36)
        let attributedString3 = NSMutableAttributedString(string: "italic").withFont(size: 36, traits: .traitItalic)

        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)

        XCTAssertEqual(attributedString1, parsedString)
    }
}

extension NSAttributedString {
    func withFont(size: CGFloat, traits: UIFontDescriptor.SymbolicTraits = []) -> Self {
        let font = UIFont.systemFont(ofSize: 0)

        return Self(string: self.string, attributes: [
            .font: UIFont(
                descriptor: font.fontDescriptor.withSymbolicTraits(traits)!,
                size: size
            )
        ])
    }
}
