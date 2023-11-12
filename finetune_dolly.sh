python /home/jupyter/lit-gpt/finetune/lora.py \
  --data_dir data/dolly-mistral7b \
  --checkpoint_dir "checkpoints/mistralai/Mistral-7B-v0.1" \
  --out_dir "out/mistralai/dolly/lora/experiment1" \
  --quantize "bnb.nf4-dq" \
  --precision "bf16-true"
  