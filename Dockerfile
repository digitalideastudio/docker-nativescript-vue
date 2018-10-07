FROM node:9.5.0

MAINTAINER Serhii Matrunchyk <serhii@digitalidea.studio>

RUN apt-get update
RUN apt-get install -y python-dev xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 unzip
RUN apt-get install -y lib32z1 lib32ncurses5 libbz2-1.0 libstdc++6 g++
RUN apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" -y
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')
RUN mkdir -p /android/sdk
RUN export ANDROID_HOME=/android/sdk && cd /android/sdk && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && unzip sdk-tools-linux-4333796.zip
RUN echo $ANDROID_HOME
RUN export ANDROID_HOME=/android/sdk && echo $ANDROID_HOME
RUN ls -la /android/sdk/
RUN export ANDROID_HOME=/android/sdk && echo 'Y' | $ANDROID_HOME/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-25" "build-tools;27.0.3" "extras;android;m2repository" "extras;google;m2repository"
RUN export ANDROID_HOME=/android/sdk && echo 'Y' | npm install -g nativescript @vue/cli @vue/cli-init nativescript-cloud --unsafe-perm
RUN export ANDROID_HOME=/android/sdk && echo 'Y' | tns doctor
