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
let profile = try ICCColorProfile(data: data)

// Dump all the tags.
for tag in profile.tags {
    print(tag.signature)
    print(tag.type)
    print(tag.data)
}

// Print known tags (e.g. copyright)
print(profile.getTag(signature: "cprt"))
print(profile.getTag(signature: ICCTagSignature.copyright))
print(profile.copyright)
```
