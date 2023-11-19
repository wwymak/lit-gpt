python scripts/prepare_dolly.py \
  --checkpoint_dir checkpoints/mistralai/Mistral-7B-v0.1 \
  --destination_path data/dolly-mistral7b/max_lenght_1024 \
  --max_seq_length 1024
  
# python scripts/prepare_dolly.py \
#   --checkpoint_dir checkpoints/meta-llama/Llama-2-7b-hf \
#   --destination_path data/dolly-llama2-7b/max_lenght_1024 \
#   --max_seq_length 1024