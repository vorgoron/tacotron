FROM tensorflow/tensorflow:1.3.0-gpu
RUN apt-get update
RUN apt-get install -y zsh tmux wget git libsndfile1
RUN git clone https://github.com/vorgoron/tacotron.git
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt