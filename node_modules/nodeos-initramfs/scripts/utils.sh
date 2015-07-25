NPMi='CC=$TARGET-gcc             \
      CXX=$TARGET-g++            \
      npm_config_prefix=$OBJ_DIR \
      $NODE_DIR/deps/npm/cli.js  \
        install                  \
        --loglevel warn          \
        --arch=$NODE_ARCH        \
        --nodedir=$NODE_DIR      \
        --jobs=$JOBS             '
