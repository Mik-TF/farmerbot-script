# ThreeFold Farmerbot Deployment

We present a quick way to deploy the Farmerbot. 

* In the first section, we create the files and the folder structure for the Farmerbot. 
* In the second section, we download and run the Farmerbot.

***

## Steps to Create the Files

* Create the parent folder
  * ```
    cd ~
    ```
  * ```
    mkdir -p farmerbot_docker && cd "$_" || exit
    ```
    * Note: you can choose a different name for your parent folder
* Download and run the file creator
  * Download the file creator
    * ```
      wget -O fbot_file_creator.v https://raw.githubusercontent.com/Mik-TF/farmerbot-script/main/fbot_file_creator.v
      ```
  * Run the file creator
    * Download [Vlang](https://vlang.io/)
    * ```
      v run farmerbot_script.v
      ```
  * Enter the values asked
  * The .env file is saved in the parent folder
  * The config.md file is saved in `config` within the parent folder

***

## Steps to Run the Farmerbot

* Install [docker](https://docs.docker.com/engine/install/)
* To download the Farmerbot, write the following
  * ```
    wget https://raw.githubusercontent.com/threefoldtech/farmerbot/development/docker-compose.yaml
    ```
* To run the Farmerbot, write the following
  * ```
    docker compose up -d
    ```
