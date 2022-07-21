#!/usr/bin/env bashio
# shellcheck shell=bash

##############
# Initialize #
##############

HOME="/config/addons_config/epicgamesfree"
if [ ! -f "$HOME"/config.json ]; then
    # Copy default config.json
    cp /templates/config.json "$HOME"/config.json
    chmod 777 "$HOME"/config.json
    bashio::log.warning "A default config.json file was copied in $HOME. Please customize according to https://github.com/claabs/epicgames-freegames-node#json-configuration before restarting the addon"
    bashio::exit.nok
fi

# Make symlink for cookies
bashio::log.info "The following json files were found in $HOME and will be used in the app. Changing those files will require to restart the addon."
cd "$HOME" || true
for i in *.json; do # Whitespace-safe but not recursive.
    echo "... processing $i"
    ln -sf "$i" /usr/app/config
    # cp "$i" /usr/app/config
done

# Permissions
chmod -R 777 "$HOME"

##############
# Launch App #
##############

# Update npm
echo "Updating software"
npm update --no-save 

echo " "
bashio::log.info "Starting the app"
echo " "

cd /usr/app/config || true

#/./usr/local/bin/docker-entrypoint.sh
