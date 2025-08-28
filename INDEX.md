# Ubuntu Data Science Setup Scripts - Project Index

## Project Overview
This repository contains comprehensive automation scripts for setting up development environments for data science and machine learning workloads across different Ubuntu deployment scenarios. The project supports Ubuntu native installations, Windows Subsystem for Linux (WSL), and Hyper-V virtual machines.

## Repository Structure

```
DSWorkloadInstallScripts/
├── .git/                           # Git version control
├── README.md                       # Main project documentation
├── LICENSE                         # MIT License
├── INDEX.md                        # This comprehensive index file
├── ubuntu-hyper-v-setup.ps1       # PowerShell script for Hyper-V VM creation
├── ubuntu_post_install.sh         # Ubuntu native post-installation script
├── wsl_post_install.sh            # WSL post-installation script
└── hyper_v_post_install.sh        # Hyper-V VM post-installation script
```

## Scripts Overview

### 1. PowerShell Setup Script
**File:** `ubuntu-hyper-v-setup.ps1`
**Purpose:** Automates the creation of Ubuntu VMs on Hyper-V
**Features:**
- Downloads Ubuntu 24.04.1 LTS ISO automatically
- Creates new VM with 4GB RAM and Generation 2 configuration
- Configures DVD drive for ISO boot
- Downloads post-installation script
- Starts the VM automatically

**Prerequisites:**
- Hyper-V enabled on Windows
- Administrative PowerShell privileges
- Internet connection for downloads

### 2. Ubuntu Native Post-Installation
**File:** `ubuntu_post_install.sh`
**Purpose:** Sets up a complete data science environment on native Ubuntu installations
**Features:**
- **Core Tools:** Python 3.12+, pip, Git
- **Development Environment:** Visual Studio Code with data science extensions
- **Data Science Stack:** Anaconda 2024.02-1, JupyterLab
- **Python Libraries:** NumPy, Pandas, Matplotlib, Polars, Vaex, Dask, Xarray, Zarr
- **Machine Learning:** Scikit-learn, XGBoost, LightGBM, CatBoost, Transformers, PyTorch, TensorFlow
- **Database Support:** MySQL, PostgreSQL, MongoDB, SQLite clients
- **Documentation:** Sphinx, Pandoc, nbconvert
- **GPU Support:** CUDA Toolkit 11.4+, Canonical Data Science Stack
- **R Language:** R-base + RStudio Desktop 2024.06.0

### 3. WSL Post-Installation
**File:** `wsl_post_install.sh`
**Purpose:** Configures data science environment within Windows Subsystem for Linux
**Features:**
- **Complete toolset** matching Ubuntu native script
- **WSL-optimized** environment configuration
- **CUDA support** for GPU acceleration
- **VS Code integration** for seamless development
- **Canonical Data Science Stack** for advanced ML workloads

### 4. Hyper-V Post-Installation
**File:** `hyper_v_post_install.sh`
**Purpose:** Sets up data science environment on Ubuntu VMs running in Hyper-V
**Features:**
- **Complete data science stack** (excluding CUDA for VM compatibility)
- **Modern ML libraries** (Transformers, PyTorch, TensorFlow)
- **Containerization tools** (Docker, Kubernetes, Canonical DSS)
- **Optimized for virtual machine** performance and resource usage
- **Ubuntu 24.04.1 LTS** compatibility for latest features

## VS Code Extensions Installed

All scripts install the following VS Code extensions for enhanced data science development:

### **Core Data Science Extensions**
- **Python Support:** `ms-vscode.python` - Python language support
- **Jupyter Integration:** `ms-vscode.jupyter` - Jupyter notebook support
- **Data Version Control:** `ms-vscode.dvc` - Data version control
- **R Language Support:** `ms-vscode.r` - R language integration
- **Julia Support:** `ms-vscode.julia` - Julia language support

### **Database & SQL Tools**
- **SQL Tools:** `mtxr.sqltools` + PostgreSQL driver
- **PostgreSQL:** `ms-vscode.posgresql` - PostgreSQL management
- **MongoDB:** `ms-mongodb.mongodb-vscode` - MongoDB integration

### **Code Quality & Formatting**
- **Black Formatter:** `ms-vscode.black-formatter` - Python code formatting
- **isort:** `ms-vscode.isort` - Import sorting
- **Flake8:** `ms-vscode.flake8` - Python linting
- **Pylint:** `ms-vscode.pylint` - Advanced Python linting
- **Prettier:** `esbenp.prettier-vscode` - Code formatting

### **DevOps & Infrastructure**
- **Docker:** `ms-vscode.docker` - Docker container management
- **Kubernetes:** `ms-vscode.kubernetes` - K8s resource management
- **YAML:** `redhat.vscode-yaml` - YAML file support
- **PowerShell:** `ms-vscode.powershell` - PowerShell integration

### **Productivity & AI**
- **IntelliCode:** `VisualStudioExptTeam.vscodeintellicode` - AI-powered completions
- **GitLens:** `eamodio.gitlens` - Enhanced Git workflow
- **Notebook Preview:** `jithurjacob.nbpreviewer` - Notebook preview
- **GitHub Copilot:** `GitHub.copilot` - AI pair programming (optional)

### **Additional Recommended Extensions**
- **Remote Development:** `ms-vscode-remote.vscode-remote-extensionpack`
- **Python Docstring Generator:** `njpwerner.autodocstring`
- **Python Indent:** `kevinrose.python-indent`
- **Python Type Hint:** `njqdev.vscode-python-type-hint`
- **Jupyter Keymap:** `ms-toolsai.jupyter-keymap`
- **Jupyter Slide Show:** `ms-toolsai.jupyter-slideshow`

## Data Science Stack Components

