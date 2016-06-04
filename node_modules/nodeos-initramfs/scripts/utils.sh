NPMi='CC=$TARGET-gcc              \
      CXX=$TARGET-g++             \
      npm_config_prefix=$STEP_DIR \
      $NODE_DIR/deps/npm/cli.js   \
        install                   \
        --quiet --no-spin         \
        --arch=$NODE_ARCH         \
        --nodedir=$NODE_DIR       \
        --jobs=$JOBS              '
