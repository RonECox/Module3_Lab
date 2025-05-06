import time
import logging
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

# Setup logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def main():
    url = "https://www.zillow.com/homedetails/1313-Walnut-St-Farmington-MN-55024/1639018_zpid/"
    output_html = "zillow_page.html"
    output_screenshot = "zillow_screenshot.png"

    # Configure Chrome options
    options = Options()
    options.add_argument("--headless=new")  # ✅ New headless mode
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")

    driver = None

    try:
        logging.info("Setting up ChromeDriver...")
        service = Service(ChromeDriverManager().install())
        driver = webdriver.Chrome(service=service, options=options)

        logging.info(f"Navigating to {url}")
        driver.get(url)

        # Wait for JavaScript-rendered content to load
        time.sleep(3)

        logging.info("Saving page HTML...")
        html = driver.page_source
        with open(output_html, "w", encoding="utf-8") as file:
            file.write(html)
        logging.info(f"Page HTML saved to {output_html}")

        logging.info("Taking screenshot...")
        driver.save_screenshot(output_screenshot)
        logging.info(f"Screenshot saved to {output_screenshot}")

    except Exception as e:
        logging.error(f"An error occurred: {e}")

    finally:
        if driver:
            try:
                driver.quit()
                logging.info("Browser closed.")
            except Exception as cleanup_err:
                logging.warning(f"Error during browser cleanup: {cleanup_err}")

if __name__ == "__main__":
    main()
