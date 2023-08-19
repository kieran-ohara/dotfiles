# Use the official AWS CLI image for ARM64 as a base
FROM amazon/aws-cli:latest as aws-cli

# Use the Amazon Linux 2 image for ARM64 to install session-manager-plugin
FROM amazonlinux:2

# Copy AWS CLI from aws-cli image
COPY --from=aws-cli /usr/local/aws-cli /usr/local/aws-cli
ENV PATH="/usr/local/aws-cli/v2/current/bin:$PATH"

# Install session-manager-plugin for ARM64
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_arm64/session-manager-plugin.rpm" -o "session-manager-plugin.rpm" && \
    yum install -y session-manager-plugin.rpm && \
    rm session-manager-plugin.rpm

# Set the entrypoint to the AWS CLI
ENTRYPOINT ["aws"]
