# Install build dependencies
RUN apk add --no-cache gcc musl-dev make linux-headers

# Copy 3proxy source code (assumes repo is cloned in build context)
WORKDIR /usr/src/3proxy
COPY . .

# Build 3proxy
RUN make -f Makefile.Linux

# Install 3proxy binary
RUN install -m755 src/3proxy /usr/local/bin/

# Create configuration directory
RUN mkdir -p /etc/3proxy

# Copy configuration file
COPY 3proxy.cfg /etc/3proxy/3proxy.cfg

# Expose default port
EXPOSE 3128

# Run 3proxy with configuration
CMD ["/usr/local/bin/3proxy", "/etc/3proxy/3proxy.cfg"]
