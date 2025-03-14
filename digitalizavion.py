import requests
from IPython.display import display, Image

def obtenir_previsio_amb_icones(ciutat, api_key, unitats="metric"):
    url = f"https://api.openweathermap.org/data/2.5/forecast?q={ciutat}&appid={api_key}&units={unitats}&lang=ca"
    resposta = requests.get(url)

    if resposta.status_code == 200:
        dades = resposta.json()
        print(f"Previsió del temps per a {dades['city']['name']}, {dades['city']['country']}:")
        
        for entrada in dades["list"]:
            data_hora = entrada["dt_txt"]
            temperatura = entrada["main"]["temp"]
            icona = entrada["weather"][0]["icon"]
            icona_url = f"https://openweathermap.org/img/wn/{icona}.png"
            
            print(f"{data_hora}: {temperatura}°{'C' if unitats == 'metric' else 'F'} - Icona: {icona_url}")
            display(Image(url=icona_url))
    else:
        print("No s'ha pogut obtenir la informació. Comprova el nom de la ciutat o la teva clau API.")

if __name__ == "__main__":
    API_KEY = "e35fe686c4abbcbd1e1722549598b25e"  # Substitueix per la teva clau d'OpenWeatherMap
    ciutat = input("Introdueix el nom de la ciutat: ")
    unitats = input("Introdueix les unitats (metric/imperial): ").strip().lower()
    if unitats not in ["metric", "imperial"]:
        unitats = "metric"  # Per defecte Celsius
    obtenir_previsio_amb_icones(ciutat, API_KEY, unitats)
