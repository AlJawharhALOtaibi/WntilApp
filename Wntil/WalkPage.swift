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

        init(parent: CameraCaptureView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.didCaptureImage(image) // Call the closure to store the captured image
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
        return Coordinator(parent: self)
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
                    .padding(.top,35)
                       .bold()
                   .font(.title)
                   Text(title)
                .bold()
               }
           }
        }
       }



struct WalkPage: View {
    @Binding var selectedObject: (name: String, emoji: String)?
    
    @StateObject var dataController = DataController()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false
    @State private var showMessage = false
    @State private var isActiveNavigationLink = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var capturedImage: UIImage?
    @State private var stepCount: Int = 0
    @State private var initialStepCount: Int = 0
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
            Spacer().frame(height: 50)

            HStack {
                
                Button("وقفت المشي؟") {
                    showAlert = true
                }
                .foregroundColor(.customRed)
                .bold()
                .accessibility(label: Text("وقفت المشي؟"))
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("تأكيد"),
                        message: Text("هل تود انهاء التحدي؟"),
                        primaryButton: .default(Text("نعم")) {
                            isActiveNavigationLink = true
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel(Text("الغاء"))                    )
                }
                
   

                Text("على طريقك")
                    .font(.title)
                    .bold()
                    .padding(.leading, 110)
                    .accessibility(label: Text("على طريقك"))
            }
         
        }
        
        
        
        
        ZStack {
            GifImage(name: "Fairy4")
              .accessibility(label: Text("Walkline image"))
              .offset(x:0 , y: 100)
              .frame(width:400)
           
        }
        
        
          Spacer()
        
            VStack{
                HStack {
                    Spacer()
                    ActivityView(title: "خطوات", value: "\(stepCount)")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                    Spacer()
                    ActivityView(title: "سعرة حرارية", value: "\(calorieCount)")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    Spacer()
                    ActivityView(title: "دقيقة", value: "\(formattedTime(elapsedTime))")
                        .foregroundColor(.white)
                        .font(.system(size: 16))


                    Spacer()
                }.offset(y: 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                            
                        }
                
                Button(action: {
                    isCaptureSheetPresented.toggle()
                    dataController.addHistory(date: Date(), stepCount: stepCount, calorieCount: calorieCount, context: viewContext)
                    dataController.save(context: dataController.container.viewContext)
                }) {
                    HStack {
                        
                        if let selectedObject = selectedObject {
                            Text(selectedObject.emoji)
                            Text(selectedObject.name)
                            
                        }
                        
                        Text("صور")
                    }
                }
                .padding()
                .font(.headline)
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(Color.customBlue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                .sheet(isPresented: $isCaptureSheetPresented) {
                    CameraCaptureView { capturedImage in
                        self.capturedImage = capturedImage
                        // This closure is called when the picture is taken
                        shouldContinueCounting = true
                        startCounting() // Start counting again after capturing the image
                        isCaptureComplete = true // Trigger navigation to the third view
                    }
                }


            
            Spacer()
                .onAppear {
                    startTimer()
                    startCounting()
                    requestMotionPermission()
                    
                }
                .onDisappear {
                    stopCounting()
                    shouldContinueCounting = false
                }
            
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
    
    
    private func startTimer() {
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                 guard shouldContinueCounting else {
                     timer.invalidate()
                     return
                 }
                 elapsedTime += 1
        }
    }

private func startCounting() {

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


struct WalkPage_Previews: PreviewProvider {
    @State static var selectedObject: (name: String, emoji: String)? = nil

    static var previews: some View {
        WalkPage(selectedObject: $selectedObject)
    }
}



