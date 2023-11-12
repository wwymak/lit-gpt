cd /home/jupyter/lit-gpt
pip install -r requirements-all.txt
pip uninstall -y torch
pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/cu118

cd /home/jupyter/lm-evaluation-harness
pip install -e .

cp /home/jupyter/lit-gpt/bnb_env_vars_setup.py /opt/conda/lib/python3.10/site-packages/bitsandbytes/cuda_setup/env_vars.py