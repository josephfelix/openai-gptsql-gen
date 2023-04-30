FROM python:3.8-slim-buster

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  git \
  procps \
  wget \
  git-core \
  build-essential \
  openssl \
  curl \
  default-mysql-client \
  default-libmysqlclient-dev

# Copy the current directory contents into the container at /app
COPY . .

# Add docker-compose-wait tool -------------------
ENV WAIT_VERSION 2.7.2
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

# Run pip install
RUN pip install -r requirements.txt

# Run embeddings.py when the container launches
CMD ["sh", "-c", "/wait && python /app/src/embeddings.py"]