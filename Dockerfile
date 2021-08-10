FROM tensorflow/tensorflow:1.3.0-gpu
RUN apt-get update
RUN apt-get install -y python3 python3-pip zsh tmux wget git libsndfile1
RUN curl -O https://bootstrap.pypa.io/pip/3.5/get-pip.py
RUN python get-pip.py
RUN python -m pip install --upgrade "pip < 21.0"
RUN git clone https://github.com/vorgoron/tacotron.git
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt