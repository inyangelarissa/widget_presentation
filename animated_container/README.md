# Flutter Animated Container Widget Demo

**Widget:** `Animated Container`    
**Course Widget Presentation**

---

## What is the AnimatedContainer Widget?

> A container that automatically animates between old and new values whenever its properties change — no animation controller required.

`AnimatedContainer` works exactly like a regular `Container`, except that whenever you change a property (size, color, shape), Flutter interpolates smoothly from the old value to the new one. This makes it one of the easiest ways to add polished animations to any Flutter app.

**Real-world scenario:** A music player app where the album art container changes size, color, and shape every time the user skips to a new track.

---

## How to Run

1. Clone this repo:https://github.com/inyangelarissa/widget_presentation
   ```bash
   git clone 
   cd animated_container_demo
   ```
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
---

## The Three Properties Demonstrated

### 1. `duration`
**What it does:** Controls how long the animation takes to complete.  
**Default:** There is no default — you must always provide a duration.  
**Effect:** `150ms` feels snappy and instant. `600ms` feels natural. `3000ms` feels slow and dreamy. In the demo you can switch between four duration options live and watch the album art animate at different speeds.

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 600), // try 150, 1500, 3000
  ...
)
```

---

### 2. `decoration`
**What it does:** Sets the container's visual style — background color and border radius — both of which animate automatically when changed.  
**Default:** `null` (no decoration).  
**Effect:** When you switch tracks in the demo, the container smoothly transitions from one colour (e.g. deep navy) to another (e.g. orange), and the corners reshape from rounded to circular. A developer uses this to give UI elements a fluid, living feel without writing any animation code.

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 600),
  decoration: BoxDecoration(
    color: track['color'],               // animates color change
    borderRadius: BorderRadius.circular(track['radius']), // animates shape
  ),
  ...
)
```

---

### 3. `width` & `height`
**What it does:** Sets the size of the container. When the values change, the container grows or shrinks smoothly.  
**Default:** `null` (sizes to its child).  
**Effect:** Each track in the demo has a different size (200–260px). Skipping tracks causes the album art to expand or contract with a smooth interpolation — no `Tween` or `AnimationController` needed. A developer uses this for expanding panels, progress indicators, or any element that needs to grow on interaction.

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 600),
  width: track['size'],   // animates width change
  height: track['size'],  // animates height change
  ...
)
```
---

## Project Structure

```
lib/
  main.dart     — complete app in a single file
pubspec.yaml    — dependencies
README.md       — this file
```

---

## Sources

- Flutter official AnimatedContainer docs: https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html
- Flutter AnimatedContainer cookbook: https://docs.flutter.dev/cookbook/animation/animated-container
