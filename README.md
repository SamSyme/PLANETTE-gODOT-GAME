# 🚀 PLANETTE 🪐

A high-performance arcade system built with the Godot Engine, focused on **custom physics modeling**, **event-driven architecture**, and **efficient system design**.

This project demonstrates my ability to design and implement **scalable, low-overhead gameplay systems** using clean and modular code.

---

## 🎯 Key Highlights
- Designed a **custom orbital movement system** without relying on built-in physics  
- Implemented a **Finite State Machine (FSM)** for predictable and maintainable gameplay logic  
- Built a **decoupled architecture** using signals (observer pattern)  
- Optimized runtime performance by eliminating unnecessary physics calculations  

---

## 🧠 System Architecture

### ⚙️ State Machine (Core Logic)
- Handles player states: *idle → thrust → collision*  
- Ensures clean transitions and prevents state conflicts  
- Improves maintainability and scalability of gameplay logic  

---

### 🔗 Event-Driven Design
- Used **signals (observer pattern)** for communication between:
  - Player  
  - UI  
  - Game Manager  
- Eliminates tight coupling and improves code modularity  

---

### 🌀 Custom Orbital System ("Pivot Method")

Instead of using continuous gravitational force calculations, I engineered a **pivot-based orbital system**:

- The player and camera are attached to a central pivot
- Movement is achieved through **rotation transforms**, not physics simulation

#### ✅ Benefits
- **Near-zero CPU overhead**
- **No floating-point drift or jitter**
- **Consistent orbital radius (no corrective forces needed)**
- Easier to extend for new mechanics

---

### 🧱 Modular Design
- Node-based structure allows:
  - Easy addition of new obstacles  
  - Reusable gameplay components  
  - Rapid iteration without refactoring  

---

## 🛠️ Tech Stack
- **Engine:** Godot 4  
- **Language:** GDScript  
- **Concepts:**  
  - State Machines  
  - Event-Driven Architecture  
  - Custom Physics Systems  

---

## 📸 Preview
<img width="1029" height="832" alt="image" src="https://github.com/user-attachments/assets/08b55984-748c-40da-97e9-5fd2a719a1ad" />

---

## 🚀 Running the Project
1. Clone the repository  
2. Open `project.godot` in Godot 4.x  
3. Press `F5` to run  

---

## 🧩 What I LEARNED FROM This Project
- Ability to **replace engine systems with custom logic when needed**  
- Strong understanding of **performance vs abstraction tradeoffs**  
- Writing **clean, modular, and scalable code**  
- Applying **software engineering principles in real-time systems**  

---

*Built as a systems-focused project, not just a game.*
