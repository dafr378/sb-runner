from seleniumbase import SB
from selenium.webdriver.common.keys import Keys
import os, time

url = 'https://steplock.cloud'

USER = os.getenv('USER')
PASSWORD = os.getenv('PASSWORD')

if __name__ == "__main__":

    with SB(uc=True) as sb:

    sb.open(url)
    sb.save_screenshot("full_page_screenshot.png")