//
//  WalkPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 06/07/1445 AH.
//  
//  UI Done

import SwiftUI
import AVFoundation
import CoreMotion

struct CameraCaptureView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraCaptureView
        var didCaptureImage: (UIImage) -> Void // Closure to handle the captured image

        init(parent: CameraCaptureView, didCaptureImage: @escaping (UIImage) -> Void) {
            self.parent = parent
            self.didCaptureImage = didCaptureImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                didCaptureImage(image) // Pass the captured image to the closure
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    var didCaptureImage: (UIImage) -> Void // Closure to handle the captured image

    init(didCaptureImage: @escaping (UIImage) -> Void) {
        self.didCaptureImage = didCaptureImage
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, didCaptureImage: didCaptureImage)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .camera
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ActivityView: View {
    let title: String
    let value: String

    var body: some View {
        
        
        ZStack{
        Image("CenterFire")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .foregroundColor(Color.white)
            .accessibility(label: Text("Fire image"))
               VStack {
                   Text(value)
                       .padding()
                       .bold()
                   .font(.title)
                   Text(title)
                .bold()
               }
           }
        }
       }



struct WalkPage: View {
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @State private var showMessage = false
    @State private var isActiveNavigationLink = false
    var selectedObject: (name: String, emoji: String)?
    @State private var elapsedTime: TimeInterval = 0
    @State private var capturedImage: UIImage?
    @State private var stepCount: Int = 0
    @State private var initialStepCount: Int = 0 // Store the initial step count when counting starts
    @State private var calorieCount: Int = 0
    @State private var isCounting: Bool = true
    @State private var isCaptureSheetPresented: Bool = false
    @State private var isCaptureComplete: Bool? = false // New state to track image capture completion
    @State private var shouldContinueCounting: Bool = true // Flag to control counting
    private let pedometer = CMPedometer()

    
    var body: some View {
    
        
        NavigationLink(
            destination: DonePage(
            ),
            tag: true,
            selection: $isCaptureComplete
        ) {
            EmptyView()
        }
        .hidden()
        
    
        VStack {
            HStack {
                Text("Walking Now")
                    .font(.title)
                    .bold()
                    .padding(.trailing, 110)
                    .accessibility(label: Text("Walking Now"))
                
                Button("End Walk") {
                    showAlert = true
                }
                .foregroundColor(.customRed)
                .bold()
                .accessibility(label: Text("End Walk"))
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirmation"),
                        message: Text("Are you sure you want to end the walk?"),
                        primaryButton: .default(Text("Yes")) {
                            isActiveNavigationLink = true
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
            }
         
        }
        
        
        
        ZStack {
            Image("Skyline")
                .resizable()
                .frame(width: 500, height: 370)
                .aspectRatio(contentMode: .fill)
                .accessibility(label: Text("Skyline image"))

              GifImage(name: "Fairy")
                .accessibility(label: Text("Walkline image"))
                .offset(y: 100)
                .overlay(
                    VStack {
                        Image("Skyline")
                            .resizable()
                            .frame(width: 500, height: 370)
                            .aspectRatio(contentMode: .fill)
                            .accessibility(label: Text("Skyline image"))
                    }
           
                )
            Spacer()
                 // Adjust the scale as needed
        }
          
            
            
            
        Spacer()
        
            VStack{
                HStack {
                    Spacer()
                    ActivityView(title: "steps", value: " \(stepCount)")
                    Spacer()
                    ActivityView(title: "Kcal", value: "\(calorieCount)")
                    Spacer()
                    ActivityView(title: "min", value: "\(formattedTime(elapsedTime))")
                    Spacer()
                }.offset(y: 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("Found it?")
                    
                    Spacer()
                    
                    Button("What you're looking for.") {
                        showMessage = true
                    }
                    .foregroundColor(.gray)
                    Spacer()
                    
                        .accessibility(label: Text("What you're looking for."))
                        .alert(isPresented: $showMessage) {
                                   Alert(
                                       title: Text(selectedObject?.name ?? ""),
                                       message: Text(selectedObject?.emoji ?? ""),
                                       dismissButton: .default(Text("OK")) {
                                           // Optional: Add an action when the user taps the OK button
                                           showMessage = false
                                       }
                                   )
                               }
                  
                        }
                    
                
                
                
                Button("Capture it!") {
                    isCaptureSheetPresented.toggle()
                }
                
                .font(.title2)
                .padding()
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(Color.customBlue)
                .cornerRadius(10)
                .sheet(isPresented: $isCaptureSheetPresented) {
                    CameraCaptureView { _ in
                        // This closure is called when the picture is taken
                        shouldContinueCounting = true
                        startCounting() // Start counting again after capturing the image
                        isCaptureComplete = true // Trigger navigation to the third view
                    }
                }
            
            Spacer()
                .onAppear {
                    startCounting()
                    requestMotionPermission()
                    
                    // Fetch HealthKit data when the view appears
                }
                .onDisappear {
                    stopCounting()
                    shouldContinueCounting = false
                }
            
                .navigationTitle("View 2")
        }
    
        .navigationBarHidden(true)
    }






private func requestMotionPermission() {
     if CMPedometer.isStepCountingAvailable() {
         pedometer.queryPedometerData(from: Date(), to: Date()) { pedometerData, _ in
             if let data = pedometerData {
                 DispatchQueue.main.async {
                     // Update the initial step count when the view appears
                     initialStepCount = Int(truncating: data.numberOfSteps)
                 }
             }
         }
     }
 }

private func startCounting() {
    
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        guard shouldContinueCounting else {
            timer.invalidate()
            return
        }
        elapsedTime += 1
    
    
    
    guard CMPedometer.isStepCountingAvailable() else {
        print("Step counting not available on this device.")
        return
    }
    
    isCounting = true
    pedometer.startUpdates(from: Date()) { pedometerData, error in
        guard error == nil, let data = pedometerData else { return }
        
        DispatchQueue.main.async {
    
                // Update step count and calorie count only if counting should continue
                stepCount = Int(truncating: data.numberOfSteps) - initialStepCount
                calorieCount = calculateCaloriesBurned(stepCount: stepCount)
              
            }
        }
    }
}

private func stopCounting() {

    shouldContinueCounting = false // Stop counting when the image is captured
    isCounting = false
    pedometer.stopUpdates()
    dataController.addHistory(date: Date(), stepCount: stepCount, calorieCount: calorieCount, context:viewContext)
    dataController.save(context: dataController.container.viewContext)
}

private func formattedTime(_ time: TimeInterval) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)

}
}

