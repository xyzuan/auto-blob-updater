#!/bin/bash 

website_curl()
{
wget https://github.com/XiaomiFirmwareUpdater/miui-updates-tracker/tree/master/stable_fastboot -O page.htm
count_links
}

function count_links()
{
mapfile -t device_link < <( cat page.htm | grep -E "href=\"*.*yml\""| cut -d "<" -f3 | cut -d " " -f5 | cut -d "\"" -f2)
len=${#device_link[@]}
if [ $len -eq 0 ]; then
    exit 1
fi
echo $len
select_link

}

function select_link()
{
select id in "${device_link[@]}" 
do
    case "$device_nr" in
      *) device_nmbr=$(echo "https://github.com/${id}")
	 echo $device_nmbr
         export device_name=$(echo $device_nmbr | cut -d "/" -f10|cut -d "." -f1)
 	 export yaml_file=$( echo $device_nmbr | cut -d "/" -f10)
	 echo $yaml_file
	 echo "You choosed $device_name"
	 yaml_load
    esac
done
}

function yaml_load()
{
raw_file="https://raw.githubusercontent.com/XiaomiFirmwareUpdater/miui-updates-tracker/master/stable_fastboot/$yaml_file"
wget $raw_file
yaml_reader	
}

function yaml_reader() 
{
yml_http_link=$(grep "http" $yaml_file | cut -d " " -f2)
echo $yml_http_link
ota_filename=$(grep "filename" $yaml_file | cut -d " " -f2)
echo $ota_filename
rom_loader
exit
}

rom_loader()
{
wget $yml_http_link

}
website_curl

