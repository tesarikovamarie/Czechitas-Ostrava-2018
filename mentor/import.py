import csv
from datetime import datetime

import requests
from bs4 import BeautifulSoup


class WundergroundParser(object):

    def _fetch_html(self, month, year, city_icao):
        response = requests.get(
            url='https://www.wunderground.com/history/airport/{icao}/{year}/{month}/1/MonthlyHistory.html'.format(
                month=month,
                year=year,
                icao=city_icao)
            )
        return response.content

    def _find_table(self, html_site):
        soup = BeautifulSoup(html_site, "html.parser")
        my_table = soup.find_all('table', attrs={'id': 'obsTable'})

        if not my_table:
            print('table not found')
            return

        return my_table[0]

    def _parse_table(self, table, month, year):
        days = []

        skip = True
        for body in table.find_all('tbody'):

            if skip:
                skip = False
                continue

            values = []
            for e in body.find_all(lambda x: not x.has_attr('class') and x.name == 'td'):
                values.append(e.text.strip())

            days.append({
                'datetime': datetime(year=year, month=month, day=int(values[0])).date(),
                'Temp. high': values[1],
                'Temp. avg': values[2],
                'Temp. low': values[3],
                'Dew Point high': values[4],
                'Dew Point avg': values[5],
                'Dew Point low': values[6],
                'Humidity high': values[7],
                'Humidity avg': values[8],
                'Humidity low': values[9],
                'Sea Level Press. high': values[10],
                'Sea Level Press. avg': values[11],
                'Sea Level Press. low': values[12],
                'Visibility high': values[13],
                'Visibility avg': values[14],
                'Visibility low': values[15],
                'Wind high': values[16],
                'Wind avg': values[17],
                'Wind low': values[18],
                'Precip.': values[19],
                'Events': values[20].replace('\n', '').replace('\t', ''),
            })

        return days

    def get_weather(self, city='Prague', month=1, year=2017):
        print('parsing {0}, month:{1}, year:{2}'.format(city, month, year))
        html = self._fetch_html(month, year, city)
        found_table = self._find_table(html)
        weather = self._parse_table(found_table, month, year)
        return weather


def save_into_file(rows):
    with open('weather_prague_2017.csv', 'w+', encoding='utf-8', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=rows[0].keys(), extrasaction='ignore')
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main(year):
    parser = WundergroundParser()

    weather = []
    for m in range(1, 13):
        response = parser.get_weather(month=m, year=year, city='Prague')
        weather.extend(response)

    save_into_file(weather)


if __name__ == "__main__":
    main(2017)
