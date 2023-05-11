import os
import regex

fn main() {

    // Regex functions
    is_int := regex.regex_opt("^[0-9]*$") or {panic(err)}
    is_12h_format := regex.regex_opt("^(1[0-2])|[0-9]:[0-5][0-9](AM)|(PM)$") or {panic(err)}

    // SECTION 0: Creating and going into the directory

    // Name of new directory
    directory := "farmerbot_files"

    // Path to current directory
    parent_dir := os.getwd()

    // Path to new directory added to current path
    this_path := parent_dir + "/" + directory

    // Create the directory 
    os.mkdir(this_path) or {}

    // Remove .env and config.md if they exist
    path_env := this_path + "/" + ".env"
    path_config := this_path + "/" + "config.md"

    os.rm(path_env) or {}
    os.rm(path_config) or {}

    // Change to new directory
    os.chdir(this_path) or {}

    // SECTION 1: Creating the .env file
    // Setting the seed phrase

    mut this_file := os.create(".env")!

    mut answer := os.input('\nWhat is the mnemonic or HEX secret of your farm? \n')

    this_file.writeln('SECRET=\"'+answer+'\"')!
    println("")

    // Setting the network

    for {

        answer = os.input('What is the network? (main, test, qa, dev)? \n')
        println("")

        if answer == "main" {

            this_file.writeln('NETWORK='+answer)!
            this_file.writeln('RELAY=wss://relay.grid.tf:443')!
            this_file.writeln('SUBSTRATE=wss://tfchain.grid.tf:443')!
            break

        } else if answer == "test" || answer == "qa" || answer == "dev" {

            this_file.writeln('NETWORK='+answer)!
            this_file.writeln('RELAY=wss://relay.'+answer+'.grid.tf:443')!
            this_file.writeln('SUBSTRATE=wss://tfchain.'+answer+'.grid.tf:443')!    
            break    

        } else {

            println('ERROR: The network must be either main, dev, qa or test.\n')

        }

    }

    this_file.close()

    // SECTION 2: Creating the config.md file
    // SECTION 2.1: Nodes Manager section

    // Create the file config.md
    this_file = os.create("config.md")!

    this_file.writeln('My nodes')!

    for {

        nodes := os.input('How many nodes do you have? \n')
        println("")

        if is_int.matches_string(nodes) && nodes.u32() >= 1 && nodes.u32() <= 1000 {

            mut i := 0
            for i <= (nodes.u32() - 1) {
                this_file.writeln('!!farmerbot.nodemanager.define')!

                for {
                    nbi := i + 1
                    nb := nbi.str()

                    answer = os.input('What is your node ID? (node number' + nb+ ')\n')
                    println("")

                    if is_int.matches_string(answer) && answer.u32() >= 1 {

                        this_file.writeln('\tid:' + answer)!
                        break

                    } else {
                        println('ERROR: The number must be a nonzero integer.\n')   
                    }
                }

                for {

                    answer = os.input('What is the Twin ID?\n')
                    println("")

                    if is_int.matches_string(answer) && answer.u32() >= 1 {

                        this_file.writeln('\ttwinid:' + answer)!
                        break

                    } else {
                        println('ERROR: The number must be a nonzero integer.\n')   
                    }
                }

                for {

                    answer = os.input('Does the node have a public config? (yes/no)\nOPTIONAL: Press ENTER to skip.\n')
                    println("")

                    if answer == "yes" {

                        this_file.writeln('\tpublic_config:true')!
                        break

                    } else if answer == "no" || answer == "" {   
   
                        break    

                    } else {

                        println('ERROR: Either answer yes, no or press ENTER.\n')

                    }

                }

                for {

                    answer = os.input('Should this node never be shut down? (yes/no) \nOPTIONAL: Press ENTER to skip.\n')
                    println("")

                    if answer == "yes" {

                        this_file.writeln('\tnever_shutdown:1')!
                        break
                        
                    } else if answer == "no" || answer == "" {
   
                        break    

                    } else {

                        println('ERROR: Either answer yes, no or press ENTER.\n')

                    }

                }

                for {

                    answer = os.input('Is this a dedicated node? (yes/no)\nOPTIONAL: Press ENTER to skip.\n')
                    println("")

                    if answer == "yes" {

                        this_file.writeln('\tdedicated:1')!
                        break

                    } else if answer == "no" || answer == "" {
   
                        break    

                    } else {

                        println('ERROR: Either answer yes, no or press ENTER.\n')

                    }

                }

                for {

                    answer = os.input('Is this a certified node? (yes/no)\nOPTIONAL: Press ENTER to skip.\n')
                    println("")
                    if answer == "yes" {

                        this_file.writeln('\tcertified:yes')!
                        break

                    } else if answer == "no" || answer == "" {
   
                        break    

                    } else {

                        println('ERROR: Either answer yes, no or press ENTER.\n')

                    }

                }

                for {

                    answer = os.input('How much the cpu can be overprovisioned? (between 1 and 4) (i.e. 2 means double the amount of cpus)\nOPTIONAL: Press ENTER to skip.\n')
                    println("")

                    if is_int.matches_string(answer) && answer.u32() >= 1 && answer.u32() <= 4 {

                        this_file.writeln('\tcpuoverprovision:' + answer)!
                        break

                        } else if answer == "" {
    
                            break    

                        } else {

                            println('ERROR: The number must be an integer and between 1 and 4 inclusively.\n')

                        }

                }

                this_file.writeln("")!
                i++
            }

            break

        } else {
            println('ERROR: The number must be an nonzero integer.')
            println("")
        }

    }

    // SECTION 2.2: Farmer Manager section

    this_file.writeln('Farm configuration')!
    this_file.writeln('!!farmerbot.farmmanager.define')!

    for {

        answer = os.input('What is your farm ID?  \n')
        println("")

        if is_int.matches_string(answer) && answer.u32() >= 1 {

            this_file.writeln('\tid:' + answer)!
            break

        } else {
            println('ERROR: The number must be a nonzero integer.\n')   
        }
    }

    for {

        answer = os.input('How many public IPs do you have?\n')
        println("")

        if is_int.matches_string(answer) && answer.u32() >=0 {

            this_file.writeln('\tpublic_ips:' + answer)!
            break

        } else {
            println('ERROR: The number must be an integer.\n')   
        }
    }

    this_file.writeln("")!

    // SECTION 2.3: Power Manager section

    this_file.writeln('Power configuration')!
    this_file.writeln('!!farmerbot.powermanager.define')!

    for {

        answer = os.input('What is your wake up threshold? (between 50 and 80)\n')
        println("")

        if is_int.matches_string(answer) && answer.u32() >=50 && answer.u32() <=80 {

            this_file.writeln('\twake_up_threshold:' + answer)!
            break

        } else {
            println('ERROR: The number must be an integer and between 50 and 80 inclusively.\n')   
        }
    }

    for {

        answer = os.input('What is the periodic wake up limit? (i.e. how many nodes can wake up at the same time) (minimum value = 1)\nOPTIONAL: If you press ENTER, the default value will be taken, which is 1.\n')
        println("")

        if is_int.matches_string(answer) && answer.u32() >=1 && answer.u32() <=100 {

            this_file.writeln('\tperiodic_wakeup_limit:' + answer)!
            break

        } else {
            println('ERROR: The number must be an integer and between 1 and 100 inclusively.\n')   
        }
    }

    for {

        answer = os.input('What is the periodic wake up? (e.g. 8:30AM or 10:30PM) (Always in UTC)\n')
        println("")

        if is_12h_format.matches_string(answer) {

            this_file.writeln('\tperiodic_wakeup:' + answer)!
            break

        } else {
                println('The input should be in 12-hour format (e.g. 1:30AM or 12:30PM).\n')   
        }
    }

    this_file.close()

}