private func calculateCaloriesBurned(stepCount: Int) -> Int {
// METs formula for calories burned: Calories = METs * weight in kg * duration in hour
// Assuming an average walking speed burns around 0.05 calories per step
let caloriesPerStep: Double = 0.04

let calorieCount = Double(stepCount) * caloriesPerStep
let calorieCount1 = Int(calorieCount)

return calorieCount1
}



struct WalkPage_Previews: PreviewProvider {
static var previews: some View {
WalkPage()
}
}


      
    



/*
import SwiftUI
import AVFoundation
import CoreMotion


struct CameraCaptureView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraCaptureView
        var didCaptureImage: (UIImage) -> Void // Closure to handle the captured image

        init(parent: CameraCaptureView, didCaptureImage: @escaping (UIImage) -> Void) {
            self.parent = parent
            self.didCaptureImage = didCaptureImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                didCaptureImage(image) // Pass the captured image to the closure
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    var didCaptureImage: (UIImage) -> Void // Closure to handle the captured image

    init(didCaptureImage: @escaping (UIImage) -> Void) {
        self.didCaptureImage = didCaptureImage
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, didCaptureImage: didCaptureImage)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .camera
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ActivityView: View {
    let title: String
    let value: String

    var body: some View {
 Zstack{
 Image("CenterFire")
     .resizable()
     .aspectRatio(contentMode: .fit)
     .frame(width: 120, height: 120)
     .foregroundColor(Color.white)
     .accessibility(label: Text("Fire image"))
        VStack {
            Text(title)
            Text(value)
                .font(.title)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
 }
}

struct WalkView: View {
    @State private var elapsedTime: TimeInterval = 0
    @State private var capturedImage: UIImage?
    @State private var stepCount: Int = 0
    @State private var initialStepCount: Int = 0 // Store the initial step count when counting starts
    @State private var calorieCount: Int = 0
    @State private var isCounting: Bool = true
    @State private var isCaptureSheetPresented: Bool = false
    @State private var isCaptureComplete: Bool? = false // New state to track image capture completion
    @State private var shouldContinueCounting: Bool = true // Flag to control counting
    private let pedometer = CMPedometer()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                         Spacer()
                         ActivityView(title: "Steps:", value: " \(stepCount)")
                         Spacer()
                         ActivityView(title: "Calories:", value: "\(calorieCount)")
                         Spacer()
                         ActivityView(title: "Time:", value: "\(formattedTime(elapsedTime))")
                         Spacer()
                     }
                // Check if image capture is complete, then navigate to the third view
                NavigationLink(
                    destination: ResultView(
                        elapsedTime: elapsedTime,
                        capturedImage: capturedImage,
                        realStepCount: stepCount,
                        realCalorieCount: Int(calorieCount)
                    ),
                    tag: true,
                    selection: $isCaptureComplete
                ) {
                    EmptyView()
                }
                .hidden()
                
              GifImage(name: "Fairy")
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("Found it?")

                    Spacer()
                    Text("What you're looking for.")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding()
                

                Button("Capture Image") {
                    isCaptureSheetPresented.toggle()
                }
               
                .padding()
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
                .sheet(isPresented: $isCaptureSheetPresented) {
                    CameraCaptureView { _ in
                        // This closure is called when the picture is taken
                        shouldContinueCounting = true
                        startCounting() // Start counting again after capturing the image
                        isCaptureComplete = true // Trigger navigation to the third view
                    }
                }

                Spacer()
                    .onAppear {
                        startCounting()
                        requestMotionPermission()
                    
                        // Fetch HealthKit data when the view appears
                    }
                    .onDisappear {
                        stopCounting()
                        shouldContinueCounting = false
                    }

                    .navigationTitle("View 2")
            }
        }
    }
    
    
    
    

    private func requestMotionPermission() {
         if CMPedometer.isStepCountingAvailable() {
             pedometer.queryPedometerData(from: Date(), to: Date()) { pedometerData, _ in
                 if let data = pedometerData {
                     DispatchQueue.main.async {
                         // Update the initial step count when the view appears
                         initialStepCount = Int(truncating: data.numberOfSteps)
                     }
                 }
             }
         }
     }

    private func startCounting() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard shouldContinueCounting else {
                timer.invalidate()
                return
            }
            elapsedTime += 1
        
        
        
        guard CMPedometer.isStepCountingAvailable() else {
            print("Step counting not available on this device.")
            return
        }
        
        isCounting = true
        pedometer.startUpdates(from: Date()) { pedometerData, error in
            guard error == nil, let data = pedometerData else { return }
            
            DispatchQueue.main.async {
        
                    // Update step count and calorie count only if counting should continue
                    stepCount = Int(truncating: data.numberOfSteps) - initialStepCount
                    calorieCount = calculateCaloriesBurned(stepCount: stepCount)
                  
                }
            }
        }
    }
    
    private func stopCounting() {
        shouldContinueCounting = false // Stop counting when the image is captured
        isCounting = false
        pedometer.stopUpdates()
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)

    }
}

private func calculateCaloriesBurned(stepCount: Int) -> Int {
    // METs formula for calories burned: Calories = METs * weight in kg * duration in hour
    // Assuming an average walking speed burns around 0.05 calories per step
    let caloriesPerStep: Double = 0.04

    let calorieCount = Double(stepCount) * caloriesPerStep
    let calorieCount1 = Int(calorieCount)

    return calorieCount1
}

*/
