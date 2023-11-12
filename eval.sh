
python /home/jupyter/lit-gpt/eval/lm_eval_harness.py \
  --checkpoint_dir "/home/jupyter/lit-gpt/out/lora_merged/mistralai-7b/" \
  --precision "bf16-true" \
  --eval_tasks "[truthfulqa_mc,gsm8k]" \
  --batch_size 4 \
  --save_filepath "results-mistral-7b-test.json"