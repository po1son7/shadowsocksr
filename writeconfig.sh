#!/bin/sh
if [ "$ENABLE_PORT" = 'yes' ]; then
        sed -i '16,23s#//##g' user-config.json
        
fi
if [ "$ENABLE_PORT" = 'only' ]; then
        sed -i '16,23s#//##g' user-config.json
        sed -i '25s/false/true/g' user-config.json
fi
