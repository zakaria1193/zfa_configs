# Use the latest Ubuntu image
FROM ubuntu:latest

# Install dependencies if needed
RUN apt-get update && apt-get install -y bash sudo git && rm -rf /var/lib/apt/lists/*

# Create user 'zfadli' with home directory /home/zfadli
RUN useradd -m -d /home/zfadli -s /bin/bash zfadli

# Create the required directory structure
RUN mkdir -p /home/zfadli/my_repos/zfa_configs

# (Optionally copy your repository contents if not using a volume mount)
COPY . /home/zfadli/my_repos/zfa_configs/

# Set working directory
WORKDIR /home/zfadli/my_repos/zfa_configs

CMD ["/home/zfadli/my_repos/zfa_configs/installers.sh.sh -i"]
