#!/bin/zsh

# First Time Setup Process Commencing
echo "Hi, This is Al-Qaari's First-time Setup."
echo "I'm Abdullah & I'll be assisting you in the initial setup procedure, It shouldn't take too long Inshallah."
echo "Would you like to get started? (yes/no)(y/n)"
# shellcheck disable=SC2162
read answer


# Check if the user wants to begin first time Setup.
# Do something when the answer is yes or y
if [[ "$answer" == "no" || "$answer" == "n" ]]; then
    echo "Oh I see! Well Have a great a day & if you ever need help I'll be around."
    echo "Bye, Bye!"
    exit 1
    # Do something when the answer is yes or y
elif [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    echo "Oh that's Great to hear! I'm just here to help :)   Lets begin right away!"
else
    echo "I'm sorry but I didn't get that. Your input seems invalid"
    echo "Please try again & enter either a 'yes' or 'no' an 'n' or a 'y'."
    exit 1
fi

# macOS specific env
export PYTORCH_ENABLE_MPS_FALLBACK=1
# Getting The Project Directory
current_dir="${PWD}/documents/projects/ongoing/Qaari"
# Create a virtual environment called .venv
if python3 -m venv "${current_dir}/venv"; then
  echo "Virtual Environment Created Successfully!!"
else
  echo "Error Encountered While Attempting to make Virtual Environment, please ask Abubakr about this or try again."
  exit 1
fi


# Create a run.sh script
user_shell="${SHELL##*/}"
cat <<EOF > "${current_dir}/run.sh"
#!/bin/${user_shell}
echo "Activating Virtual Environment"
. "${current_dir}/venv/bin/activate"
echo "Virtual Environment Activated Successfully"
EOF


echo "run.sh file creation success."
# Give execute permission to run.sh
echo "Giving run.sh the necessary permission."
chmod +x "${current_dir}/run.sh"
echo "run.sh script ready: to run the project use 'source path/to/${current_dir}/run.sh' to activate the environment & run its contents."


# Restarting Shell, Applying the Recent Changes
echo 'Restarting The Current Shell & Applying The Recent Changes.'
exec "$SHELL"
echo "Running run.sh for the first time."
if source "${current_dir}/run.sh"; then
  echo "run.sh Executed Successfully!!"
else
  echo "Encountered an Error while trying running run.sh, please ask Abubakr about it or try again."
  exit 1
fi


echo "Installing project dependencies"
# Install required packages from requirements.txt
if pip install -r "${current_dir}/requirements.txt"; then
  echo "Installing Required Packages."
else
  echo "I can't seem to access your requirement.txt, you sure it's there? or should we try again or ask for help?"
  exit 1
fi


echo "Setting up 'The Retrieval-Voice-Conversion WebUI package."
echo "Cloning into RVC-WebUI's Github repo"
if git clone https://github.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI.git "${current_dir}/assets/RVC-WebUI"; then
  echo "RVC-WebUI github repository Forked Successfully!"
else
  echo "Something's not right, check your target disk or your internet connection. Else we could try again or get some help!"
  exit 1
fi
echo "Installing required dependencies for RVC-WebUI's package"
if pip install -r "${current_dir}/assets/RVC-WebUI/requirements-py311.txt"; then
  echo "Dependencies installed successfully."
else
  echo "Something's not right, lets try again or ask for some help, I'm sure we'll get through this easily, Inshallah."
  exit 1
fi
# Running RVC's Run.sh
if sh "${current_dir}/assets/RVC-WebUI/run.sh"; then
  echo "RVC-WebUi's run.sh executed successfully."
else
  echo "Something's not right, lets try again or ask for help, I'm sure we'll get through this easily, Inshallah."
  exit 1
fi


echo "Ughhh, Brb. Gonna Quickly Grab Those Pre-Trained Vocal Foundation Models."
echo "This may take a while!...... But it's the last time tho! I promise!!"
#Download all needed models from https://huggingface.co/lj1995/VoiceConversionWebUI/tree/main/
if python "${current_dir}/assets/RVC-WebUI/tools/download_models.py"; then
  echo "Wow, that took a while, but at least we finally have those Foundation Models!"
else
  echo "I am sorry but I wasn't able to get those models. check your internet or lets ask for some help grabbing those models."
  exit 1
fi
echo 'Saving Changes, Restarting Shell Session & Finishing up the setup.'
exec "$SHELL"
source "${current_dir}/run.sh"
source "${current_dir}/assets/RVC-WebUI/run.sh"
echo "Updates Saved & Setup Complete. Starting RVC-Infer Testing.."

# Running RVC-Webui Inference-WebGUI
if python "${current_dir}/assets/RVC-WebUi/infer-web.py"; then
  echo "RVC-WebUI inference Launched Successfully."
else
  echo "RVC-WebUI infer-web.py launch failed, but don't worry that's a simple issue to get through! Let's just ask a dev!"
exit 1
fi
echo "First Time Setup-Process Completed successfully, Alhamdulilah.          Have fun :)"
echo "but don't forget to use this technology responsibly, ain't gotta remind you but you know... God is watching you ;D"
