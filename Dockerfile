FROM node:9.5.0

MAINTAINER Serhii Matrunchyk <serhii@digitalidea.studio>

RUN apt-get update && apt-get install -y \
    python-dev xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 \
    lib32z1 lib32ncurses5 lib32bz2-1.0 libstdc++6:i386 \
    g++ python-software-properties

RUN add-apt-repository ppa:webupd8team/java -y && apt-get update

RUN apt-get install oracle-java8-installer

RUN update-alternatives --config java

RUN export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')

RUN mkdir -p /android/sdk

ADD tools /android/sdk

RUN export ANDROID_HOME=/android/sdk

RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-25" "build-tools;27.0.3" "extras;android;m2repository" "extras;google;m2repository"

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

RUN npm install -g nativescript @vue/cli @vue/cli-init  --unsafe-perm

RUN tns doctor


