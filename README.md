# Automatic .env and config.md Script for Farmerbot (.sh and .py)

The following script generates the .env and config.md files for the Farmerbot.

The script is available for both python and bash.

This is a first draft. It should write the files properly. I set this as an [issue](https://github.com/threefoldtech/farmerbot/issues/33) to get feedback from the community and the dev team and then adjust accordingly.

***

## Steps to Create the Files

* Create a folder to store the script and the files
  * ```
    cd ~
    ```
  * ```
    mkdir -p farmerbot_script && cd "$_" || exit
    ```
* Download the script
  * Bash version
    * ```
      wget -O farmerbot_script.sh https://raw.githubusercontent.com/Mik-TF/farmerbot-script/main/farmerbot_script.sh
      ```
  * Python version
    * ```
      wget -O farmerbot_script.py https://raw.githubusercontent.com/Mik-TF/farmerbot-script/main/farmerbot_script.py
      ```
* Set the permissions to run the script
  * Bash version
    * ```
      chmod +x farmerbot_script.sh
      ```
  * Python version
    * ```
      chmod +x farmerbot_script.py
      ```
* Run the script
  * Bash version
    * ```
      sudo ./farmerbot_script.sh
      ```
  * Python version
    * ```
      python farmerbot_script.py
      ```
* Enter the values asked
* The .env and config.md files are saved in the folder /farmerbot_script/farmerbot_files

***

## Steps to See the Content of the Files

* Go to the newly created folder
  * ```
    cd farmerbot_files
    ```
* See the content of the file `config.md`
  * ```
    cat config.md
    ```
* See the content of the file `.env`
  * ```
    cat .env
    ```
