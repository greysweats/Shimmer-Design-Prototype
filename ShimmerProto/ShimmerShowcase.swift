//
//  ShimmerShowcase.swift
//  SwiftUI-Shimmer
//
//  Interactive prototype to showcase and control shimmer parameters
//

import SwiftUI
import Shimmer

struct ShimmerShowcase: View {
    // Animation parameters
    @State private var duration: Double = 1.5
    @State private var delay: Double = 0.25
    @State private var bounce: Bool = false
    
    // Gradient parameters
    @State private var bandSize: CGFloat = 0.3
    @State private var startOpacity: Double = 0.3
    @State private var midOpacity: Double = 1.0
    @State private var endOpacity: Double = 0.3
    
    // Gradient colors
    @State private var useCustomColors: Bool = false
    @State private var startColor: Color = .blue
    @State private var midColor: Color = .white
    @State private var endColor: Color = .blue
    
    // Mode selection
    @State private var selectedMode: ShimmerModeOption = .mask
    @State private var blendMode: BlendMode = .sourceAtop
    
    // Preview options
    @State private var previewText: String = "SwiftUI Shimmer"
    @State private var previewFontSize: CGFloat = 48
    @State private var isActive: Bool = true
    
    enum ShimmerModeOption: String, CaseIterable {
        case mask = "Mask"
        case overlay = "Overlay"
        case background = "Background"
        
        func toShimmerMode(blendMode: BlendMode) -> Shimmer.Mode {
            switch self {
            case .mask: return .mask
            case .overlay: return .overlay(blendMode: blendMode)
            case .background: return .background
            }
        }
    }
    
    var currentGradient: Gradient {
        if useCustomColors {
            return Gradient(colors: [
                startColor.opacity(startOpacity),
                midColor.opacity(midOpacity),
                endColor.opacity(endOpacity)
            ])
        } else {
            return Gradient(colors: [
                .black.opacity(startOpacity),
                .black.opacity(midOpacity),
                .black.opacity(endOpacity)
            ])
        }
    }
    
    var currentAnimation: Animation {
        Animation.linear(duration: duration)
            .delay(delay)
            .repeatForever(autoreverses: bounce)
    }
    
