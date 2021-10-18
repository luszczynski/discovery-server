# FROM registry.redhat.io/discovery-tech-preview/discovery-server-rhel8:0.9.2-9
FROM registry.redhat.io/discovery-tech-preview/discovery-server-rhel8:latest

COPY ./roles/jboss_type/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/jboss_type
COPY ./roles/jboss_domain_controller/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/jboss_domain_controller
COPY ./roles/jboss_host_controller/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/jboss_host_controller
COPY ./roles/jvm/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/jvm
COPY ./roles/memory/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/memory
COPY ./roles/rhsso/ /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/roles/rhsso

RUN sed -i '/^    - system_purpose.*/i \    - jboss_type\n    - jboss_domain_controller\n    - jboss_host_controller\n    - jvm\n    - memory\n    - rhsso' /usr/lib/python3.6/site-packages/discovery-server/scanner/network/runner/inspect.yml

EXPOSE 443

CMD ["/bin/bash", "/deploy/docker_run.sh"]