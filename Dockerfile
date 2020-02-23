FROM ubuntu:focal
# Temporarily use Root
USER root
ENV HOME=/azp
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Replace with your zimezone
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      ca-certificates\
      curl \
      jq \
      git \
      iputils-ping \
      libcurl4 \
      libicu63 \
      libunwind8 \
      netcat \
      wget \
      # The following packages are needed for Chrome-headless that are used for Selenium tests.
      gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
      libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
      libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
      libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
      libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 \
      libxrandr2 libxrender1 libxss1 libxtst6 fonts-liberation libappindicator1 \
      libnss3 lsb-release xdg-utils wget \
      # I had to install nuget for .Net packages, for some reason azure was downloading nuget.exe file.
      nuget

WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh && chmod 777 /azp
RUN useradd -u 1001 -r -g 0 -d /azp -s /sbin/nologin -c "Default Application User" default

# Containters shouldn't run priviledged.
USER 1001
CMD ["./start.sh"]
