
<h1 align="center">
🎰 Bash Casino - Roulette Strategies
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Bash-Game-green?style=for-the-badge&logo=gnu-bash" />
  <img src="https://img.shields.io/badge/Terminal%20UI-Animated%20&%20Colored-blueviolet?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-MIT-purple?style=for-the-badge" />
</p>

![image](https://github.com/user-attachments/assets/1059a09d-633f-4612-8771-cec29ab11e38)


## About the Project

This is a **terminal-based casino roulette simulator** built with pure Bash, implementing two popular betting strategies:

-  **Martingale Technique** — double your bet after each loss
-  **Inverse Labouchère Technique** — grow your sequence with wins, reduce it with losses

Animated output, colorful interface, and a sleek ASCII-art banner make this script both educational and fun to play with.

> ⚠️ *Gambling is risky — even in a terminal.* This is for **educational purposes only** to understand probabilistic systems, recursion through loops, and shell scripting techniques.

---

## Features

-  Color-coded terminal UI (compatible with `lolcat`, `boxes`)
-  Dynamic betting logic based on outcome
-  Tracks max money reached
-  Ends game when balance hits zero
-  Elegant help panel
- 👾 Easily modifiable: great for pentesting-themed CTF-style games

---

## 📦 Requirements

- `bash` (v4+ recommended)
- `lolcat` (for colorful banners)  
  Install: `sudo gem install lolcat`
- `boxes` (for pretty output)  
  Install: `sudo apt install boxes`

---

## Usage

```bash
git clone https://github.com/venomcrane/Roulette.git
cd Roulette
chmod +x roulette.sh
./roulette.sh -m 1000 -t martingala
./roulette.sh -m 1000 -t inverseLabrouchere
```
## Help Panel 
![image](https://github.com/user-attachments/assets/fe932623-828d-4e12-a98c-60c8c0db38e9)

## Martingala Mode
![image](https://github.com/user-attachments/assets/a807e4dd-8df3-4184-a04c-3c50c00a56c8)

## Inverse Labouchère Technique
![inverse](https://github.com/user-attachments/assets/5e59e9d9-9d81-4371-8975-cafb7bc5c210)

## Learning Objectives

Perfect for:
- Practicing **array manipulation** in Bash
- Understanding **betting system logic**
- Enhancing terminal UI for Red Team tools
- Playing with **randomness and conditions**

---

> 💡 _"The house always wins, unless you script your way around it."_ – Anonymous Hacker

