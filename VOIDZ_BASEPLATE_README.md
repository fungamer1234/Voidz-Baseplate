# VOIDZ BASEPLATE — Fight on a Baseplate Combat Hub

Build: `2026-07-26` · Author: VOIDZ

Combat hub for Fight on a Baseplate with 30+ features across 8 tabs. VIM-based input engine for anti-cheat bypass.

## How to Use

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/fungamer1234/Voidz-Baseplate/main/VOIDZ_BASEPLATE.lua", true))()
```

Press **RightShift** to toggle the hub.

## Keybinds

| Key | Action |
|-----|--------|
| RightShift | Toggle Hub |
| M1 Click | Attack |
| Q | Weave / Parry |
| F | Block |
| R | Stomp |
| T | Slam |
| G | Grab |
| E | Push |

## Tabs & Features

| Tab | Features |
|-----|----------|
| Combat | Kill Aura, Auto Weave, Auto Block, Auto Stomp, Auto Slam, Auto Grab, Auto Push, Auto Parry |
| Hitbox | Hitbox Expander with adjustable size |
| ESP | Player ESP, Name Tags, Health Bars, Distance |
| Movement | Speed Boost, Fly, Noclip, Float, Anti-Void, Sprint-To-Target, Auto Follow |
| Defense | Anti-Aim, Anti-Grab, Anti-Kick |
| Utility | No-Collide, Spin, Infinite Jump, Bunny Hop, Reach Extender |
| Visual | Camera Shake removal, FPS Boost |
| Settings | Keybind config, theme, unload |

## Engine

Uses `VirtualInputManager:SendMouseButtonEvent` and `SendKeyEvent` to mimic real player input. Bypasses standard anti-cheat detection by sending legitimate-looking input events rather than hooking or modifying game internals.

## Based On

Research from l10scripts, Shrak, claudeWaffen, Swat07, Vongola, and Waffen input-mimicking methods.

## Credits

Part of the VOIDZ script collection. Built by **VOIDZ**.
