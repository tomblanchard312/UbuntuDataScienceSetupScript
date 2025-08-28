#!/bin/bash

# Update package repositories and upgrade existing packages
sudo apt update
sudo apt upgrade -y

# Install Python and pip
sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential

# Install Visual Studio Code
sudo snap install code --classic

# Install VS Code extensions
code --install-extension ms-python.python
code --install-extension mtxr.sqltools
code --install-extension mtxr.sqltools-driver-pg
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension jithurjacob.nbpreviewer
code --install-extension eamodio.gitlens
code --install-extension ms-vscode.black-formatter
code --install-extension ms-vscode.isort
code --install-extension ms-vscode.flake8
code --install-extension ms-vscode.pylint
code --install-extension ms-vscode.docker
code --install-extension ms-vscode.kubernetes
code --install-extension redhat.vscode-yaml
code --install-extension ms-vscode.powershell

# Install Azure Data Studio
wget -q https://go.microsoft.com/fwlink/?linkid=2160375 -O azuredatastudio-linux.deb
sudo apt install -y ./azuredatastudio-linux.deb
rm azuredatastudio-linux.deb

# Install Anaconda (Latest version)
wget -q https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh -O anaconda-installer.sh
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
conda install -y -c conda-forge polars vaex dask xarray zarr
conda install -y -c conda-forge jupyterlab jupyter-server-proxy
conda install -y -c conda-forge ipywidgets ipympl
conda install -y -c conda-forge streamlit gradio panel dash
conda install -y -c conda-forge altair vega_datasets
conda install -y -c conda-forge opencv pillow
conda install -y -c conda-forge networkx graphviz
conda install -y -c conda-forge statsmodels pingouin

# Install machine learning tools
conda install -y -c conda-forge xgboost lightgbm catboost
conda install -y -c conda-forge transformers torch torchvision torchaudio
conda install -y -c conda-forge tensorflow tensorflow-gpu
conda install -y -c conda-forge optuna hyperopt
conda install -y -c conda-forge mlflow wandb
conda install -y -c conda-forge scikit-optimize ray[tune]
conda install -y -c conda-forge fastai
conda install -y -c conda-forge sentence-transformers
conda install -y -c conda-forge spacy
conda install -y -c conda-forge gensim
conda install -y -c conda-forge wordcloud

# Install database clients
sudo apt install -y mysql-client postgresql-client mongodb-clients sqlite3

# Install Git
sudo apt install -y git

# Install Docker
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

# Install Kubernetes tools
sudo apt install -y kubectl helm
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install documentation and notebook tools
sudo apt install -y python3-sphinx pandoc
conda install -y nbconvert

# Install additional development tools
sudo apt install -y nodejs npm
sudo npm install -g @jupyterlab/application
sudo npm install -g @jupyterlab/notebook
sudo npm install -g @jupyterlab/terminal

# Install Canonical Data Science Stack (Optional - Advanced GPU-enabled containers)
echo "Installing Canonical Data Science Stack for advanced ML workloads..."
sudo snap install microk8s --classic
sudo snap install data-science-stack --classic
sudo usermod -aG microk8s $USER
sudo chown -f -R $USER ~/.kube
microk8s status --wait-ready
microk8s enable gpu
microk8s enable registry
microk8s enable dns
echo "Data Science Stack installed. Run 'data-science-stack --help' for usage."

# Install R and RStudio
sudo apt install -y r-base r-base-dev
wget -q https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2024.06.0-561-amd64.deb -O rstudio.deb
sudo apt install -y ./rstudio.deb
rm rstudio.deb

# Install CUDA Toolkit (NVIDIA instructions)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.4.0/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.0-470.42.01-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.0-470.42.01-1_amd64.deb
sudo apt-key add <path_to_key_file>  # Replace <path_to_key_file> with the path to the key file

echo "WSL post-installation script completed."
