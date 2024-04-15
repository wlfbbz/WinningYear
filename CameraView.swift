//
//  CameraView.swift
//  WinningYear
//
//  Created by Barbara on 26/02/2024.
//

import SwiftUI
import AVFoundation
import UIKit
import PhotosUI

struct CameraView: View {
    @State private var showPicker = false
    @Environment(\.presentationMode) var presentationMode // Access presentationMode
    var photoSavedHandler: ((Data) -> Void)? // Closure property
    @State private var isLoading = false

    @StateObject var camera = CameraModel()

    var body: some View {
        ZStack {
            if camera.isTaken {
                SelectedImageView(camera: camera, photoSavedHandler: photoSavedHandler)
                    .animation(.default)
            } else {
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all, edges: .all)
            }

            VStack {
                if camera.isTaken {
                    HStack {
                        Spacer()
                        Button(action: {
                            camera.reTake()
                        }, label: {
                            Text("Retake")
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .padding(.top, 40)
                        })
                        .padding(.trailing, 16)
                    }
                } else {
                    HStack {
                        Spacer()
                        Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                            Text("Cancel")
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.trailing, 16)
                    }
                }
                
                Spacer()
                
                HStack {
                    if !camera.isTaken {
                                                HStack {
                                                    Button(action: {
                                                        showPicker = true
                                                    }, label: {
                                                        Text("Photo Library")
                                                            .foregroundColor(.black)
                                                            .padding(.horizontal, 20)
                                                            .padding(.vertical, 10)
                                                            .background(Color.white)
                                                            .clipShape(Capsule())
                                                    })
                                                    .padding(.leading)
                                                    .sheet(isPresented: $showPicker) {
                                                        PhotoPicker(showPicker: $showPicker, photoSavedHandler: camera.loadImage)
                                                            .edgesIgnoringSafeArea(.all)
                                                    }
                                                }
                        Spacer()
                        
                        Spacer()
                        
                        Button(action: camera.takePic, label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                        
                        Spacer()
                        
                        HStack {
                            Button(action: camera.flipCamera, label: {
                                Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                            .padding(.trailing)
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            camera.Check()
        })
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("Please Enable Camera Access"))
        }
    }
}

// Camera Model...

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {

    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    // since were going to read pic data....
    @Published var output = AVCapturePhotoOutput()
    
    // preview....
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    // Pic Data...
    
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    var photoSavedHandler: ((Data) -> Void)?
    
    
    // New property to keep track of current camera position
    @Published var currentPosition: AVCaptureDevice.Position = .back
    
    func Check(){
        
        // first checking camerahas got permission...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
            // Setting Up Session
        case .notDetermined:
            // retusting for permission....
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func setUp(){
        
        // setting up camera...
        
        do{
            
            // setting configs...
            self.session.beginConfiguration()
            
            // change for your own...
            
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            // checking and adding to session...
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            // same for output....
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
        if !self.session.isRunning {
             DispatchQueue.global(qos: .background).async {
                 self.session.startRunning()
             }
         }
    }
    
    // take and retake functions...
    func takePic() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    

    func reTake() {
        // Stop the camera session on the main thread
        DispatchQueue.main.async {
            self.isTaken = false
            self.isSaved = false
            self.picData = Data(count: 0)
        }
        
        // Start the camera session after a delay to allow UI updates
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            self.session.startRunning()
        }
    }


    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        if currentPosition == .front {
            // Flip the image horizontally for front camera
            if let image = UIImage(data: imageData) {
                let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
                self.picData = flippedImage.jpegData(compressionQuality: 1.0) ?? Data()
            }
        } else {
            self.picData = imageData
        }
        
        DispatchQueue.main.async {
            self.isTaken.toggle()
            self.session.stopRunning()

        }
    }
    
    
    func savePic(completion: @escaping (Bool) -> Void) {
        guard let image = UIImage(data: self.picData) else {
            completion(false)
            return
        }
        
        // saving Image...
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        print("saved Successfully....")
        
        completion(true)
    }
    
    
    // Function to flip between front and back camera
    func flipCamera() {
        // Invert the current camera position
        currentPosition = currentPosition == .back ? .front : .back
        
        // Create new device based on the new camera position
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition) else { return }
        
        // Configure the device
        do {
            try device.lockForConfiguration()
            if device.isFocusModeSupported(.continuousAutoFocus) {
                device.focusMode = .continuousAutoFocus
            }
            if device.isExposureModeSupported(.continuousAutoExposure) {
                device.exposureMode = .continuousAutoExposure
            }
            if device.isWhiteBalanceModeSupported(.continuousAutoWhiteBalance) {
                device.whiteBalanceMode = .continuousAutoWhiteBalance
            }
            device.unlockForConfiguration()
        } catch {
            print(error.localizedDescription)
        }
        
        // Create new input
        let input = try? AVCaptureDeviceInput(device: device)
        
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()
            
            // Begin new session configuration
            self.session.beginConfiguration()
            
            // Remove existing inputs from the session
            self.session.inputs.forEach { input in
                self.session.removeInput(input)
            }
            
            // Add new input to the session
            if let input = input, self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            // Commit new session configuration
            self.session.commitConfiguration()
            self.session.startRunning()
        }
        
        // Update the preview layer's connection orientation
        DispatchQueue.main.async {
            self.updatePreviewOrientation()
        }
    }

    // Function to update the preview layer's connection orientation
    func updatePreviewOrientation() {
        if let connection = preview.connection {
            if connection.isVideoOrientationSupported {
                connection.videoOrientation = .portrait
            }
            
            if currentPosition == .front {
                if connection.isVideoMirroringSupported {
                    connection.automaticallyAdjustsVideoMirroring = false
                    connection.isVideoMirrored = true
                }
            } else {
                if connection.isVideoMirroringSupported {
                    connection.automaticallyAdjustsVideoMirroring = true
                }
            }
        }
    }
    func loadImage(imageData: Data) {
        self.picData = imageData
        DispatchQueue.main.async {
            self.isTaken.toggle()
            self.session.stopRunning()
        }
    }
}

// setting view for preview...

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    
    // Add a CALayer property to store the preview layer
    private let previewLayer = CALayer()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // Show the camera preview
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        
        // Assign the preview layer to the previewLayer property
        previewLayer.frame = view.bounds
        previewLayer.addSublayer(camera.preview)
        view.layer.addSublayer(previewLayer)
        
        // Start the camera session
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    // Add a method to apply the transition animation to the preview layer
    func applyTransition(transitionType: CATransitionType, transitionSubtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = transitionType
        transition.subtype = transitionSubtype
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        previewLayer.add(transition, forKey: "FlipTransition")
    }
}


struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    var photoSavedHandler: (Data) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.showPicker = false

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    if let uiImage = image as? UIImage {
                        if let data = uiImage.jpegData(compressionQuality: 1.0) {
                            DispatchQueue.main.async {
                                self.parent.photoSavedHandler(data)
                            }
                        }
                    }
                }
            }
        }
    }
}
struct SelectedImageView: View {
    @ObservedObject var camera: CameraModel
    var photoSavedHandler: ((Data) -> Void)?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if let image = UIImage(data: camera.picData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        camera.savePic { success in
                            if success {
                                photoSavedHandler?(camera.picData)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }, label: {
                        Text("Use photo")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding(.bottom, 40)
                    })
                    .padding(.leading)
                    Spacer()
                }
            }
        }
    }
}
 
