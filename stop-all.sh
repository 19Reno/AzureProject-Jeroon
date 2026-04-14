#!/bin/bash
echo "Stopping everything..."
az aks delete -g AzureProject -n aks-shopflow --yes --no-wait 2>/dev/null
az aks delete -g AzureProject -n aks-firstazure --yes --no-wait 2>/dev/null
az vm deallocate -g AzureProject -n firstazure 2>/dev/null
az postgres flexible-server stop -g AzureProject -n psql-shopflow-jeroon 2>/dev/null
echo "Done. All compute stopped."
