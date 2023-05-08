#!/bin/bash

# Creating the folder and opening it

cd "$(dirname "$0")" || exit
mkdir -p farmerbot_files && cd "$_" || exit

# Delete the files .env and nodes.md if they exist

rm -f .env
rm -f nodes.md

# SECTION 1: Creating the .env file

# Setting the Seed phrase
echo -n 'What is the mnemonic or HEX secret of your farm?'
echo
read answer 
echo SECRET=\"$answer\" >> .env
echo

while true; do

    echo -n 'What is the network? (main, test, qa, dev)?: '
    echo
    read answer 

    # Setting the Relay and Substrate
    if [ "$answer" = "main" ]; then
        # Setting the Network
        echo NETWORK=$answer >> .env
        # Relay
        echo RELAY=wss://relay.grid.tf:443 >> .env
        # Substrate
        echo SUBSTRATE=wss://tfchain.grid.tf:443 >> .env
        echo
        break
    elif [ "$answer" = "dev" ] || [ "$answer" = "test" ] || [ "$answer" = "qa" ]; then
        # Setting the Network
        echo NETWORK=$answer >> .env
        # Relay
        echo RELAY=wss://relay.$answer.grid.tf:443 >> .env
        # Substrate
        echo SUBSTRATE=wss://tfchain.$answer.grid.tf:443 >> .env
        echo
        break
    else
        echo
        echo "ERROR: The network must be either main, dev, qa or test."
        echo
    fi 
done

# SECTION 2: Creating the nodes.md file

# SECTION 2.1: Nodes Manager section

echo My nodes >> nodes.md

while true; do

    echo -n 'How many nodes do you have?'
    echo
    read nodes
    echo

    if (($nodes >= 1 && $nodes <= 1000)); then

        for ((i = 1; i <= nodes; i++))
        do 
            echo !!farmerbot.nodemanager.define >> nodes.md

            while true; do
                echo -n "What is your node ID? (node number $i)"
                echo
                read answer

                if (($answer >= 1)); then
                    echo -e '\t'id:$answer >> nodes.md
                    echo
                    break
                else
                    echo
                    echo "ERROR: The number must be a nonzero integer."
                    echo
                fi 
            done

            while true; do
                echo -n "What is the Twin ID?"
                echo
                read answer

                if (($answer >= 1)); then
                    echo -e '\t'id:$answer >> nodes.md
                    echo
                    break
                else
                    echo
                    echo "ERROR: The number must be a nonzero integer."
                    echo
                fi 
            done

            while true; do
                echo -n 'Should this node never be shut down? (true for yes, false for no) '
                echo
                echo 'OPTIONAL: Press ENTER to skip'
                read answer

                if [ "$answer" = "true" ] || [ "$answer" = "false" ] ; then
                    echo -e '\t'never_shutdown:$answer >> nodes.md
                    echo
                    break
                elif [ "$answer" == "" ]; then
                    break
                else
                    echo
                    echo "ERROR: Either answer true, false or press ENTER."
                    echo
                fi
            done

            while true; do
                echo -n 'How much the cpu can be overprovisioned? (between 1 and 4) (i.e. 2 means double the amount of cpus) '
                echo
                echo 'OPTIONAL: Press ENTER to skip'
                read answer
                if [ "$answer" = "" ]; then
                    break
                elif (($answer >= 1 && $answer <= 4)); then
                    echo -e '\t'cpuoverprovision:$answer >> nodes.md
                    echo
                    break
                else
                    echo
                    echo "ERROR: The number must be an integer and between 1 and 4 inclusively."
                    echo
                fi
            done

            while true; do
                echo -n 'Does the node have a public config? (true for yes, false for no) '
                echo
                echo 'OPTIONAL: Press ENTER to skip'
                read answer
                if [ "$answer" = "true" ] || [ "$answer" = "false" ] ; then
                    echo -e '\t'public_config:$answer >> nodes.md
                    echo
                    break
                elif [ "$answer" == "" ]; then
                    break
                else
                    echo
                    echo "ERROR: Either answer true, false or press ENTER."
                    echo
                fi
            done

            while true; do
                echo -n 'Is this a dedicated node? (true for yes, false for no) '
                echo
                echo 'OPTIONAL: Press ENTER to skip'
                read answer
                if [ "$answer" = "true" ] || [ "$answer" = "false" ] ; then
                    echo -e '\t'dedicated:$answer >> nodes.md
                    echo
                    break
                elif [ "$answer" == "" ]; then
                    break
                else
                    echo
                    echo "ERROR: Either answer true, false or press ENTER."
                    echo
                fi
            done

            while true; do
                echo -n 'Is this a certified node? (true for yes, false for no)'
                echo
                echo 'OPTIONAL: Press ENTER to skip'
                read answer
                if [ "$answer" = "true" ] || [ "$answer" = "false" ] ; then
                    echo -e '\t'certified:$answer >> nodes.md
                    echo -e >> nodes.md
                    echo
                    break
                elif [ "$answer" == "" ]; then
                    echo -e >> nodes.md
                    break
                else
                    echo
                    echo "ERROR: Either answer true, false or press ENTER."
                    echo
                fi
            done

        done
        break

    else

        echo
        echo "ERROR: The number must be a nonzero integer."
        echo
    fi  

done

# SECTION 2.2: Farmer Manager section

echo Farm configuration >> nodes.md
echo !!farmerbot.farmmanager.define >> nodes.md

while true; do

    echo -n 'What is your farm ID?'
    echo
    read answer

    if (($answer >= 1)); then
        echo -e '\t'id:$answer >> nodes.md
        echo
        break
    else
        echo
        echo "ERROR: The number must be a nonzero integer."
        echo
    fi 
done

while true; do
    echo -n 'How many public IPs do you have? '
    echo
    read answer

    if [[ "$answer" =~ ^[0-9]+$ ]]; then
        echo -e '\t'public_ips:$answer >> nodes.md
        echo -e >> nodes.md
        echo
        break
    else
        echo
        echo "ERROR: The number must be an integer."
        echo
    fi    
done

# SECTION 2.3: Power Manager section

echo Power configuration >> nodes.md
echo !!farmerbot.powermanager.configure >> nodes.md

while true; do
    echo -n 'What is your wake up threshold? (between 50 and 80)'
    echo
    read answer 

    if (($answer >= 50 && $answer <= 80)); then
        echo -e '\t'wake_up_threshold:$answer >> nodes.md
        echo
        break
    else
        echo
        echo "ERROR: The number must be an integer and between 50 and 80 inclusively."
        echo
    fi 
done

while true; do
    echo 'What is the periodic wake up? (e.g. 8:30AM or 10:30PM) (Always in UTC)'
    echo
    read answer

    if [[ "$answer" =~ ^(1[0-2]|[1-9]):([0-5]?[0-9])(AM|PM)$ ]]; then
        echo
        echo -e '\t'periodic_wakeup:$answer >> nodes.md
        break
    else
        echo
        echo "ERROR: The input should be in 12 hour format (e.g. 1:30AM or 12:30PM)."
        echo
    fi
done

while true; do
    echo -n 'What is the periodic wake up limit? (i.e. how many nodes can wake up at the same time) (minimum value = 1)'
    echo
    echo 'OPTIONAL: If you press ENTER, the default value will be taken, which is 1.'
    read answer
    if (($answer >= 1 && $answer <= 100)); then
        echo -e '\t'periodic_wakeup_limit:$answer >> nodes.md
        echo
        break
    elif [ "$answer" == "" ]; then
        break
    else
        echo
        echo "ERROR: The number must be an nonzero integer between 1 and 100."
        echo
    fi 
done