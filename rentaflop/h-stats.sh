rentaflop_id=$(jq '.rentaflop_id' /hive/miners/custom/rentaflop/rentaflop-miner/rentaflop_config.json)
daemon_port=$(jq '.daemon_port' /hive/miners/custom/rentaflop/rentaflop-miner/rentaflop_config.json)
stats_raw=$(echo {\"cmd\": \"status\", \"params\": {}, \"rentaflop_id\": $rentaflop_id} | curl -k -X POST -F "json=@-" https://localhost:$daemon_port)
if [[ $? -ne 0 || -z $stats_raw ]]; then
    echo -e "${YELLOW}Failed to reach rentaflop daemon${NOCOLOR}"
else
    khs=$(echo $stats_raw | jq '.state.khs')
    stats=$(echo $stats_raw | jq '.state.stats')
fi

[[ -z $khs ]] && khs=0
[[ -z $stats ]] && stats="null"