    // Create a unique ID based on all parameters to force view refresh
    private var parametersID: String {
        "\(duration)-\(delay)-\(bounce)-\(bandSize)-\(startOpacity)-\(midOpacity)-\(endOpacity)-\(useCustomColors)-\(selectedMode)-\(isActive)-\(startColor.description)-\(midColor.description)-\(endColor.description)-\(blendMode)"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Preview Section
                previewSection
                    .id(parametersID) // Force refresh when parameters change
                
                Divider()
                
                ScrollView {
                    // Controls
                    VStack(spacing: 25) {
                        animationControls
                        gradientControls
                        colorControls
                        modeControls
                        previewControls
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .navigationTitle("Shimmer Showcase")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        resetToDefaults()
                    }
                }
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - Preview Section
    
    private var previewSection: some View {
        VStack(spacing: 20) {
            Text("Preview")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 200)
                
                Text(previewText)
                    .font(.system(size: previewFontSize, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .shimmering(
                        active: isActive,
                        animation: currentAnimation,
                        gradient: currentGradient,
                        bandSize: bandSize,
                        mode: selectedMode.toShimmerMode(blendMode: blendMode)
                    )
            }
            .padding(.horizontal)
            
            // Preview samples
            HStack(spacing: 15) {
                sampleCard(icon: "rectangle.fill", title: "Card")
                sampleCard(icon: "circle.fill", title: "Avatar")
                sampleCard(icon: "text.alignleft", title: "Text")
            }
            .padding(.horizontal)
            .id(parametersID)
        }
    }
    
    private func sampleCard(icon: String, title: String) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            Text(title)
                .font(.caption)
        }
        .shimmering(
            active: isActive,
            animation: currentAnimation,
            gradient: currentGradient,
            bandSize: bandSize,
            mode: selectedMode.toShimmerMode(blendMode: blendMode)
        )
    }
    
    // MARK: - Animation Controls
    
    private var animationControls: some View {
        GroupBox(label: Label("Animation", systemImage: "waveform")) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Duration")
                        Spacer()
                        Text("\(duration, specifier: "%.2f")s")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $duration, in: 0.5...5.0, step: 0.1)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Delay")
                        Spacer()
                        Text("\(delay, specifier: "%.2f")s")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $delay, in: 0...2.0, step: 0.05)
                }
                
                Toggle("Bounce (Auto-reverse)", isOn: $bounce)
            }
            .padding(.vertical, 5)
        }
    }
    
    // MARK: - Gradient Controls
    
    private var gradientControls: some View {
        GroupBox(label: Label("Gradient", systemImage: "slider.horizontal.3")) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Band Size")
                        Spacer()
                        Text("\(bandSize, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $bandSize, in: 0.1...1.0, step: 0.05)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Start Opacity")
                        Spacer()
                        Text("\(startOpacity, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $startOpacity, in: 0...1.0, step: 0.05)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Mid Opacity")
                        Spacer()
                        Text("\(midOpacity, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $midOpacity, in: 0...1.0, step: 0.05)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("End Opacity")
                        Spacer()
                        Text("\(endOpacity, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $endOpacity, in: 0...1.0, step: 0.05)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    // MARK: - Color Controls
    
    private var colorControls: some View {
        GroupBox(label: Label("Colors", systemImage: "paintpalette")) {
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Use Custom Colors", isOn: $useCustomColors)
                
                if useCustomColors {
                    ColorPicker("Start Color", selection: $startColor)
                    ColorPicker("Mid Color", selection: $midColor)
                    ColorPicker("End Color", selection: $endColor)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    // MARK: - Mode Controls
    
    private var modeControls: some View {
        GroupBox(label: Label("Mode", systemImage: "square.stack.3d.up")) {
            VStack(alignment: .leading, spacing: 15) {
                Picker("Shimmer Mode", selection: $selectedMode) {
                    ForEach(ShimmerModeOption.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                
                if selectedMode == .overlay {
                    Picker("Blend Mode", selection: $blendMode) {
                        Text("Source Atop").tag(BlendMode.sourceAtop)
                        Text("Normal").tag(BlendMode.normal)
                        Text("Multiply").tag(BlendMode.multiply)
                        Text("Screen").tag(BlendMode.screen)
                        Text("Overlay").tag(BlendMode.overlay)
                        Text("Plus Lighter").tag(BlendMode.plusLighter)
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    // MARK: - Preview Controls
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var previewControls: some View {
        GroupBox(label: Label("Preview Settings", systemImage: "eye")) {
            VStack(alignment: .leading, spacing: 15) {
                Toggle("Active", isOn: $isActive)
                
                VStack(alignment: .leading) {
                    Text("Preview Text")
                    TextField("Enter text", text: $previewText)
                        .textFieldStyle(.roundedBorder)
                        .focused($isTextFieldFocused)
                        .submitLabel(.done)
                        .onSubmit {
                            isTextFieldFocused = false
                        }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Font Size")
                        Spacer()
                        Text("\(Int(previewFontSize))pt")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $previewFontSize, in: 20...72, step: 1)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    // MARK: - Helper Methods
    
    private func resetToDefaults() {
        duration = 1.5
        delay = 0.25
        bounce = false
        bandSize = 0.3
        startOpacity = 0.3
        midOpacity = 1.0
        endOpacity = 0.3
        useCustomColors = false
        selectedMode = .mask
        blendMode = .sourceAtop
        previewText = "SwiftUI Shimmer"
        previewFontSize = 48
        isActive = true
    }
}

#if DEBUG
#Preview {
    ShimmerShowcase()
}
#endif
