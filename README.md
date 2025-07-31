# 🌳 Grow Your Forest – Flutter Internship Project

Welcome to **Grow Your Forest**, a beautifully visual Flutter application where every healthy habit helps you grow a vibrant forest 🌿. Designed for the HealthTick Internship Challenge, this app visualizes habit-tracking as tree growth — crafted using **Flutter**, **Firebase (Firestore)**, and **CustomPainter**.

---

## 📱 App Concept

In *Grow Your Forest*, users build a personalized forest by completing **3 daily tasks**. Every time a day’s tasks are completed:

- A **tree grows** or **a new species is planted**
- Each tree species grows **stage by stage**
- The forest becomes more lush as progress continues!

---

## 🌲 Features

- 🎯 **Gamified Habit Tracking** – Complete 3 tasks daily to grow your forest  
- 🌳 **Custom Tree Rendering** – Every tree and stage is hand-drawn using `CustomPainter`
- 🔥 **Beautiful Forest UI** – Realistic positioning and smooth transitions for growth
- ☁️ **Cloud-Backed** – User progress and forest state stored in **Firebase Firestore**
- 🧠 **Clean Architecture** – Structured using `Riverpod`, with separation of core logic, models, services, and UI
- 🧪 **Growth Simulation** – Visualize your entire 30-day journey with tree progression

---

## 🔧 Tech Stack

- **Flutter**
- **Firebase Firestore**
- **Riverpod** (State Management)
- **CustomPainter** (Tree Rendering)
- **Clean Architecture** principles

---
## 🚀 Getting Started

### Prerequisites

Ensure the following are installed on your system:
- **Flutter SDK**: Version `>=3.4.4 <4.0.0`.
- **Dart SDK**.
- **Android/iOS Setup**: For Flutter development.

### Installation

1. **Clone the Repository**:
   ```bash  
   git clone https://github.com/AmbrishTripathi6974/Health_Tick_Test.git  
   ```  

2. **Install Dependencies**:
   ```bash  
   flutter pub get  
   ```  

3. **Set Up Firebase**:  
   Connect Firebase

    -> Set up your Firebase project

    -> Replace google-services.json and/or firebase_options.dart accordingly_KEY=your-anon-or-service-key  
   ```  

4. **Run the App**:
   ```bash  
   flutter run  
   ```  

---  

## 📦 Dependencies

A glimpse at the major dependencies:

| Dependency            | Version | Purpose                                  |  
|-----------------------|---------|------------------------------------------|  
| `flutter_bloc`        | ^8.1.6  | State management.                        |
| `dio`                 | ^5.7.0  | Advanced HTTP client.                    |  
| `go_router`           | ^14.6.1 | Simplified navigation management.        |  
| `custom_painter`      | ^2.2.3  | Design custom animation & design.        |  

For a complete list, check out the [`pubspec.yaml`](./pubspec.yaml).

--- 

## 🧬 Firebase Schema Overview

### 1. 🌿 Species Master Data

```json
{
  "speciesId": "species_1",
  "growthStages": 2,
  "stageParameters": {
    "1": { "height": 80, "width": 50, "color": "#6A994E" },
    "2": { "height": 120, "width": 70, "color": "#386641" }
  }
}
```  
---

### Credit 
> ✅ **Pro Tip:** After pasting this in your README.md, remember to:
- Replace your-username in the clone URL with your actual GitHub username.
- Replace [Your Name] at the end with your real name or GitHub handle.

Would you like a cover image or tree growth diagram added at the top of the README?

