#!/bin/sh
#
# Configure sytest to use postgres databases, per the env vars.  This is used
# by both the sytest builds and the synapse ones.
#

cd "`dirname $0`/.."

if [ -z "$POSTGRES_DB_1" ]; then
    echo >&2 "Variable POSTGRES_DB_1 not set"
    exit 1
fi

if [ -z "$POSTGRES_DB_2" ]; then
    echo >&2 "Variable POSTGRES_DB_2 not set"
    exit 1
fi

if [ -z "$PORT_BASE" ]; then
    echo >&2 "Variable PORT_BASE not set"
    exit 1
fi

mkdir -p "localhost-$(($PORT_BASE + 1))"
mkdir -p "localhost-$(($PORT_BASE + 2))"

# We leave user, password, host blank to use the defaults (unix socket and
# local auth)
cat > localhost-$(($PORT_BASE + 1))/database.yaml << EOF
name: psycopg2
args:
    database: $POSTGRES_DB_1
    user: $POSTGRES_USER_1
    password: $POSTGRES_PASS_1
    host: $POSTGRES_HOST_1
EOF

cat > localhost-$(($PORT_BASE + 2))/database.yaml << EOF
name: psycopg2
args:
    database: $POSTGRES_DB_2
EOF
