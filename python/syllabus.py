import requests
from bs4 import BeautifulSoup
import re
import os

# URL der Seite mit den Lehrplänen
base_url = "https://www.gtb.de/der-certified-tester/lehrplaene/"

# Hole den HTML-Inhalt der Seite
response = requests.get(base_url)
soup = BeautifulSoup(response.text, "html.parser")

# Erstelle einen Zielordner für Downloads
os.makedirs("pdf_downloads", exist_ok=True)

# Finde alle PDF-Links mit 'Syllabus' im Dateinamen
pdf_links = []
for link in soup.find_all("a", href=True):
    href = link["href"]
    if href.endswith(".pdf") and "Syllabus" in href:
        pdf_links.append(href if href.startswith("http") else "https://www.gtb.de" + href)

# Lade die gefundenen PDFs herunter
for pdf_url in pdf_links:
    filename = pdf_url.split("/")[-1]
    print(f"Lade herunter: {filename}")
    response = requests.get(pdf_url)
    with open(f"pdf_downloads/{filename}", "wb") as f:
        f.write(response.content)

print("Download abgeschlossen.")
