# Ubuntu Post-Installation Script for Hyper-V (No CUDA)

# Update packages
sudo apt update
sudo apt upgrade -y

# Install Python and pip
sudo apt install -y python3 python3-pip

# Install Visual Studio Code
sudo snap install code --classic

# Install VS Code extensions
code --install-extension ms-python.python
code --install-extension mtxr.sqltools
code --install-extension mtxr.sqltools-driver-pg
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension jithurjacob.nbpreviewer
code --install-extension eamodio.gitlens

# Install Azure Data Studio
wget -q https://go.microsoft.com/fwlink/?linkid=2160375 -O azuredatastudio-linux.deb
sudo apt install -y ./azuredatastudio-linux.deb
rm azuredatastudio-linux.deb

# Install Anaconda
wget -q https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O anaconda-installer.sh
bash anaconda-installer.sh -b -p $HOME/anaconda3
rm anaconda-installer.sh

# Activate Anaconda
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init bash
source ~/.bashrc

# Install Jupyter Notebook
conda install -y jupyter

# Install additional Python libraries for data science
conda install -y numpy pandas matplotlib scikit-learn plotly seaborn bokeh scikit-image nltk

# Install machine learning tools
conda install -y -c conda-forge xgboost lightgbm catboost

# Install database clients
sudo apt install -y mysql-client postgresql-client mongodb-clients sqlite3

# Install Git
sudo apt install -y git

# Install documentation and notebook tools
sudo apt install -y python3-sphinx pandoc
conda install -y nbconvert

echo "Hyper-V post-installation script completed."
