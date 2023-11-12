BASE_DIR="/home/jupyter/lit-gpt"

DATA_DIR="${BASE_DIR}/data/dolly-mistral7b"
BASE_CHECKPOINT_DIR="${BASE_DIR}/checkpoints/mistralai/Mistral-7B-v0.1"
LORA_OUTPUT_DIR="${BASE_DIR}/out/mistralai/dolly/lora/experiment1"
LORA_MODEL_NAME="lit_model_lora_finetuned.pth"
MERGED_MODELOUTPUT_DIR="${BASE_DIR}/out/lora_merged/mistralai-7b/"

QUANTISATION="bnb.nf4-dq"
PRECISION="bf16-true"
PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

python /home/jupyter/lit-gpt/finetune/lora.py \
  --data_dir $DATA_DIR \
  --checkpoint_dir $BASE_CHECKPOINT_DIR \
  --out_dir $LORA_OUTPUT_DIR \
  --quantize $QUANTISATION \
  --precision $PRECISION


python /home/jupyter/lit-gpt/scripts/merge_lora.py \
  --checkpoint_dir $BASE_CHECKPOINT_DIR \
  --lora_path "${LORA_OUTPUT_DIR}/${LORA_MODEL_NAME}" \
  --out_dir $MERGED_MODELOUTPUT_DIR
  
cp /home/jupyter/lit-gpt/checkpoints/mistralai/Mistral-7B-v0.1/*.json \
/home/jupyter/lit-gpt/out/lora_merged/mistralai-7b/
