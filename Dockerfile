FROM ubuntu:16.04
RUN cd ~ && apt-get update -y && apt-get upgrade -y && \
    apt-get install -y cmake openssl gperf zlib1g zlib1g-dev libssl-dev build-essential xz-utils curl wget && \
    curl -SL http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz | tar -xJC . && \
    mv clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04 clang_8.0.0 && \
    mv clang_8.0.0/ /usr/local
ENV CXX /usr/local/clang_8.0.0/bin/clang++
ENV CC /usr/local/clang_8.0.0/bin/clang
RUN cd ~ && wget https://test.ton.org/ton-test-liteclient-full.tar.xz && \
    tar xf ton-test-liteclient-full.tar.xz && \
    cd lite-client/ && \
    mkdir ~/liteclient-build && \
    cd ~/liteclient-build && \
    cmake ~/lite-client && \
    cmake --build . --target lite-client && \
    cmake --build . --target fift && \
    cmake --build . --target func
RUN cd ~ && wget https://test.ton.org/ton-lite-client-test1.config.json && \
    mv ./liteclient-build/lite-client/lite-client /usr/local/bin/lite-client
ENTRYPOINT [ "/bin/bash" ]
# CMD ["/usr/local/bin/lite-client", "-C", "~/ton-lite-client-test1.config.json"]