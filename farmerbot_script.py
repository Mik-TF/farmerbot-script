import os
import re

# Creating the folder and opening it

# Name of new directory
directory = "farmerbot_files"
  
# Path to current directory
parent_dir = os.getcwd()

# Path to new directory added to current path
path = os.path.join(parent_dir, directory)
  
# Create the directory 

if not os.path.exists(path):
   os.makedirs(path)

os.chdir(path)

# Delete the files .env and config.md if they already exist

if os.path.exists(".env"):
  os.remove(".env")

if os.path.exists("config.md"):
  os.remove("config.md")

# SECTION 1: Creating the .env file
# Setting the seed phrase

this_file = open(".env", "w")
answer = input('What is the mnemonic or HEX secret of your farm? \n')
this_file.writelines('SECRET=\"'+answer+'\"\n')
print()

# Setting the network

while 1 > 0:
    
    answer = input('What is the network? (main, test, qa, dev)?  \n')
    print()
    if(answer == "main"):
        this_file.writelines('NETWORK='+answer+'\n')
        this_file.writelines('RELAY=wss://relay.grid.tf:443\n')
        this_file.writelines('SUBSTRATE=wss://tfchain.grid.tf:443\n')
        break
    elif(answer == "test" or answer == "qa" or answer == "dev" ):
        this_file.writelines('NETWORK='+answer+'\n')
        this_file.writelines('RELAY=wss://relay.'+answer+'.grid.tf:443\n')
        this_file.writelines('SUBSTRATE=wss://tfchain.'+answer+'.grid.tf:443\n')
        break
    else:
        print('ERROR: The network must be either main, dev, qa or test.')
        print()

this_file.close()

this_file = open("config.md", "w")
this_file.writelines('My nodes\n')

while 1 > 0:
    nodes = input('How many nodes do you have?  \n')  
    print()
    if(nodes.isdigit() and int(nodes) >= 1 and int(nodes) <= 1000):
        for i in range(int(nodes)):
            this_file.writelines('!!farmerbot.nodemanager.define\n')

            while 1 > 0:
                answer = input('What is your node ID? (node number ' + str(i+1) + ')\n')
                print()

                if(answer.isdigit() and int(answer) >= 1):
                    this_file.writelines('\tid:' + answer + '\n')
                    break
                else:
                    print('ERROR: The number must be a nonzero integer.')   
                    print() 

            while 1 > 0:
                answer = input('What is the Twin ID?\n')
                print()

                if(answer.isdigit() and int(answer) >= 1):
                    this_file.writelines('\ttwinid:' + answer + '\n')
                    break
                else:
                    print('ERROR: The number must be a nonzero integer.')   
                    print() 

            while 1 > 0:
                answer = input('Should this node never be shut down? (true for yes, false for no) \nOPTIONAL: Press ENTER to skip.\n')
                print()

                if(answer == "true" or answer == "false"):
                    this_file.writelines('\tnever_shutdown:' + answer + '\n')
                    break
                elif(answer == ""):
                    break
                else:
                    print('ERROR: Either answer true, false or press ENTER.')   
                    print() 

            while 1 > 0:
                answer = input('How much the cpu can be overprovisioned? (between 1 and 4) (i.e. 2 means double the amount of cpus)\nOPTIONAL: Press ENTER to skip.\n')
                print()

                if(answer.isdigit() and int(answer) >= 1 and int(answer) <= 4):
                    this_file.writelines('\tcpuoverprovision:' + answer + '\n')
                    break
                elif(answer == ""):
                    break
                else:
                    print('ERROR: The number must be an integer and between 1 and 4 inclusively.')   
                    print() 

            while 1 > 0:
                answer = input('Does the node have a public config? (true for yes, false for no)\nOPTIONAL: Press ENTER to skip.\n')
                print()

                if(answer == "true" or answer == "false"):
                    this_file.writelines('\tpublic_config:' + answer + '\n')
                    break
                elif(answer == ""):
                    break
                else:
                    print('ERROR: Either answer true, false or press ENTER.')   
                    print() 

            while 1 > 0:
                answer = input('Is this a dedicated node? (true for yes, false for no)\nOPTIONAL: Press ENTER to skip.\n')
                print()

                if(answer == "true" or answer == "false"):
                    this_file.writelines('\tdedicated:' + answer + '\n')
                    break
                elif(answer == ""):
                    break
                else:
                    print('ERROR: Either answer true, false or press ENTER.')   
                    print() 

            while 1 > 0:
                answer = input('Is this a certified node? (true for yes, false for no)\nOPTIONAL: Press ENTER to skip.\n')
                print()

                if(answer == "true" or answer == "false"):
                    this_file.writelines('\tcertified:' + answer + '\n')
                    break
                elif(answer == ""):
                    break
                else:
                    print('ERROR: Either answer true, false or press ENTER.')   
                    print() 
            this_file.writelines('\n')
        break
    else:
        print('ERROR: The number must be an nonzero integer.')
        print()

# SECTION 2.2: Farmer Manager section

this_file.writelines('Farm configuration\n')
this_file.writelines('!!farmerbot.farmmanager.define\n')

while 1 > 0:
    answer = input('What is your farm ID?  \n')  
    print()
    if(answer.isdigit() and int(answer) >= 1):
        this_file.writelines('\tid:' + answer + '\n')
        break
    else:
        print('ERROR: The number must be a nonzero integer.')   
        print() 

while 1 > 0:
    answer = input('How many public IPs do you have?\n')  
    print()
    if(answer.isdigit() and int(answer) >= 0):
        this_file.writelines('\tpublic_ips:' + answer + '\n')
        break
    else:
        print('ERROR: The number must be an integer.')   
        print() 

while 1 > 0:
    answer = input('What is your wake up threshold? (between 50 and 80)\n')  
    print()
    if(answer.isdigit() and int(answer) >= 50 and int(answer) <= 80):
        this_file.writelines('\twake_up_threshold:' + answer + '\n')
        break
    else:
        print('ERROR: The number must be an integer and between 50 and 80 inclusively.')   
        print() 
this_file.writelines('\n')

# SECTION 2.3: Power Manager section

this_file.writelines('Power configuration\n')
this_file.writelines('!!farmerbot.powermanager.define\n')

while 1 > 0:
    answer = input('What is the periodic wake up? (e.g. 8:30AM or 10:30PM) (Always in UTC)\n')  
    print()
    if(re.match("^(1[0-2]|[1-9]):([0-5]?[0-9])(AM|PM)$", answer)):
        this_file.writelines('\tperiodic_wakeup:' + answer + '\n')
        break
    else:
        print('ERROR: The input should be in 12 hour format (e.g. 1:30AM or 12:30PM).')   
        print() 

while 1 > 0:
    answer = input('What is the periodic wake up limit? (i.e. how many nodes can wake up at the same time) (minimum value = 1)\nOPTIONAL: If you press ENTER, the default value will be taken, which is 1.\n')  
    print()
    if(answer.isdigit() and int(answer) >= 1 and int(answer) <= 100):
        this_file.writelines('\tperiodic_wakeup_limit:' + answer + '\n')
        break
    elif(answer == ""):
        break
    else:
        print('ERROR: The number must be an nonzero integer between 1 and 100.')   
        print() 
this_file.close()
exit()