#!/bin/bash
set -e

echo -e "\n🔄 Cleaning up old Chrome and ChromeDriver..."
sudo rm -f /usr/local/bin/chromedriver
sudo apt remove -y google-chrome-stable || true
sudo apt autoremove -y || true

echo -e "\n📦 Installing dependencies..."
sudo apt update
sudo apt install -y wget curl jq unzip

echo -e "\n🌐 Getting latest stable version info from Chrome for Testing API..."
JSON=$(curl -sSL "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json")

# Extract version and download URLs
VERSION=$(echo "$JSON" | jq -r '.channels.Stable.version')
CHROME_URL=$(echo "$JSON" | jq -r '.channels.Stable.downloads.chrome[] | select(.platform=="linux64") | .url')
CHROMEDRIVER_URL=$(echo "$JSON" | jq -r '.channels.Stable.downloads.chromedriver[] | select(.platform=="linux64") | .url')

echo -e "\n🆕 Latest Stable Version: $VERSION"
echo -e "⬇️ Chrome URL: $CHROME_URL"
echo -e "⬇️ ChromeDriver URL: $CHROMEDRIVER_URL"

# Download and install Chrome
echo -e "\n📦 Installing Google Chrome..."
wget -q "$CHROME_URL" -O chrome.zip
unzip -q chrome.zip -d chrome-temp
sudo mv chrome-temp/chrome-linux64 /opt/google-chrome
sudo ln -sf /opt/google-chrome/chrome /usr/bin/google-chrome
rm -rf chrome.zip chrome-temp

# Download and install ChromeDriver
echo -e "\n📦 Installing ChromeDriver..."
wget -q "$CHROMEDRIVER_URL" -O chromedriver.zip
unzip -q chromedriver.zip -d driver-temp
sudo mv driver-temp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver
rm -rf chromedriver.zip driver-temp

# Verify installations
echo -e "\n✅ Installed versions:"
google-chrome --version
chromedriver --version
