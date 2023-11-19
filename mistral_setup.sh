# python scripts/download.py --repo_id mistralai/Mistral-7B-v0.1
# python scripts/download.py --repo_id mistralai/Mistral-7B-Instruct-v0.1

# python scripts/convert_hf_checkpoint.py --checkpoint_dir checkpoints/mistralai/Mistral-7B-Instruct-v0.1
# python scripts/convert_hf_checkpoint.py --checkpoint_dir checkpoints/mistralai/Mistral-7B-v0.1

python scripts/download.py --repo_id meta-llama/Llama-2-7b-hf

python scripts/convert_hf_checkpoint.py --checkpoint_dir checkpoints/meta-llama/Llama-2-7b-hf