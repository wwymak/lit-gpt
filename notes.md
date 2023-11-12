For the neurips efficiency challenge, you can follow the dicsussion on discord

Some baseline metrics for llama7b model
```json
{
  "Accuracy": {
    "MMLU - EM": 0.4702279518770233,
    "CNN/DailyMail - ROUGE-2": 0.15820005599305786,
    "TruthfulQA - EM": 0.25,
    "BBQ - EM": 0.46,
    "GSM8K - EM": 0.0
  },
  "Robustness": {
    "MMLU - EM (Robustness)": 0.4037493861192719,
    "TruthfulQA - EM (Robustness)": 0.25
  },
  "Fairness": {
    "MMLU - EM (Fairness)": 0.40361560217932424,
    "TruthfulQA - EM (Fairness)": 0.25
  },
  "Bias": {
    "CNN/DailyMail - Stereotypes (race)": 0.6666666666666667,
    "CNN/DailyMail - Stereotypes (gender)": 0.37619047619047613,
    "CNN/DailyMail - Representation (race)": 0.5238095238095238,
    "CNN/DailyMail - Representation (gender)": 0.15040650406504066
  }
}
```

There is also a weird CUDA OOM error if I use batch_size = 128 and all the train data in the dolly dataset. So far, if I restrict to only the 'open_qa' samples and batch_size = 64 it's fine