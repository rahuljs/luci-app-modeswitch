# luci-app-modeswitch

An OpenWrt LuCI application and hardware driver for the **TP-Link TL-MR3020 v1** 3-way physical mode switch (**3G**, **WISP**, **AP**).

---

## Features
- **Hardware Switch Visualizer:** Live interactive visual slider showing the real-time physical switch position using kernel GPIO state readings (`GPIO 18` and `GPIO 20`).
- **Software Override Support:** Change operational mode directly from the LuCI Web Interface without touching the physical router.
- **Hardware Override Protection:** Sliding the physical switch on the router casing immediately fires a kernel GPIO interrupt that overrides software selections and syncs with the physical switch.
- **Front Panel LED Feedback:** Drives the green **3G LED** (Solid ON for 3G/USBIP, Blinking for WISP, OFF for AP).

---

## Switch Mode Behaviors

| Switch Position | Mode | Network & Wi-Fi Behavior | 3G LED |
| :--- | :--- | :--- | :--- |
| **`AP`** (Right) | **Pure Access Point** | Wi-Fi AP (`OW-MR3020`) ON, Client OFF, LAN `192.168.1.1` | **OFF** |
| **`WISP`** (Middle) | **Wireless Repeater** | Wi-Fi AP (`OW-MR3020`) ON, Upstream Client (`Tulip` / WAN) ON | **Blinking** |
| **`3G`** (Left) | **USBIP & Media Sharing** | Wi-Fi AP ON, Upstream Client ON, `usbipd` Server running | **Solid ON** |

---

## Hardware GPIO Mapping

| Switch Position | `sw1` (GPIO 18) | `sw2` (GPIO 20) | Active Mode |
| :--- | :---: | :---: | :--- |
| **`3G`** (Left) | `hi` (`1`) | `lo` (`0`) | USBIP Server & Media Sharing |
| **`WISP`** (Middle) | `lo` (`0`) | `hi` (`1`) | Wireless Repeater |
| **`AP`** (Right) | `hi` (`1`) | `hi` (`1`) | Pure Access Point |

---

## Installation via Pre-compiled IPK

Copy the package to your router's `/tmp` directory and install with `opkg`:

```bash
# 1. Upload IPK to router
scp luci-app-modeswitch_1.0.0-1_all.ipk root@192.168.1.1:/tmp/

# 2. Install package
opkg install /tmp/luci-app-modeswitch_1.0.0-1_all.ipk

# 3. Refresh LuCI
rm -rf /tmp/luci-*
/etc/init.d/uhttpd restart
```

Access in LuCI under: **System** ➔ **Mode Switch** (`http://192.168.1.1/cgi-bin/luci/admin/system/modeswitch`).

---

## Building from OpenWrt SDK

1. Place the `luci-app-modeswitch` directory into your OpenWrt SDK `package/` folder:
   ```bash
   cp -r luci-app-modeswitch <openwrt-sdk-dir>/package/
   ```
2. Enable it in `make menuconfig`:
   ```
   LuCI -> 3. Applications -> luci-app-modeswitch
   ```
3. Compile the package:
   ```bash
   make package/luci-app-modeswitch/compile V=s
   ```
4. Output `.ipk` will be generated in `bin/packages/<arch>/luci/`.

---

## License
Licensed under GNU General Public License v3.0 (GPL-3.0-or-later).
