#!/bin/bash

# Creating the folder and opening it

cd ~ || exit
mkdir -p farmerbot_script && cd "$_" || exit

# Delete the files .env and nodes.md if they exist

rm -f .env
rm -f nodes.md

# SECTION 1: Creating .env file

# Setting the Seed phrase
echo -n 'What is your seed phrase?'
echo
read answer 
echo SECRET=\"$answer\" >> .env

echo -n 'What is the network? (main, test, qa, dev)?: '
echo
read answer 

# Setting the Network
echo NETWORK=$answer >> .env

# Setting the Relay and Substrate
if [ "$answer" = "main" ]; then
    # Relay
    echo RELAY=wss://relay.grid.tf:443 >> .env
    # Substrate
    echo SUBSTRATE=wss://tfchain.grid.tf:443 >> .env
elif [ "$answer" = "dev" ] || [ "$answer" = "test" ] || [ "$answer" = "qa" ]; then
    # Relay
    echo RELAY=wss://relay.$answer.grid.tf:443 >> .env
    # Substrate
    echo SUBSTRATE=wss://tfchain.$answer.grid.tf:443 >> .env
else
    echo "ERROR: The network must either main, dev, qa or test. Retry the script"
fi 

# SECTION 2: Creating the nodes.md file

# SECTION 2.1: Nodes Manager section

echo My nodes >> nodes.md

echo -n 'How many nodes do you have?'
echo
read nodes
for ((i = 1; i <= nodes; i++))
do 
    echo !!farmerbot.nodemanager.define >> nodes.md
    echo -n "What is your node ID? (node number $i)"
    echo
    read answer1
    echo -n "What is the Twin ID?"
    echo
    read answer2
    echo -e '\t'id:$answer1 >> nodes.md
    echo -e '\t'twinid:$answer1 >> nodes.md

    echo -n 'Should this node never be shut down? (true for yes, false for no) '
    echo
    echo 'OPTIONAL: Press ENTER to skip'
    read answer
    if [ "$answer" != "" ]; then
    echo -e '\t'never_shutdown:$answer >> nodes.md
    fi

    echo -n 'How much the cpu can be overprovisioned? (between 1 and 4) (i.e. 2 means double the amount of cpus) '
    echo
    echo 'OPTIONAL: Press ENTER to skip'
    read answer
    if [ "$answer" != "" ]; then
    echo -e '\t'cpuoverprovision:$answer >> nodes.md
    fi

    echo -n 'Does the node have a public config? (true for yes, false for no) '
    echo
    echo 'OPTIONAL: Press ENTER to skip'
    read answer
    if [ "$answer" != "" ]; then
    echo -e '\t'public_config:$answer >> nodes.md
    fi

    echo -n 'Is this a dedicated node? (true for yes, false for no) '
    echo
    echo 'OPTIONAL: Press ENTER to skip'
    read answer
    if [ "$answer" != "" ]; then
    echo -e '\t'dedicated:$answer >> nodes.md
    fi

    echo -n 'Is this a certified node? (true for yes, false for no)'
    echo
    echo 'OPTIONAL: Press ENTER to skip'
    read answer
    if [ "$answer" != "" ]; then
    echo -e '\t'certified:$answer >> nodes.md
    fi

    echo -e >> nodes.md
done

# SECTION 2.2: Farmer Manager section

echo -n 'What is your farm ID?'
echo
read answer1 
echo -n 'How many public IPs do you have? '
echo
read answer2 

echo Farm configuration >> nodes.md
echo !!farmerbot.farmmanager.define >> nodes.md
echo -e '\t'id:$answer1 >> nodes.md
echo -e '\t'public_ips:$answer2 >> nodes.md

echo -e >> nodes.md

# SECTION 2.3: Power Manager section

echo -n 'What is your wake up threshold? (between 50 and 80)'
echo
read answer1 
echo -n 'What is the periodic wake up? (e.g. 8:30AM or 10:30PM)'
echo
read answer2 
echo -n 'What is the periodic wake up limit? (i.e. how many nodes can wake up at the same time) (e.g. 1)'
echo
read answer3 

echo Power configuration >> nodes.md
echo !!farmerbot.powermanager.configure >> nodes.md
echo -e '\t'wake_up_threshold:$answer1 >> nodes.md
echo -e '\t'periodic_wakeup:$answer2 >> nodes.md
echo -e '\t'periodic_wakeup_limit:$answer3 >> nodes.md