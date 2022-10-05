FROM debian:11-slim
RUN apt update && apt install -y --no-install-recommends \
	  ffmpeg \
	  git \
	  python3-pip \
	  python3.9-full \
	  && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
WORKDIR /app
RUN pip install git+https://github.com/openai/whisper.git

# download language model ‘medium’
RUN whisper no-such-file.wav --model medium || echo “ignore missing file error”
