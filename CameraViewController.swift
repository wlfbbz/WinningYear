////
////  CameraViewController.swift
////  WinningYear
////
////  Created by Barbara on 13/03/2024.
////
//
//import SwiftUI
//
//struct CameraViewController: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    var didSaveToPhotosAlbum: ((Bool) -> Void)?
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = context.coordinator
//        imagePicker.sourceType = .camera
//        imagePicker.allowsEditing = false
//        return imagePicker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        // Nothing to update
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: CameraViewController
//        
//        init(_ parent: CameraViewController) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.image = image
//                savePic(image: image)
//                picker.dismiss(animated: true)
//            } else {
//                picker.dismiss(animated: true)
//            }
//        }
//        
//        func savePic(image: UIImage) {
//            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted(_:didFinishSavingWithError:contextInfo:)), nil)
//        }
//        
//        @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer?) {
//            if let error = error {
//                print("Error saving photo: \(error.localizedDescription)")
//                parent.didSaveToPhotosAlbum?(false)
//            } else {
//                print("Saved photo successfully")
//                parent.didSaveToPhotosAlbum?(true)
//            }
//        }
//    }
//}
//
