# nerd-dictation — Setup Handoff

Offline voice-to-text (speech → typed keystrokes) for **Arch + Hyprland (Wayland)** on a ThinkPad X1 Carbon Gen 12.
Engine: **VOSK** (small local model, CPU-only, no GPU, no cloud, no account).

---

## Status

### ✅ Already done (no sudo needed)

- **VOSK model** downloaded and installed → `~/.config/nerd-dictation/model` (~68 MB)
- **Hyprland keybinds** added to `keybindings.conf`
  - Real file (symlink target): `~/dots-hyprland/hyprland/.config/hypr/keybindings.conf`
  - `Super + T` → **start** dictating (auto-stops after 2s silence)
  - `Super + Shift + T` → **stop** manually
  - Note: `T` = "talk". `D` (fullscreen) and `E` (file manager) were already bound.
- `parec` (PulseAudio recorder) already present — audio input is ready.

### ⏳ Remaining — run these 3 commands (need your sudo password)

```sh
yay -S nerd-dictation-git
sudo pacman -S ydotool
systemctl --user enable --now ydotool.service
```

- `yay -S nerd-dictation-git` → installs the `nerd-dictation` script + Python/VOSK deps (AUR, maintained, points at upstream `ideasman42/nerd-dictation`).
- `sudo pacman -S ydotool` → Wayland keystroke injector (`xdotool` does NOT work on Wayland).
- `systemctl --user enable --now ydotool.service` → starts the `ydotoold` daemon. **User** service (ships in `usr/lib/systemd/user/`), so **no sudo** on this one.

---

## Test it

1. Reload Hyprland config:
   ```sh
   hyprctl reload
   ```
2. Click into a text field (a terminal, editor, or chat box).
3. Hold **`Super + T`**, speak a sentence, pause ~2 seconds → text types itself in.

Manual CLI test (without keybinds):
```sh
nerd-dictation begin --simulate-input-tool=YDOTOOL --timeout 2 --vosk-model-dir=$HOME/.config/nerd-dictation/model
# ...speak, then it auto-ends after 2s silence...
```

---

## Troubleshooting

**Nothing types after speaking** → ydotool needs access to `/dev/uinput`. The package installs a udev rule for the `input` group:
```sh
groups | grep -q input || sudo usermod -aG input "$USER"
# then log out and back in (group change needs a fresh session)
```
Also confirm the daemon is running:
```sh
systemctl --user status ydotool.service
```

**Wrong/garbled words** → the small model trades accuracy for size. Upgrade to a larger model:
- Browse: https://alphacephei.com/vosk/models
- Download a bigger `vosk-model-en-us-*`, unzip, and replace `~/.config/nerd-dictation/model`
  (or point `--vosk-model-dir` at the new folder).

**No audio captured** → check the default source / mic isn't muted:
```sh
wpctl status        # confirm a default audio SOURCE exists
```

**Battery note** → speech recognition uses the CPU only while you're actively dictating
(no background process besides the lightweight ydotoold), so impact is small.

---

## Reference

| Item | Value |
|------|-------|
| Script (AUR) | `nerd-dictation-git` → `ideasman42/nerd-dictation` |
| Engine | VOSK-API (offline, CPU) |
| Model | `vosk-model-small-en-us-0.15` at `~/.config/nerd-dictation/model` |
| Audio recorder | `parec` (PulseAudio) — already installed |
| Input injector | `ydotool` (Wayland) via `--simulate-input-tool=YDOTOOL` |
| Daemon | `systemctl --user enable --now ydotool.service` |
| Keybinds file | `~/dots-hyprland/hyprland/.config/hypr/keybindings.conf` |
| Start / Stop | `Super + T` / `Super + Shift + T` |

Upstream docs: https://github.com/ideasman42/nerd-dictation
