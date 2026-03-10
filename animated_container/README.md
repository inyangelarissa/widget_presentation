# Flutter AnimatedContainer Widget Demo

**Widget:** `AnimatedContainer`  
**Student:** Sonia Mutesi Uwase  
**Course Widget Presentation**

---

## What is the AnimatedContainer Widget?

> A container that automatically animates between old and new values whenever its properties change — no animation controller required.

`AnimatedContainer` works exactly like a regular `Container`, except that whenever you change a property (size, color, shape), Flutter interpolates smoothly from the old value to the new one. This makes it one of the easiest ways to add polished animations to any Flutter app.

**Real-world scenario:** A music player app where the album art container changes size, color, and shape every time the user skips to a new track.

---

## How to Run

1. Make sure Flutter is installed — [flutter.dev/get-started](https://flutter.dev/get-started)
2. Clone this repo:
   ```bash
   git clone 
   cd animated_container_demo
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

> Tested on Flutter 3.x. Works on Android, iOS, and Chrome (web).

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

## Screenshot

*(Replace this line with a screenshot after running `flutter run`)*

![App Screenshot](assets/screenshot.png)

---

## Project Structure

```
lib/
  main.dart     — complete app in a single file
pubspec.yaml    — dependencies
README.md       — this file
```

## Commit History

- `init: scaffold Flutter project`
- `feat: add track data model with color, size, and radius per track`  
- `feat: build AnimatedContainer album art with decoration and size`
- `feat: add duration selector — 4 speed options`
- `feat: add track switcher buttons and play/pause toggle`
- `feat: add sound bar animation and code snippet panel`
- `docs: complete README with run steps and attribute notes`

---

## Sources

- Flutter official AnimatedContainer docs: https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html
- Flutter AnimatedContainer cookbook: https://docs.flutter.dev/cookbook/animation/animated-container
