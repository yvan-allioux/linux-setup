import pyudev
import time
import os
import pyautogui

EXPECTED_KEY = "votre_cle_attendue"

context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)
monitor.filter_by(subsystem='usb')

def check_usb_key(device):
    for device in context.list_devices(subsystem='block', DEVTYPE='partition'):
        if 'ID_FS_TYPE' in device and device['ID_FS_TYPE'] == 'vfat':
            mount_point = f"/media/{os.getlogin()}/{device.device_node.split('/')[-1]}"
            key_file_path = os.path.join(mount_point, 'key.txt')
            if os.path.exists(key_file_path):
                with open(key_file_path, 'r') as key_file:
                    key = key_file.read().strip()
                    if key != EXPECTED_KEY:
                        pyautogui.hotkey('ctrl', 'l')

def device_event(observer, device):
    if device.action == 'add':
        check_usb_key(device)

observer = pyudev.MonitorObserver(monitor, callback=device_event)
observer.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()
