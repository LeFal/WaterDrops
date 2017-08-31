# WaterDrops
Simple water drops animation 💧

<img src="ExampleImages/ExampleImages1.gif" width="250"> <img src="ExampleImages/ExampleImages2.gif" width="250"> <img src="ExampleImages/ExampleImages3.gif" width="250">

## Example
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.white

        // custom configuration
        let waterDropView = WaterDropsView {
            $0.color = UIColor.white
            $0.dropNum = 30
            $0.startAnimation()
        }

        waterDropView.frame = self.view.bounds
        self.view.addSubview(waterDropsView)
}
```

## Installation

### Cocoapods
```ruby
pod "WaterDrops"
```

## Author

LeFal, qwertyhj2@gmail.com

## License

'WaterDrops' is available under the MIT license. See the LICENSE file for more info.
