# ICCReader

Swift definitions for structures, enumerations and functions defined in the [ICC Profile Format Specification](http://www.color.org/icc32.pdf)

## Example Usage

Add the following line to your project's SwiftPM dependencies:
```swift
.package(url: "https://github.com/hughbe/ICCReader", from: "1.0.0"),
```

```swift
import ICCReader

let data = Data(contentsOfFile: "<path-to-file>.icm")!
let file = try ICCColorProfile(data: data)
for tag in file.tags {
print(tag)
}
```
