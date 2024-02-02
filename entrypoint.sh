# Export the sha256sum for verification.
export ZOO_CLI_SHA256="389bb6475dc487437eb38d842a8acd70df9e97107afe82ed144e633597f7178a"


# Download and check the sha256sum.
curl -fSL "https://dl.zoo.io/releases/cli/v0.2.16/zoo-x86_64-unknown-linux-musl" -o "/usr/local/bin/zoo" \
	&& echo "${ZOO_CLI_SHA256}  /usr/local/bin/zoo" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/zoo"

echo "zoo cli installed!"

# Run it!
zoo -h
