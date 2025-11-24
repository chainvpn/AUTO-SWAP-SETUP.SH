# 🚀 One-Line Inline Installer

Run the entire script directly from GitHub **without downloading any files**:

```bash
bash <(curl -s https://raw.githubusercontent.com/chainvpn/AUTO-SWAP-SETUP.SH/refs/heads/main/AUTO-SWAP-SETUP.SH)
```

Or using **wget** alternative:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/chainvpn/AUTO-SWAP-SETUP.SH/refs/heads/main/AUTO-SWAP-SETUP.SH)
```

---

# 🔄 AUTO-SWAP-SETUP.SH

**Automatic Swap Detection & Configuration for Ubuntu 22.04+**

This script automatically detects your RAM, recommends an ideal swap size, lets you choose a custom value, safely rebuilds `/swapfile`, updates `/etc/fstab`, and applies performance optimizations like lowering `vm.swappiness` for smoother system performance.

---

## 📥 Install & Run (Inline Script)

### ✔ Recommended — *Inline Execution*

Run instantly, nothing to download:

```bash
bash <(curl -s https://raw.githubusercontent.com/chainvpn/AUTO-SWAP-SETUP.SH/refs/heads/main/AUTO-SWAP-SETUP.SH)
```

---

## 🧠 Features

* Auto-detects your RAM
* Recommends best swap size
* Lets you choose custom swap size
* Safely recreates `/swapfile`
* Fixes permissions
* Formats swap + activates it
* Updates `/etc/fstab`
* Sets `vm.swappiness=10`

---

## 📏 Recommended Swap Sizes

| RAM Amount | Recommended Swap |
| ---------- | ---------------- |
| ≤ 2 GB     | 4 GB             |
| ≤ 4 GB     | 4 GB             |
| ≤ 8 GB     | 4 GB             |
| ≤ 16 GB    | 2 GB             |
| > 16 GB    | 1 GB             |

---

## 🧪 Example Output

```
Detected RAM: 1.92 GB
Recommended Swap Size: 4 GB

Choose swap size:
1) 4 GB (recommended)
2) Custom size
Enter option:
```

On completion:

```
Swap setup complete!
Swap size: 4 GB
Swappiness set to 10
```

---

## 🛠 Requirements

* Ubuntu **22.04 or newer**
* Root access (`sudo`)
* System uses `/swapfile` (Ubuntu default)

---

## 📝 License

MIT License — free to use and modify.


