FROM tensorflow/tensorflow:1.3.0-gpu
RUN apt-get update
RUN apt-get install -y python3 python3-pip zsh tmux wget git libsndfile1 llvm-8
RUN curl -fsSL -o- https://bootstrap.pypa.io/pip/3.5/get-pip.py | python3.5
RUN ln -s /usr/bin/llvm-config-8 /usr/bin/llvm-config
RUN pip install llvmlite
RUN git clone https://github.com/vorgoron/tacotron.git
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt