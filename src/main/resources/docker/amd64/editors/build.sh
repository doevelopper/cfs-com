

time docker build \
    --build-arg USER_ID=$(id -u ${USER}) \
    --build-arg GROUP_ID=$(id -g ${USER}) \
    -t doevelopper/editors:0.0.1 -f Dockerfile \
    .
