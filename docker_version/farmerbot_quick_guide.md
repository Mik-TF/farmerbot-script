> This is not a final version. Not production ready.

<h1> ThreeFold Farmerbot Deployment </h1>

<h2> Table of Contents </h2>

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Steps to Create the Files](#steps-to-create-the-files)
- [Steps to Run the Farmerbot](#steps-to-run-the-farmerbot)
- [Questions and Feedback](#questions-and-feedback)

***

## Introduction

We present a quick way to deploy the Farmerbot. 

* In the first section, we create the files and the folder structure for the Farmerbot. 
* In the second section, we download and run the Farmerbot.


***

## Prerequisites

There are a few simple prerequisites to run smoothly the Farmerbot.

* The Farmerbot should be running on a Linux
* The installation requires to install and run [docker](https://docs.docker.com/engine/install/)


***

## Steps to Create the Files

Make sure that docker is installed and running.

* Create the parent folder
  * ```
    mkdir -p farmerbot && cd "$_" || exit
    ```
    * Note: you can choose a different name for your parent folder
* Download and run the file creator
  * Download the file creator
    * ```
      wget https://raw.githubusercontent.com/threefoldtech/farmerbot/development/file_creator_docker-compose.yaml
      ```
  * To run the file creator, write the following
    * ```
      docker run --name file_creator_container -v .:/farmerbot -ti file_creator_image:1.
      ```
  * Enter the values asked
  * The .env file is saved in the parent folder
  * The config.md file is saved in `config` within the parent folder


***

## Steps to Run the Farmerbot

* Download and run 
  * To download the Farmerbot `.yaml` file, write the following
  * ```
    wget https://raw.githubusercontent.com/threefoldtech/farmerbot/development/docker-compose.yaml
    ```
  * To run the Farmerbot, write the following
    * ```
      docker compose up -d
      ```

***

## Questions and Feedback

If you have any question, feel free to write a post on the ThreeFold Forum. You can also discuss with fellow farmers on the [ThreeFold Farmer Telegram Channel](https://t.me/threefoldfarmers).

If you can't find the answer to your question, our dedicated [ThreeFold Support](https://threefoldfaq.crisp.help/en/) team is here to help.