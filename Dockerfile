FROM scratch AS models
WORKDIR /models
# https://github.com/openai/whisper/blob/9e653bd/whisper/__init__.py#L26
ADD https://openaipublic.azureedge.net/main/whisper/models/345ae4da62f9b3d59415adc60127b97c714f32e89e936602e85993674d08dcb1/medium.pt .
#ADD https://openaipublic.azureedge.net/main/whisper/models/e4b87e7e0bf463eb8e6956e646f1e277e901512310def2c24bf0e11bd3c28e9a/large.pt .

FROM docker.io/library/python:3.9-slim
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends \
	  ffmpeg \
	  git
RUN --mount=type=cache,target=/root/.cache/pip pip install git+https://github.com/openai/whisper.git@9e653bd
COPY --from=models /models ~/.cache/whisper
