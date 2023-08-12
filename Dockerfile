FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

FROM python:3.10-slim
 
# Create app directory
WORKDIR /app
COPY requirements.txt ./
RUN apt-get update -q && apt-get install --no-install-recommends -qy \
                bison \                
                gfortran \
                libopenblas-dev \
                libjpeg-dev \
                zlib1g-dev \
                python3-dev g++ gcc inetutils-ping \
                libc-dev \
                && pip install --no-cache-dir --progress-bar off -r requirements.txt \
                && rm -rf /var/lib/apt/lists/* 


# Bundle app source
COPY . .
 
EXPOSE 5000
CMD [ "flask", "run","--host","0.0.0.0","--port","5000"]
