az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
export RESOURCE_GROUP="serverless_and_ai"
export MY_CLUSTER="energy-usage-aks"
export LOCATION="eastus"
export SUBSCRIPTION="13ae0661-466f-4189-9095-cbd2e68a485f"
export MY_VM="energy-usage-vm"
export myNSG="myNSG"
az account set --subscription $SUBSCRIPTION
az aks get-credentials --resource-group $RESOURCE_GROUP --name $MY_CLUSTER

az vm extension set --resource-group $RESOURCE_GROUP --vm-name $MY_VM --name WindowsOpenSSH --publisher Microsoft.Azure.OpenSSH --version 3.0

az network nsg rule create -g $RESOURCE_GROUP --nsg-name $myNSG -n allow-SSH --priority 1000 --source-address-prefixes 208.130.28.4/32 --destination-port-ranges 22 --protocol TCP


# python -m llama_recipes.finetuning  --use_peft --peft_method lora --quantization  --dataset samsum_dataset --model_name /mnt/c/llm/llama-2-7b-chat --output_dir /mnt/c/llm/output-llama-2-7b-chat

ln -s  /mnt/c/llm/llama_hf llama_hf

python -m llama_recipes.finetuning --dataset "custom_dataset" --custom_dataset.file "examples/custom_dataset.py:get_foo" # [TRAINING PARAMETERS]
