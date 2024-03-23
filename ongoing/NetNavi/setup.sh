#!/bin/bash

# First Time Setup Process Commencing
echo "First Time Setup is Starting..."
echo "Please wait while we get you all set up"
echo "Setting Up Virtual Environment..."


# Create a virtual environment called .venv
python3 -m venv .venv

# Virtual Environment Created Successfully
echo "Virtual Environment Created Successfully!!"


# Create a run.sh script
cat <<EOF > run.sh
#!/bin/zsh
echo "Activating Virtual Environment"
. .venv/bin/activate
echo "Virtual Environment Activated Successfully"
EOF

# Give execute permission to run.sh
chmod +x run.sh

# Run Script Created Successfully
echo "run.sh script created successfully, to run use 'source {path/to/}run.sh' to activate the environment."

# Activating the project Environment
echo "Activating Virtual Environment"

# Activate the run.sh internally(only first time)
source run.sh

# Activated project's environment successfully
echo "Virtual Environment Activated Successfully"


# Installing project dependancies
echo "Installing project dependancies from requirement.txt file"

# Install required packages from requirements.txt
pip install -r requirements.txt

# Dependencies installed successfully
echo "Requirements Installed Successfully."


# Setup complete
echo "First Time Setup Completed Successfully!"

echo "Exiting...."


# Closing the Setup script
exit
