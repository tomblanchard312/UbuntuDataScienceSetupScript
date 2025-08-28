# Ubuntu Data Science Setup Scripts 🚀

**Comprehensive automation scripts for setting up modern data science and machine learning development environments across Ubuntu, WSL, and Hyper-V deployments.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20%7C%2024.04-blue)](https://ubuntu.com/)
[![WSL](https://img.shields.io/badge/WSL-Supported-green)](https://docs.microsoft.com/en-us/windows/wsl/)
[![Hyper-V](https://img.shields.io/badge/Hyper--V-Supported-purple)](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/)

## ✨ What's New in 2025

- **🚀 Latest Tools**: Anaconda 2024.02-1, Python 3.12+, Ubuntu 24.04.1 LTS
- **🤖 Modern ML Stack**: PyTorch 2.0+, TensorFlow 2.15+, Transformers, FastAI
- **📊 Advanced Analytics**: Polars, Vaex, Dask, Xarray, Zarr for big data
- **🔧 DevOps Integration**: Docker, Kubernetes, MicroK8s, Canonical Data Science Stack
- **📱 Interactive Apps**: Streamlit, Gradio, Panel, Dash for web applications
- **🎯 MLOps Tools**: MLflow, Weights & Biases, Optuna, Ray[Tune]
- **💻 Enhanced IDE**: VS Code with 20+ data science extensions
- **🐳 Containerized ML**: GPU-enabled environments with Canonical Data Science Stack

## 🎯 What You Get

### **Complete Data Science Environment**
- **Python Ecosystem**: NumPy, Pandas, Matplotlib, Scikit-learn, Plotly, Seaborn
- **Machine Learning**: XGBoost, LightGBM, CatBoost, Transformers, PyTorch, TensorFlow
- **Big Data Tools**: Polars, Vaex, Dask, Xarray, Zarr for scalable computing
- **NLP & Vision**: SpaCy, Gensim, OpenCV, Pillow, Sentence-Transformers
- **Interactive Apps**: Streamlit, Gradio, Panel, Dash for rapid prototyping
- **Statistics**: R, RStudio, Statsmodels, Pingouin for advanced analytics

### **Enterprise-Grade Infrastructure**
- **Containerization**: Docker, Docker Compose for reproducible environments
- **Orchestration**: Kubernetes, Helm, Kubectl for scalable deployments
- **GPU Acceleration**: CUDA Toolkit, Canonical Data Science Stack with MicroK8s
- **MLOps**: MLflow, Weights & Biases for experiment tracking
- **Code Quality**: Black, isort, Flake8, Pylint for professional development

## 🚀 Quick Start

### **Option 1: Native Ubuntu (Recommended)**
```bash
# Clone and setup
git clone https://github.com/tomblanchard312/DSWorkloadInstallScripts.git
cd DSWorkloadInstallScripts

# Make executable and run
chmod +x ubuntu_post_install.sh
./ubuntu_post_install.sh
```

### **Option 2: Windows Subsystem for Linux (WSL)**
```bash
# Clone and setup
git clone https://github.com/tomblanchard312/DSWorkloadInstallScripts.git
cd DSWorkloadInstallScripts

# Make executable and run
chmod +x wsl_post_install.sh
./wsl_post_install.sh
```

### **Option 3: Hyper-V Virtual Machine**
```powershell
# Run PowerShell script (requires admin privileges)
Set-ExecutionPolicy Bypass -Scope Process -Force
.\ubuntu-hyper-v-setup.ps1
```

## 🛠️ Prerequisites

### **System Requirements**
- **Minimum**: 4GB RAM, 20GB storage, Ubuntu 24.04.1 LTS or Windows 10/11
- **Recommended**: 16GB+ RAM, 50GB+ SSD, NVIDIA GPU (optional)
- **Network**: Internet connection for package downloads

### **Windows Requirements (WSL/Hyper-V)**
- Windows 10/11 with WSL2 or Hyper-V enabled
- PowerShell with administrative privileges
- Virtualization enabled in BIOS

## 🔧 What Gets Installed

### **Core Development Tools**
- **Python 3.12+** with pip, venv, and build tools
- **Anaconda 2024.02-1** for package management
- **Git** for version control
- **Node.js & npm** for web development

### **Data Science Libraries**
- **Scientific Computing**: NumPy, Pandas, Matplotlib, Polars, Vaex
- **Machine Learning**: Scikit-learn, XGBoost, LightGBM, CatBoost
- **Deep Learning**: PyTorch, TensorFlow, Transformers, FastAI
- **Big Data**: Dask, Xarray, Zarr for scalable computing
- **Visualization**: Plotly, Seaborn, Bokeh, Altair, Vega Datasets
- **NLP & CV**: SpaCy, Gensim, OpenCV, Sentence-Transformers

### **Interactive & Web Applications**
- **JupyterLab** with enhanced extensions
- **Streamlit, Gradio, Panel, Dash** for rapid app development
- **RStudio** for statistical computing
- **Azure Data Studio** for database management

### **DevOps & Infrastructure**
- **Docker & Docker Compose** for containerization
- **Kubernetes tools** (kubectl, Helm) for orchestration
- **Canonical Data Science Stack** with MicroK8s for GPU-enabled containers
- **MLOps tools** (MLflow, Weights & Biases) for experiment tracking

### **VS Code Extensions (20+ Extensions)**
- **Python & Jupyter**: Python, Jupyter, DVC, R, Julia support
- **Code Quality**: Black, isort, Flake8, Pylint for formatting
- **DevOps**: Docker, Kubernetes, YAML support
- **Database**: SQL tools, PostgreSQL integration
- **Git**: GitLens for enhanced Git workflow

## 🌟 Advanced Features

### **Canonical Data Science Stack**
Our scripts now include the [Canonical Data Science Stack](https://github.com/canonical/data-science-stack) for enterprise-grade ML environments:

```bash
# After installation, use these commands:
data-science-stack start --gpu          # Start GPU-enabled ML environment
data-science-stack list                 # List available environments
data-science-stack connect              # Connect to JupyterLab
data-science-stack stop                 # Stop environments
```

**Benefits:**
- **Containerized ML Environments** with GPU support
- **MicroK8s Integration** for Kubernetes-native workflows
- **Automatic GPU Detection** and driver handling
- **MLflow Integration** for experiment tracking
- **Reproducible Environments** across machines

### **GPU Acceleration**
- **CUDA Toolkit 11.4+** for NVIDIA GPUs
- **Automatic GPU detection** and optimization
- **Containerized GPU access** via Canonical DSS
- **Multi-GPU support** for advanced workloads

## 📚 Usage Examples

### **Start a New Data Science Project**
```bash
# Create virtual environment
python3 -m venv myproject
source myproject/bin/activate

# Install additional packages
pip install streamlit plotly-dash

# Launch interactive app
streamlit run app.py
```

### **Use Canonical Data Science Stack**
```bash
# Start GPU-enabled environment
data-science-stack start --gpu

# Access JupyterLab
data-science-stack connect

# Run ML experiments with GPU acceleration
python train_model.py
```

### **Docker Development**
```bash
# Build and run container
docker build -t ml-app .
docker run -p 8501:8501 ml-app

# Use Docker Compose
docker-compose up -d
```

## 🔍 Troubleshooting

### **Common Issues**
1. **Permission Denied**: Ensure scripts are executable (`chmod +x`)
2. **DOS Characters**: Remove with `sed -i -e 's/\r$//' script.sh`
3. **CUDA Issues**: Check NVIDIA drivers and GPU compatibility
4. **WSL Issues**: Ensure WSL2 is enabled and updated

### **Getting Help**
- Check the [INDEX.md](INDEX.md) for detailed documentation
- Review script output for specific error messages
- Ensure all prerequisites are met
- Check system compatibility with Ubuntu version

## 🤝 Contributing

We welcome contributions! Please:

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly
5. **Submit** a pull request

### **Areas for Improvement**
- Additional VS Code extensions
- New data science libraries
- Platform-specific optimizations
- Documentation enhancements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Canonical** for the Data Science Stack
- **Microsoft** for VS Code and WSL
- **Open Source Community** for the amazing tools
- **Contributors** who help improve these scripts

## 📞 Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/tomblanchard312/DSWorkloadInstallScripts/issues)
- **Discussions**: [Join the community](https://github.com/tomblanchard312/DSWorkloadInstallScripts/discussions)
- **Documentation**: [Comprehensive INDEX.md](INDEX.md)

---

**⭐ Star this repository if it helped you set up your data science environment!**

**Made with ❤️ for the data science community**

    
