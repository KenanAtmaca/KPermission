# KPermission

<img src="https://user-images.githubusercontent.com/16580898/62778703-be8ae300-bab9-11e9-99a0-2418eafcbd93.png" width="100%">

<p align="center">
  <img alt="MIT Licance" src="https://img.shields.io/github/license/KenanAtmaca/KPermission"/>
  <img alt="MIT Licance" src="https://img.shields.io/github/tag/KenanAtmaca/KPermission"/>
  <img alt="MIT Licance" src="https://img.shields.io/cocoapods/p/KPermission"/>
  <img alt="MIT Licance" src="https://img.shields.io/badge/Swift-4.2%2B-orange"/>
</p>


## Advantages
- [X] Simply use.
- [X] Easy permission request.


## Requirements

- Xcode 9.0 +
- iOS 10.0 or greater


## Installation

### CocoaPods

1. Install [CocoaPods](http://cocoapods.org)
2. Add this repo to your `Podfile`

```ruby
target 'Example' do
  use_frameworks!
	
  pod 'KPermission'
end
```

3. Run `pod install`
4. Open up the new `.xcworkspace` that CocoaPods generated
5. Whenever you want to use the library: `import KEmptyView`

### Manually

1. Simply download the `KPermission` source files and import them into your project.

## Usage

<p align="center">
<img src="https://user-images.githubusercontent.com/16580898/62779077-d1ea7e00-baba-11e9-902b-fa81529ba5de.png" width="40%"/>
</p>

```Swift
KPermission.shared.view.show(view: self.view, types: [.camera, .photoLibrary], animation: .scale)
```
Permission types:
- Camera
- Photo Library
- Notification
- Location
- Microphone
- Calander
- Contacts
- Reminder
- Motion
- Media Library
- Speech


## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
