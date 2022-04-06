# Returns the version which is running now.
function miner_ver() {
    echo $MINER_LATEST_VER
}

# Not required
# Returns configured fork
function miner_fork() {
    echo $MINER_DEFAULT_FORK
}

# Outputs generated config file
function miner_config_echo() {
    export MINER_FORK=`miner_fork`
    local MINER_VER=`miner_ver`
    miner_echo_config_file "/hive/custom/${CUSTOM_NAME}/rentaflop-miner/rentaflop_config.json"
}

# Generates config file
function miner_config_gen() {
    git clone https://github.com/rentaflop/rentaflop-miner.git
    local MINER_CONFIG="/hive/custom/${CUSTOM_NAME}/rentaflop-miner/rentaflop_config.json"
    mkdir -p "/hive/custom/${CUSTOM_NAME}"
    ln -s "/hive/miners/custom/${CUSTOM_NAME}/h-run.sh" "/hive/custom/${CUSTOM_NAME}/h-run.sh"
    # exit if config already exists
    if [[ -f "$MINER_CONFIG" ]]; then
	exit 0
    fi

    wallet=$(echo $CUSTOM_TEMPLATE | cut -d "." -f 1)
    conf=`echo {\"wallet_address\": \"$wallet\"}`

    echo -e "$conf" | jq > $MINER_CONFIG
}

miner_config_gen
