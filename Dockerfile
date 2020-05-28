ARG NODE_VERSION

FROM node:$NODE_VERSION-buster

RUN apt-get update && apt-get install -y \
    git \
    xvfb \
    openssh-client \
    ca-certificates \
    tar \
    gzip \
    unzip \
    bzip2 \
    libgconf-2-4 \
    curl \
    jq \
    openjdk-11-jre \
    openjdk-11-jre-headless \
    openjdk-11-jdk \
    openjdk-11-jdk-headless \
    libgtk3.0-cil-dev \
    libasound2 \
    libdbus-glib-1-2 \
    libdbus-1-3

RUN FIREFOX_URL="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" && \
  curl --silent --show-error --location --fail --retry 4 --retry-delay 5 --output /tmp/firefox.tar.bz2 "$FIREFOX_URL" && \
  tar -xf /tmp/firefox.tar.bz2 -C /opt && \
  ln -s /opt/firefox/firefox /usr/bin/firefox && \
  rm -rf /tmp/firefox.tar.bz2 && \
  firefox --version

RUN GECKODRIVER_LATEST_RELEASE_URL=$(curl https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r ".assets[] | select(.name | test(\"linux64\")) | .browser_download_url") && \
  curl --silent --show-error --location --fail --retry 4 --retry-delay 5 --output /tmp/geckodriver_linux64.tar.gz "$GECKODRIVER_LATEST_RELEASE_URL" && \
  cd /tmp && \
  tar -xf geckodriver_linux64.tar.gz && \
  rm -rf geckodriver_linux64.tar.gz && \
  mv geckodriver /usr/local/bin/geckodriver && \
  chmod +x /usr/local/bin/geckodriver && \
  geckodriver --version

RUN curl --silent --show-error --location --fail --retry 4 --retry-delay 5 --output /tmp/google-chrome-stable_current_amd64.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && \
  (dpkg -i /tmp/google-chrome-stable_current_amd64.deb || apt-get -fy install) && \
  rm -rf /tmp/google-chrome-stable_current_amd64.deb && \
  google-chrome --version

RUN CHROME_VERSION="$(google-chrome --version)" && \
  CHROMEDRIVER_RELEASE="$(echo $CHROME_VERSION | sed 's/^Google Chrome //')" && \
  CHROMEDRIVER_RELEASE=${CHROMEDRIVER_RELEASE%%.*} && \
  CHROMEDRIVER_VERSION=$(curl --silent --show-error --location --fail --retry 4 --retry-delay 5 "http://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROMEDRIVER_RELEASE}") && \
  curl --silent --show-error --location --fail --retry 4 --retry-delay 5 --output /tmp/chromedriver_linux64.zip "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" && \
  cd /tmp && \
  unzip chromedriver_linux64.zip && \
  rm -rf chromedriver_linux64.zip && \
  mv chromedriver /usr/bin/chromedriver && \
  chmod +x /usr/bin/chromedriver && \
  chromedriver --version

ENV DISPLAY :99
RUN printf '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /tmp/entrypoint \
 && chmod +x /tmp/entrypoint \
 && mv /tmp/entrypoint /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]
