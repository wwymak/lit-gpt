set -xe -o pipefail

BASE_DIR="/home/jupyter/lit-gpt"
# MODEL_NAME="llama2-7b"
# MODEL_HF_PATH="meta-llama/Llama-2-7b-hf"
MODEL_NAME=mistral7b
MODEL_HF_PATH=mistralai/Mistral-7B-v0.1

# using the shorter variant in an attempt to reduce OO<
DATA_DIR="${BASE_DIR}/data/dolly-${MODEL_NAME}/max_lenght_1024"

BASE_CHECKPOINT_DIR="${BASE_DIR}/checkpoints/${MODEL_HF_PATH}"

LORA_OUTPUT_DIR="${BASE_DIR}/out/${MODEL_NAME}/dolly/lora/experiment2-max-seq-length-1024"
LORA_MODEL_NAME="lit_model_lora_finetuned.pth"
MERGED_MODELOUTPUT_DIR="${BASE_DIR}/out/lora_merged/${MODEL_NAME}/experiment2-max-seq-length-1024"

mkdir -p ${MERGED_MODELOUTPUT_DIR}

QUANTISATION="bnb.nf4-dq"
# QUANTISATION="bnb.int8-training"
PRECISION="bf16-true"
PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

python /home/jupyter/lit-gpt/finetune/lora.py \
  --data_dir $DATA_DIR \
  --checkpoint_dir $BASE_CHECKPOINT_DIR \
  --lora_model_name $LORA_MODEL_NAME \
  --out_dir $LORA_OUTPUT_DIR \
  --quantize $QUANTISATION \
  --precision $PRECISION

# --checkpoint_dir $BASE_CHECKPOINT_DIR \

python /home/jupyter/lit-gpt/scripts/merge_lora.py \
  --checkpoint_dir $BASE_CHECKPOINT_DIR \
  --lora_path "${LORA_OUTPUT_DIR}/${LORA_MODEL_NAME}" \
  --out_dir $MERGED_MODELOUTPUT_DIR
  
cp /home/jupyter/lit-gpt/checkpoints/mistralai/Mistral-7B-v0.1/*.json ${MERGED_MODELOUTPUT_DIR}
