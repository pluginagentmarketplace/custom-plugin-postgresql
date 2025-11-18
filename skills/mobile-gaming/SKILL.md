---
name: mobile-gaming
description: Master mobile development with iOS, Android, React Native, and Flutter. Build cross-platform applications and games for smartphones and tablets.
---

# Mobile & Gaming Development

## Quick Start

### Swift Basics (iOS)
```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello, World!"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        label.text = "Button tapped!"
    }
}
```

### SwiftUI (Modern iOS)
```swift
import SwiftUI

struct ContentView: View {
    @State var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.title)

            Button("Increment") {
                count += 1
            }
            .padding()
        }
    }
}
```

### Kotlin Basics (Android)
```kotlin
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val button = findViewById<Button>(R.id.button)
        button.setOnClickListener {
            Toast.makeText(this, "Button clicked!", Toast.LENGTH_SHORT).show()
        }
    }
}
```

### React Native
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

export default function App() {
    const [count, setCount] = useState(0);

    return (
        <View style={styles.container}>
            <Text>Count: {count}</Text>
            <TouchableOpacity
                style={styles.button}
                onPress={() => setCount(count + 1)}
            >
                <Text>Increment</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, justifyContent: 'center' },
    button: { padding: 10, backgroundColor: '#007AFF' }
});
```

### Flutter
```dart
import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    int count = 0;

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(title: Text('Counter')),
                body: Center(
                    child: Column(
                        children: [
                            Text('Count: $count'),
                            ElevatedButton(
                                onPressed: () => setState(() => count++),
                                child: Text('Increment'),
                            )
                        ],
                    )
                ),
            ),
        );
    }
}
```

## Core Concepts

### 1. iOS Development
- Swift fundamentals
- UIKit components
- SwiftUI framework
- View controllers
- Core Data
- Networking

### 2. Android Development
- Kotlin syntax
- Activities and fragments
- Android Jetpack
- Composable functions
- Room database
- Navigation

### 3. Cross-Platform
- Shared codebase
- Native modules
- Platform channels
- Performance considerations
- Code sharing strategies

### 4. Game Development
- Game loop
- Physics engine
- Collision detection
- Sprite management
- Audio and graphics
- Input handling

### 5. Mobile-Specific
- Lifecycle management
- Battery optimization
- Memory management
- Responsive layouts
- Touch handling
- Permissions

## Tools & Technologies

### iOS Development
- **Xcode**: Apple's IDE
- **CocoaPods/SPM**: Package managers
- **Realm**: Mobile database
- **Alamofire**: Networking
- **Combine**: Reactive programming

### Android Development
- **Android Studio**: Official IDE
- **Gradle**: Build system
- **Room**: Local database
- **Retrofit**: HTTP client
- **RxJava**: Reactive programming

### Cross-Platform
- **React Native**: JavaScript/TypeScript
- **Flutter**: Dart language
- **Xamarin**: C#/.NET
- **Ionic**: Web technologies

### Game Engines
- **Unity**: C# game engine
- **Unreal Engine**: C++ engine
- **Godot**: Open-source engine
- **LibGDX**: Java framework

## Common Patterns

### Navigation
- Tab navigation
- Stack navigation
- Drawer navigation
- Bottom sheet navigation

### State Management
- MVVM pattern
- Clean Architecture
- Provider pattern
- Redux pattern

### Networking
- REST API integration
- GraphQL queries
- WebSocket connections
- SSL pinning

## Projects to Build

1. **Todo List App**
   - CRUD operations
   - Local storage
   - UI polish

2. **Weather App**
   - API integration
   - Location services
   - Data persistence

3. **E-commerce App**
   - Product listing
   - Shopping cart
   - Payment integration

4. **Social Media Clone**
   - Authentication
   - Real-time updates
   - Media handling

5. **Mobile Game**
   - Game mechanics
   - Scoring system
   - Leaderboards
   - Analytics

## Interview Tips

### Common Mobile Questions
- Explain app lifecycle
- How do you handle asynchronous operations?
- Difference between native and cross-platform
- How would you optimize app performance?
- Explain memory management

### Practical Challenges
- Build a feature in chosen platform
- Handle complex navigation
- Optimize performance
- Implement offline capabilities

## Best Practices

- Follow platform design guidelines
- Optimize battery usage
- Minimize app size
- Handle different screen sizes
- Proper error handling
- Security considerations
- Regular testing

## Advanced Topics

- Custom rendering
- Performance profiling
- Advanced animations
- Machine learning on mobile
- AR/VR integration
- Background processing
- Push notifications

## Performance Optimization

- Lazy loading
- Caching strategies
- Image optimization
- Reduce animation complexity
- Memory profiling
- Battery profiling
- Network optimization

---

For detailed information, visit the **Mobile Developer** roadmap at https://roadmap.sh/android or https://roadmap.sh/ios
