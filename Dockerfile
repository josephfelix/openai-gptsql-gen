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

# Run pip install
RUN pip install -r requirements.txt

# Give permission to wait.sh
RUN chmod 755 /app/wait.sh

# Run app.py when the container launches
CMD ["sh", "-c", "/app/wait.sh && python /app/app.py"]