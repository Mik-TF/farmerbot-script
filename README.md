# Automatic .env and nodes.md Script for Farmerbot

The following script generates the .env and nodes.md files for the Farmerbot.

This is a first draft. It should write the files properly. I set this as an [issue](https://github.com/threefoldtech/farmerbot/issues/33) to get feedback from the community and the dev team and then adjust accordingly.

***

Steps

* Create a folder to store the script and files
  * ```
    cd ~
    ```
  * ```
    mkdir -p farmerbot_script && cd "$_" || exit
    ```
* Download the script
  * ```
    wget -O farmerbot_script.sh https://raw.githubusercontent.com/Mik-TF/farmerbot-script/main/farmerbot_script.sh
    ```
* Give permissions to run the script
  * ```
    chmod +x farmerbot_script.sh
    ```
* Run the script
  * ```
    sudo ./farmerbot_script.sh
    ```
* Enter the values asked
* The .env and nodes.md files are saved in the folder ~/farmerbot_script/farmerbot_files
