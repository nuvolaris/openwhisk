#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM scala

ENV UID=1001 \
    NOT_ROOT_USER=owuser

# If you change the docker version here, it has implications on invoker runc support.
# Docker server version and the invoker docker version must be the same to enable runc usage.
# If this cannot be guaranteed, set `invoker_use_runc: false` in the ansible env.
ENV DOCKER_VERSION=18.06.3-ce

# Uncomment to fetch latest version of docker instead: RUN wget -qO- https://get.docker.com | sh
# Install docker client
RUN curl -sSL -o docker-${DOCKER_VERSION}.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar --strip-components 1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/bin docker/docker && \
    tar --strip-components 1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/bin docker/docker-runc && \
    rm -f docker-${DOCKER_VERSION}.tgz && \
    chmod +x /usr/bin/docker && \
    chmod +x /usr/bin/docker-runc

RUN useradd -m -u ${UID} -d /home/${NOT_ROOT_USER} -s /bin/bash ${NOT_ROOT_USER}
ADD build/distributions/invoker.tar /home/${NOT_ROOT_USER}/
ADD init.sh /home/${NOT_ROOT_USER}/init.sh
RUN chmod +x /home/${NOT_ROOT_USER}/init.sh ;\
     chown -R ${NOT_ROOT_USER}:${NOT_ROOT_USER} /home/${NOT_ROOT_USER} ;\
     chmod -R g+w /home/${NOT_ROOT_USER} ;\
     echo -e '#!'"/bin/bash\ncd /home/${NOT_ROOT_USER}\n./init.sh "'"$@"' >/init.sh ;\
     chmod +x /init.sh

EXPOSE 8080
WORKDIR /home/${NOT_ROOT_USER}
USER ${NOT_ROOT_USER}
CMD ["./init.sh", "0"]
