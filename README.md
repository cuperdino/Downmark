# Downmark (in development)

A Swift package which parses a markdown string to attributed text, which can be used in UIKit, AppKit (TODO) and SwiftUI (TODO). 

**Note: This is a package in (early) development, and should not be used in production.**

# Usage

Downmark is created to be easy to use:

### UIKit

```
let downmark = Downmark()
let label = UILabel()
label.attributedText = downmark.parse(text: "# A **bold** and *italic* header")
```

### SwiftUI (TODO)
```
  ...add SwiftUI code here...
```

### AppKit (TODO)
```
  ...add AppKit code here...
```

This will produce the following label:

<img width="383" alt="testHeading" src="https://user-images.githubusercontent.com/67503659/196253222-46a9a1b9-be2b-441c-9741-d5e7e20bc4ad.png">

# Installation (TODO)

# Markdown features
Downmark supports the following markdown features:
- [x] Headers
- [x] Bold text
- [x] Italic text
- [ ] Links
- [ ] Strikethrough text
- [ ] Bulleted lists
- [ ] Unordered lists

... and more features to come!


# Goals
- Implement a high number of markdown features.
- Be available on all of Apple's UI frameworks. Currently supports:
  - [x] UIKit
  - [ ] SwiftUI
  - [ ] Appkit
- Have a high test coverage
