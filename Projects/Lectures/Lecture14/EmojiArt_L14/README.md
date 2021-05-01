# Lecture 14: UIKit Integration

UIViewControllerRepresentable

## Design Choice

### ImagePicker

Alt1:  @Binding
 ```swift
    ImagePicker(image: $selectedImage)
 ```
    

Alt2 (in Lecture) :  

 ```swift
    typealias PickedImageHandler = (UIImage?) -> Void

    init(handlePickedImage: @escaping PickedImageHandler) {
        self.handlePickedImage = handlePickedImage
    }
 ```

  call from View:
```swift
   ImagePicker(sourceType: self.imagePickerSourceType) { image in 

```



## Note

### Camera availability check

To avoid crash when there is no camera (t.e.x, simulator):

```swift
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
```

### Camera and Photo choosing can share the same Imagepicker
Just by passing in different ` picker.sourceType`