### Python Ecosystem
- **Core:** Python 3, pip, Anaconda (2024.02-1)
- **Scientific Computing:** NumPy, Pandas, Matplotlib, Polars, Vaex, Dask, Xarray, Zarr
- **Machine Learning:** Scikit-learn, XGBoost, LightGBM, CatBoost, Transformers, PyTorch, TensorFlow
- **Visualization:** Plotly, Seaborn, Bokeh, Altair, Vega Datasets
- **Image Processing:** Scikit-image, OpenCV, Pillow
- **NLP:** NLTK, SpaCy, Gensim, Sentence-Transformers, WordCloud
- **Notebooks:** Jupyter, JupyterLab, nbconvert, Streamlit, Gradio, Panel, Dash
- **Optimization:** Optuna, Hyperopt, Scikit-optimize, Ray[Tune]
- **MLOps:** MLflow, Weights & Biases
- **Statistics:** Statsmodels, Pingouin
- **Graph Analysis:** NetworkX, Graphviz

### Database Support
- **Relational:** MySQL, PostgreSQL, SQLite
- **NoSQL:** MongoDB
- **Management:** Azure Data Studio

### Development Tools
- **IDE:** Visual Studio Code, RStudio
- **Version Control:** Git
- **Documentation:** Sphinx, Pandoc
- **GPU Acceleration:** CUDA Toolkit (where applicable)
- **Containerization:** Docker, Docker Compose
- **Orchestration:** Kubernetes, Helm, Kubectl
- **Web Development:** Node.js, npm
- **Code Quality:** Black, isort, Flake8, Pylint

### **Canonical Data Science Stack (Advanced)**
- **MicroK8s Integration:** Lightweight Kubernetes for local development
- **GPU-Enabled Containers:** Automatic GPU detection and driver handling
- **MLflow Integration:** Built-in experiment tracking and model management
- **Pre-built ML Environments:** Optimized containers for different ML workloads
- **Easy Environment Management:** Simple CLI for starting/stopping ML environments
- **Reproducible Workflows:** Identical environments across different machines
- **Enterprise Features:** Production-ready ML environment orchestration

## Installation Workflows

### Option 1: Native Ubuntu
1. Clone repository
2. Make script executable: `chmod +x ubuntu_post_install.sh`
3. Remove DOS characters if needed: `sed -i -e 's/\r$//' ubuntu_post_install.sh`
4. Run: `./ubuntu_post_install.sh`

### Option 2: WSL
1. Clone repository
2. Make script executable: `chmod +x wsl_post_install.sh`
3. Remove DOS characters if needed: `sed -i -e 's/\r$//' wsl_post_install.sh`
4. Run: `./wsl_post_install.sh`

### Option 3: Hyper-V VM
1. Run PowerShell script: `.\ubuntu-hyper-v-setup.ps1`
2. Follow VM setup prompts
3. Run post-installation script within VM: `./hyper_v_post_install.sh`

**Note:** PowerShell script now uses Ubuntu 24.04.1 LTS for latest features and security updates.

## Canonical Data Science Stack Usage

After installation, the Canonical Data Science Stack provides enterprise-grade ML environments:

### **Basic Commands**
```bash
# List available ML environments
data-science-stack list

# Start a GPU-enabled environment
data-science-stack start --gpu

# Connect to JupyterLab
data-science-stack connect

# Stop environments
data-science-stack stop

# Get help
data-science-stack --help
```

### **Advanced Features**
- **GPU Acceleration:** Automatic detection and optimization
- **Environment Isolation:** Separate containers for different projects
- **Data Persistence:** Mount local directories into containers
- **Multi-User Support:** Share environments across team members
- **Custom Images:** Build and deploy custom ML environments
- **Integration:** Seamless VS Code and JupyterLab integration

## System Requirements

### Minimum Requirements
- **RAM:** 4GB (8GB+ recommended for data science workloads)
- **Storage:** 20GB+ free space
- **OS:** Ubuntu 24.04.1 LTS or Windows 10/11 with WSL/Hyper-V
- **Network:** Internet connection for package downloads

### Recommended Requirements
- **RAM:** 16GB+
- **Storage:** 50GB+ SSD
- **GPU:** NVIDIA GPU with CUDA support (optional)
- **CPU:** Multi-core processor

## License
MIT License - See [LICENSE](LICENSE) file for details.

## Contributing
Contributions are welcome! Please submit pull requests or open issues for improvements.

## Repository Information
- **GitHub:** https://github.com/tomblanchard312/DSWorkloadInstallScripts
- **Author:** Tom Blanchard
- **Last Updated:** 2025-08-28
- **License:** MIT

## Notes
- **Ubuntu Version Consistency**: All scripts are optimized for Ubuntu 24.04.1 LTS
- Scripts automatically handle package updates and system upgrades
- CUDA installation is included in Ubuntu native and WSL scripts
- Hyper-V script excludes CUDA for broader compatibility
- All scripts include cleanup operations to remove temporary files
- VS Code extensions are automatically installed for immediate use
- Docker and Kubernetes tools are included for modern DevOps workflows
- RStudio is installed alongside R for enhanced statistical computing
- Latest Anaconda 2024.02-1 distribution is used across all scripts
- Modern data science libraries (Polars, Vaex, Transformers) are included
- MLOps tools (MLflow, Weights & Biases) are integrated for experiment tracking
- **Canonical Data Science Stack** provides advanced GPU-enabled containerized ML environments
- **MicroK8s integration** enables Kubernetes-native ML workload orchestration
- **Enhanced VS Code Experience** with 20+ extensions for professional development
- **Enterprise-Grade ML Workflows** with containerized, reproducible environments
- **Automatic GPU Optimization** for accelerated machine learning workloads
