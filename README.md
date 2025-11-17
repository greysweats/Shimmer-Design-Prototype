# SwiftUI Shimmer

A lightweight, customizable shimmer effect for SwiftUI that adds elegant loading animations to your iOS, macOS, tvOS, and watchOS apps.

![SwiftUI](https://img.shields.io/badge/SwiftUI-Compatible-blue)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey)

---

## What is a Shimmer Effect?

A shimmer effect is a subtle, animated gradient that sweeps across UI elements to indicate loading states or placeholder content. Instead of showing a static "Loading..." message or a spinner, shimmer creates a polished, modern experience that suggests content is on its way.

**Common use cases:**
- Skeleton screens while fetching data
- Placeholder cards in feed layouts
- Loading states for images, text, or profiles
- Any situation where you want to show "something is happening"

---

## Visual Examples

### Basic Text Shimmer
```
┌─────────────────────────┐
│  SwiftUI Shimmer  ✨    │  ← Gradient sweeps left to right
└─────────────────────────┘
```

### Skeleton Loading Card
```
┌─────────────────────────┐
│  ┌───┐                  │
│  │ ○ │  ▓▓▓▓▓▓▓▓▓▓     │  ← Avatar + text placeholders
│  └───┘  ▓▓▓▓▓▓▓         │    with shimmer animation
│         ▓▓▓▓▓▓▓▓▓▓▓▓   │
└─────────────────────────┘
```

---

## Quick Start

### Installation

Add the package to your Xcode project or include the `Shimmer.swift` file directly.

### Basic Usage

```swift
import SwiftUI
import Shimmer

// Simply add .shimmering() to any view
Text("Loading...")
    .shimmering()

// Or apply to placeholder content
Rectangle()
    .fill(Color.gray.opacity(0.3))
    .frame(height: 20)
    .shimmering()
```

That's it! One line of code adds a professional shimmer effect.

---

## Customization Options

### For Designers: What You Can Control

| Parameter | What it does | Default | Range |
|-----------|-------------|---------|-------|
| **Duration** | How long one shimmer cycle takes | 1.5 seconds | 0.5s - 5s recommended |
| **Delay** | Pause between shimmer cycles | 0.25 seconds | 0s - 2s |
| **Bounce** | Should the shimmer reverse direction? | No (one-way) | Yes/No |
| **Band Size** | Width of the shimmer "light band" | 0.3 (30% of view) | 0.1 - 1.0 |
| **Opacity** | Transparency of gradient edges vs center | Start: 0.3, Mid: 1.0, End: 0.3 | 0.0 - 1.0 |
| **Colors** | Custom gradient colors | Black with varying opacity | Any colors |
| **Mode** | How shimmer applies to content | Mask | Mask, Overlay, Background |

### Visual Guide to Parameters

**Band Size** - Controls the width of the "shine"
```
Small (0.1):  ░░▓░░░░░░░  ← Thin, sharp highlight
Medium (0.3): ░░▓▓▓░░░░░  ← Balanced, natural look
Large (0.7):  ░▓▓▓▓▓▓▓░░  ← Wide, soft glow
```

**Duration** - Controls animation speed
- 0.5s = Fast, energetic (good for small elements)
- 1.5s = Balanced, professional (recommended default)
- 3.0s+ = Slow, calm (good for large surfaces)

**Bounce vs No Bounce**
- No bounce: → → → (continuous forward motion)
- Bounce: → ← → ← (back-and-forth, feels more "alive")

---

## Mode Comparison

### Mask Mode (Default)
The shimmer reveals/hides the content underneath.
- Best for: Text, icons, solid-colored shapes
- Creates: Classic "loading text" effect

### Overlay Mode
The shimmer gradient sits on top of content.
- Best for: Images, complex content you want to show through
- Creates: Glossy, reflective highlight effect
- Supports different blend modes (multiply, screen, etc.)

### Background Mode
The shimmer appears behind the content.
- Best for: Transparent or semi-transparent content
- Creates: Glowing background effect

---

## Code Examples

### Simple Loading Text
```swift
Text("Loading your profile...")
    .font(.headline)
    .shimmering()
```

### Custom Speed and Bounce
```swift
Text("Fetching data")
    .shimmering(
        animation: .linear(duration: 2.0)
            .delay(0.5)
            .repeatForever(autoreverses: true)
    )
```

### Skeleton Card Layout
```swift
VStack(alignment: .leading, spacing: 12) {
    // Profile image placeholder
    Circle()
        .fill(Color.gray.opacity(0.3))
        .frame(width: 60, height: 60)
    
    // Name placeholder
    Rectangle()
        .fill(Color.gray.opacity(0.3))
        .frame(height: 20)
    
    // Bio placeholder
    Rectangle()
        .fill(Color.gray.opacity(0.3))
        .frame(height: 14)
}
.shimmering()
```

### Custom Gradient Colors
```swift
Text("Premium Feature")
    .font(.title)
    .bold()
    .shimmering(
        gradient: Gradient(colors: [
            .purple.opacity(0.3),
            .white,
            .purple.opacity(0.3)
        ]),
        bandSize: 0.4
    )
```

### Conditional Shimmer (Toggle On/Off)
```swift
@State private var isLoading = true

Text("Content")
    .shimmering(active: isLoading)
```

### Overlay Mode with Blend
```swift
Image("photo")
    .shimmering(
        gradient: Gradient(colors: [.clear, .white.opacity(0.8), .clear]),
        bandSize: 0.5,
        mode: .overlay(blendMode: .plusLighter)
    )
```

---

## Interactive Showcase

The project includes `ShimmerShowcase.swift`, a fully interactive demo that lets you:

- Adjust all parameters with sliders in real-time
- Preview changes instantly
- Experiment with different modes and colors
- See how settings affect multiple sample views

**Perfect for:**
- Designers exploring visual options
- Developers finding the right settings
- Demonstrating capabilities to stakeholders

---

## Design Recommendations

### Loading States
- **Duration**: 1.5s (not too fast, not too slow)
- **Band Size**: 0.3 (standard)
- **Bounce**: Off (continuous motion feels like progress)

### Premium/Highlight Effects
- **Duration**: 2.0-3.0s (slower, more elegant)
- **Band Size**: 0.4-0.5 (wider, more noticeable)
- **Mode**: Overlay with light colors
- **Bounce**: On (creates a "breathing" effect)

### Subtle Background Animation
- **Duration**: 3.0s+ (very slow)
- **Opacity**: Lower values (0.1-0.2)
- **Mode**: Background or Overlay

### Accessibility Considerations
- Respect user's "Reduce Motion" settings
- Provide alternative loading indicators
- Don't rely solely on shimmer to convey information
- Consider users with vestibular disorders

---

## Right-to-Left Language Support

The shimmer automatically adjusts direction for RTL languages (Arabic, Hebrew, etc.), ensuring a natural visual flow that matches reading direction.

```swift
Text("مرحبًا")
    .shimmering()
    .environment(\.layoutDirection, .rightToLeft)
// Shimmer will sweep right-to-left
```

---

## Technical Details

### Requirements
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Swift 5.0+
- SwiftUI

### How It Works
1. Creates a linear gradient with customizable colors and opacity
2. Animates the gradient's position from one side to the other
3. Applies the gradient as a mask, overlay, or background
4. Repeats the animation indefinitely (or until disabled)

### Performance
- Lightweight: Uses native SwiftUI animations
- GPU-accelerated gradient rendering
- Minimal memory footprint
- Can be disabled dynamically without layout changes

---

## File Structure

```
SwiftUI-Shimmer/
├── Shimmer.swift           # Core shimmer modifier (< 150 lines)
└── ShimmerShowcase.swift   # Interactive demo app
```

---

## Tips for Best Results

1. **Match your brand**: Use subtle variations of your brand colors for a cohesive look
2. **Keep it simple**: The default settings work great for most cases
3. **Be consistent**: Use the same shimmer settings throughout your app
4. **Don't overdo it**: Shimmer is for loading states, not decoration
5. **Test on device**: Animations look different on real hardware vs simulator

---

## Common Patterns

### Skeleton Screen
Replace your entire content view with placeholder shapes that shimmer while data loads.

### Redacted Content (iOS 14+)
```swift
Text("Real content here")
    .redacted(reason: .placeholder)
    .shimmering()
```

### List Loading
```swift
ForEach(0..<5) { _ in
    SkeletonRow()
        .shimmering()
}
```

---

## License

This project is available under the MIT License.

---

## Credits

Created by Vikram Kriplaney. Contributions welcome!

---

## Need Help?

- Check the `ShimmerShowcase.swift` for interactive examples
- Review the code comments in `Shimmer.swift`
- Experiment with the showcase app to find your perfect settings
