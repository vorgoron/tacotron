FROM tensorflow/tensorflow:1.3.0-gpu
RUN apt-get update
RUN apt-get install -y python3 python3-pip zsh tmux wget git libsndfile1
RUN pip3 install --upgrade pip
RUN pip3 install llvmlite==0.34.0
RUN git clone https://github.com/vorgoron/tacotron.git
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt