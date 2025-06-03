#!/bin/bash

# Azure CLI script to check VNet integration outbound internet traffic for App Services and slots
# Requires: az cli logged in with appropriate permissions

echo "Checking VNet Integration outbound internet traffic for all App Services..."
echo "=================================================================="

# Get all subscriptions
subscriptions=$(az account list --query "[].id" -o tsv)

for sub_id in $subscriptions; do
    echo "Subscription: $sub_id"
    az account set --subscription "$sub_id"
    
    # Get all resource groups
    resource_groups=$(az group list --query "[].name" -o tsv)
    
    for rg in $resource_groups; do
        echo "  Resource Group: $rg"
        
        # Get all App Services with vnetRouteAllEnabled property
        apps=$(az webapp list -g "$rg" --query "[].{name:name, vnetRouteAll:vnetRouteAllEnabled}" -o json)
        
        # Parse each app
        echo "$apps" | jq -r '.[] | @base64' | while IFS= read -r app_data; do
            app_json=$(echo "$app_data" | base64 -d)
            app_name=$(echo "$app_json" | jq -r '.name')
            vnet_route_all=$(echo "$app_json" | jq -r '.vnetRouteAll')
            
            echo "    App Service: $app_name"
            
            if [ "$vnet_route_all" = "true" ]; then
                echo "      ✅ COMPLIANT: VNet Route All enabled"
            else
                echo "      ❌ NON-COMPLIANT: VNet Route All disabled"
            fi
            
            # Check deployment slots
            slots=$(az webapp deployment slot list -g "$rg" -n "$app_name" --query "[].{name:name, vnetRouteAll:vnetRouteAllEnabled}" -o json 2>/dev/null)
            
            if [ "$slots" != "[]" ] && [ "$slots" != "" ]; then
                echo "$slots" | jq -r '.[] | @base64' | while IFS= read -r slot_data; do
                    slot_json=$(echo "$slot_data" | base64 -d)
                    slot_name=$(echo "$slot_json" | jq -r '.name')
                    slot_vnet_route_all=$(echo "$slot_json" | jq -r '.vnetRouteAll')
                    
                    echo "      Slot: $slot_name"
                    
                    if [ "$slot_vnet_route_all" = "true" ]; then
                        echo "        ✅ COMPLIANT: VNet Route All enabled"
                    else
                        echo "        ❌ NON-COMPLIANT: VNet Route All disabled"
                    fi
                done
            fi
            echo ""
        done
    done
    echo ""
done

echo "VNet Integration check completed."