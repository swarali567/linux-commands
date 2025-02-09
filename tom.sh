#!/bin/bash
 
# Variables
TOMCAT_VERSION="9.0.95"  # Specify the Tomcat version
TOMCAT_DIR="/opt/tomcat"
TOMCAT_TAR="apache-tomcat-${TOMCAT_VERSION}.tar.gz"
TOMCAT_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/${TOMCAT_TAR}"
LOG_ROTATE_CONF="/etc/logrotate.d/tomcat-logs"
 
# Function to check if Java is installed
check_java() {
    if command -v java &> /dev/null; then
        echo "Java is already installed."
        return 1
    else
        return 0
    fi
}
 
# Function to check if Tomcat is installed
check_tomcat() {
    if [ -d "$TOMCAT_DIR" ]; then
        echo "Tomcat is already installed at $TOMCAT_DIR."
        return 1
    else
        return 0
    fi
}
 
# Function to install Java
install_java() {
    echo "Installing Java..."
    sudo apt update
    sudo apt install -y default-jdk
    echo "Java installed successfully."
}
 
# Function to download and install Tomcat
install_tomcat() {
    echo "Downloading Tomcat ${TOMCAT_VERSION}..."
    wget $TOMCAT_URL
 
    echo "Extracting Tomcat..."
    sudo mkdir -p /opt
    sudo tar xzf $TOMCAT_TAR -C /opt/
    echo "Renaming Tomcat directory..."
    sudo mv /opt/apache-tomcat-${TOMCAT_VERSION} $TOMCAT_DIR
 
    echo "Setting permissions..."
    sudo chown -R $(whoami):$(whoami) $TOMCAT_DIR
 
    echo "Tomcat installed successfully at $TOMCAT_DIR"
}
 
# Function to start Tomcat
start_tomcat() {
    echo "Starting Tomcat..."
    cd $TOMCAT_DIR/bin
    ./catalina.sh start
    echo "Tomcat started successfully."
}
 
# Function to set up log rotation
setup_log_rotation() {
    echo "Setting up log rotation for Tomcat logs..."
    cat <<EOF | sudo tee $LOG_ROTATE_CONF
$TOMCAT_DIR/logs/*.log {
    weekly
    rotate 4
    compress
    delaycompress
    missingok
    notifempty
    size 3M
    dateext
    dateformat -%d-%m-%Y
    sharedscripts
    postrotate
        /bin/systemctl reload tomcat || true
    endscript
}
EOF
    echo "Log rotation setup completed."
}
 
# Main script execution
check_java
JAVA_INSTALLED=$?
 
check_tomcat
TOMCAT_INSTALLED=$?
 
if [ $JAVA_INSTALLED -eq 0 ]; then
    install_java
fi
 
if [ $TOMCAT_INSTALLED -eq 0 ]; then
    install_tomcat
    start_tomcat
    setup_log_rotation
else
    echo "Skipping Tomcat installation since it's already installed."
fi
 
echo "Script execution completed."
