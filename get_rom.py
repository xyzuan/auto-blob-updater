from requests import get
from datetime import datetime as dt
import yaml

with open('violet.yml', 'wb') as load:
    load.write(get("https://raw.githubusercontent.com/XiaomiFirmwareUpdater/xiaomifirmwareupdater.github.io/master/data/devices/latest/violet.yml").content)
fw = yaml.safe_load(open('violet.yml').read())
stable_date = dt.strptime(fw[1]["date"], "%Y-%m-%d")
weekly_date = dt.strptime(fw_weekly[1]["date"], "%Y-%m-%d")
if stable_date > weekly_date:
    URL="https://bigota.d.miui.com/"
    version=fw_weekly[1]["versions"]["miui"]
    with open('/tmp/version','wb') as load:
        load.write(str.encode(version))
    URL+=version
    URL+="/"
    file=fw[1]["filename"]
    file=file[10:]
    URL+=file
    print("Fetching Stable ROM......")
else:
    URL="https://bigota.d.miui.com/"
    version=fw[3]["versions"]["miui"]
    with open('/tmp/version','wb') as load:
        load.write(str.encode(version))
    URL+=version
    URL+="/"
    file=fw[3]["filename"]
    file=file[10:]
    URL+=file
    print("Fetching Weekly ROM......")
with open('rom.zip', 'wb') as load:
    load.write(get(URL).content)
