#!/bin/bash

clear

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi



case $PWD/ in   */Google-Assistant-Automated-Setup-Tool-master/) 
    ;;   *) 
    echo "Please run this in the Google-Assistant-Automated-Setup-Tool-master directory! "; exit;; 
esac

echo "Welcome to the Google Assistant Automated Setup Tool"
sleep 2
echo "By u/VanishingTacos aka Linux Lord"
sleep 2
clear
echo "A special thanks to Novaspirit Tech (https://goo.gl/8DZhea) for inspiring this project"
sleep 2
clear

#Update Database 
while true; do
    read -p "Do you wish to to update your database? Note: This is necessary to configure the script. (y/n)" yn
    case $yn in
        [Yy]* ) sudo updatedb; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Database was successfully updated!"
sleep 4

clear

#Test if Google Assistant is already setup
echo "Testing if Google Assistant is already setup"
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5

clear
	
	googlesamples_assistant=$(locate -n 1 /env/bin/googlesamples-assistant)

	setuptools=$(locate -n 1 /env/lib/python3.5/site-packages/setuptools)
	python_environment=$(locate -n 1 /env/bin/activate)

	setuptools=$(locate -n 1 /env/lib/python3.6/site-packages/setuptools)
	python_environment=$(locate -n 1 /env/bin/activate)
	source config.sh



	if [ -f "$python_environment" ] && [ -d "$setuptools" ] && [ -f "$googlesamples_assistant" ]
		then 
			while true; do
    read -p "It looks like you already have Google Assistant setup! Do you wish to start Google Assistant now? (y/n)" yn
    case $yn in

        [Yy]* ) source $python_environment; google-assistant-demo --project-id $project_id --device-model-id $device_model_id ;
		break;;
		[Nn]* )echo "okay..."; sleep 2; break;;
       	* ) echo "Please answer yes or no.";;
    esac
done
		else 
			echo "It looks like Google Assistant is not set up yet! The script will continue in 4 seconds."
			sleep 4
		fi
clear

#Configure a Developer Project and Account Settings
while true; do
    read -p "Please follow the directions at https://goo.gl/mCmiVh to configure a developer project and account settings. Do you wish to open the link? (y/n)" yn
    case $yn in
        [Yy]* )echo "Opening in 3 seconds"; sleep 3; x-www-browser https://goo.gl/mCmiVh; break;;
        [Nn]* )echo "Okay.."; sleep 2; break;; 
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Please make sure you have downloaded the client-secret.json file before you continue!"
read -n 1 -s -p "Press any key to continue"
sudo updatedb
clear

echo "Searching for client-secret.json ..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5

client_secret_json_path=$(locate -n 1 apps.googleusercontent.com.json)


if [ -f "$client_secret_json_path" ]
then
	echo "The client-secret.json has been found successfully at: $client_secret_json_path!"
	sleep 3
    clear
else
	echo "The client-secret.json failed to load! Will exit in 3 seconds..."
	sleep 2
	exit
fi



echo "Please wait while the system loads..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5
echo "Load complete..."
sleep .5

clear

#Update System
while true; do
    read -p "Do you wish to upgrade your system? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt update && sudo apt upgrade; echo "Upgrade completed successfully!"
sleep 2; break;;
		[Nn]* )echo "okay..."; break;;
       	* ) echo "Please answer yes or no.";;
    esac
done

clear

#Install python3-dev & python3-venv
while true; do
    read -p "Do you wish to install python3-dev & python3-venv? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt install python3-dev python3-venv
		break;;
        [Nn]* ) echo "Google Assistant set up failure"; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of python3-dev & python3-venv completed!"
sleep 2

clear

#Enable Python Environment 
while true; do
    read -p "Do you wish to enable the python environment? (y/n)" yn
    case $yn in
        [Yy]* ) python3 -m venv env; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sudo updatedb

clear

python_environment=$(locate -n 1 /env/bin/activate)

if [ -f "$python_environment" ]
then
	echo "The python environment has been loaded successfully!" 
	sleep 2
else
	echo "The python environment failed to load!"
	sleep 2
	exit
fi

clear

#Install setuptools 
while true; do
    read -p "Do you wish to install setuptools? (y/n)" yn
    case $yn in
        [Yy]* ) env/bin/python -m pip install --upgrade pip setuptools wheel; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of setuptools completed successfully!"
sleep 2

clear

#Enter the python environment 
while true; do
    read -p "Do you wish to enter the python environment now? (y/n)" yn
    case $yn in
        [Yy]* ) source "$python_environment"; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Python environment was successfully entered!"
sleep 2


clear

#Install google-assistant-library
while true; do
    read -p "Do you wish to install the Google Assistant library? (y/n)" yn
    case $yn in
        [Yy]* ) pip install google-assistant-library; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of Google Assistant library was completed successfully!"
sleep 2

clear

#Install the package's system dependencies
while true; do
    read -p "Do you wish to install the google-assistant's dependencies? (y/n)" yn
    case $yn in
        [Yy]* ) sudo apt install portaudio19-dev libffi-dev libssl-dev libmpg123-dev; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear


echo "Installation of Google Assistant library was completed successfully!"
sleep 2

#Install google-assistant-library
while true; do
    read -p "Do you wish to install the google-assistant-library? (y/n)" yn
    case $yn in
        [Yy]* ) python -m pip install --upgrade google-assistant-library==1.0.0; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

#Install google-assistant-sdk
while true; do

    read -p "Do you wish to install the google-assistant-sdk[samples]? (y/n)" yn
    case $yn in
        [Yy]* ) python -m pip install --upgrade google-assistant-sdk[samples]==0.5.1; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of google-assistant-sdk was completed successfully!"
sleep 2

clear

#Install oauth tool
while true; do
    read -p "Do you wish to install the Google oauth tool? (y/n)" yn
    case $yn in
        [Yy]* ) python -m pip install --upgrade google-auth-oauthlib[tool]; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear

echo "Installation of Google oauth tool was completed successfully!"
sleep 2

clear


#Authentication
while true; do
    read -p "Do you wish to authenticate now? (y/n)" yn
    case $yn in
        [Yy]* ) google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype --scope https://www.googleapis.com/auth/gcm --save --headless --client-secrets $client_secret_json_path; break;;
        [Nn]* ) echo "Google Assistant set up failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear


clear

echo "Authentication was performed successfully!"
read -n 1 -s -p "Press any key to continue"

clear

google=$(locate -n 1 Google.sh)
#Create easy access to Google Assistant

while true; do
    read -p "Would you like create easy access to Google Assistant? This would allow you to type "Google.sh" into the terminal at it would run Google Assistant. (y/n)" yn
    case $yn in
        [Yy]* ) sudo cp "$google" /usr/local/bin; echo "Now you can type "Google.sh" in a new terminal and will run Google Assistant"; break;;
        [Nn]* ) echo "Okay.."; sleep 2; break;; 
        * ) echo "Please answer yes or no.";;
    esac
done





#Start Google Assistant
while true; do
    read -p "Would you like to start Google Assistant now? (y/n)" yn
    case $yn in
        [Yy]* ) echo "Starting Google Assistant now..."
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
sleep .5
echo "Load complete..."
sleep .5

clear


google-assistant-demo

google-assistant-demo --project-id $project_id --device-model-id $device_model_id

 break;;
        [Nn]* ) echo "Google Assistant failure.."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac


done

done
