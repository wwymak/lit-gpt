# Finetuning with Adapter

[LLaMA-Adapter](https://arxiv.org/abs/2303.16199) is a form of prefix-tuning that prepends a learnable adaption-prompt to the inputs of the attention blocks in LLaMA.

This technique can also be applied to the StableLM family of models.

If you are new to LLaMA-Adapter and are interest to learn more about how it works before proceeding with the finetuning guide below, you might find our article [Understanding Parameter-Efficient Finetuning of Large Language Models: From Prefix Tuning to LLaMA-Adapters](https://lightning.ai/pages/community/article/understanding-llama-adapters/) helpful.

## Preparation

The steps here only need to be done once:

1. Follow the instructions in the [README](README.md) to install the dependencies.
2. Download and convert the weights following our [guide](download_weights.md).
3. If you want to utilize more than one GPU, you should `pip install deepspeed`.
4. Download the data and generate the Alpaca instruction tuning dataset:

```bash
python scripts/prepare_alpaca.py --checkpoint_dir checkpoints/stabilityai/stablelm-base-alpha-3b
```

or [prepare your own dataset](#tune-on-your-dataset).

## Running the finetuning

```bash
python finetune_adapter.py --checkpoint_dir checkpoints/stabilityai/stablelm-base-alpha-3b
```

You can speed up training by setting the `devices` variable in the script to utilize more GPUs if available.
Depending on the available GPU memory, you can also tune the `micro_batch_size` parameter to utilize the GPU efficiently.

For example, the following settings will let you finetune the model in under 1 hour using DeepSpeed Zero-2:
```python
devices = 8
micro_batch_size = 8
```

This script will save checkpoints periodically to the `checkpoint_dir` directory.

## Test the model

You can test the finetuned model with your own instructions by running:

```bash
python generate_adapter.py \
    --prompt "Recommend a movie to watch on the weekend." \
    --checkpoint_dir checkpoints/stabilityai/stablelm-base-alpha-3b
```
Output:
```
A good movie to watch on the weekend would be The Lion King, since it's a classic family film that everyone can enjoy...
```
If your GPU supports `bfloat16`, the script will automatically use it.

## Tune on your dataset

With only a few modifications, you can prepare and train on your own instruction dataset.

1. Create a json file in which each row holds one instruction-response pair. 
   A row has an entry for 'instruction', 'input', and 'output', where 'input' is optional an can be 
   the empty string if the instruction doesn't require a context. Below is an example json file:

    ```
    [
        {
            "instruction": "Arrange the given numbers in ascending order.",
            "input": "2, 4, 0, 8, 3",
            "output": "0, 2, 3, 4, 8"
        },
        ...
    ]
    ```

2. Make a copy of `scripts/prepare_alpaca.py` and name it what you want:

    ```bash
    cp scripts/prepare_alpaca.py scripts/prepare_mydata.py
    ```

3. Modify `scripts/prepare_mydata.py` to read the json data file.
4. Run the script to generate the preprocessed, tokenized train-val split:

    ```bash
    python scripts/prepare_mydata.py --destination_path data/mydata/
    ```

5. Run `finetune_adapter.py` by passing in the location of your data (and optionally other parameters):
   
    ```bash
    python finetune_adapter.py --data_dir data/mydata/ --checkpoint_dir checkpoints/stabilityai/stablelm-base-alpha-3b
    ```


## Troubleshooting

If you run into a CUDA error "Expected is_sm80 to be true, but got false", uncomment the line
`torch.backends.cuda.enable_flash_sdp(False)` in the finetune script (see https://github.com/Lightning-AI/lit-llama/issues/101).