import csv
from datetime import datetime

import requests
from bs4 import BeautifulSoup

import time

import re

from collections import OrderedDict

class WundergroundParser(object):

    def _fetch_html(self, month, year, city_icao):
        url = 'https://www.wunderground.com/history/airport/{icao}/{year}/{month}/1/MonthlyHistory.html'.format(
            month=month,
            year=year,
            icao=city_icao
        )
        print(url)
        response = requests.get(url=url)
        return response.content

    def _find_table(self, html_site):
        soup = BeautifulSoup(html_site, "html.parser")
        my_table = soup.find_all('table', attrs={'id': 'obsTable'})

        if not my_table:
            print('table not found')
            return

        return my_table[0]

    def _parse_table(self, airport_code, city_name, table, month, year):
        days = []

        skip = True
        for body in table.find_all('tbody'):

            if skip:
                skip = False
                continue

            values = []
            for e in body.find_all(lambda x: not x.has_attr('class') and x.name == 'td'):
                text = e.text.strip()
                if text == '-':
                    text = ''
                values.append(text)

            day_validator = re.compile('[0-9]{1,2}')
            if day_validator.match(values[0]) == None:
                print('Invalid row for parsing! Day value contains {0}'.format(values[0]))
                break

            days.append(OrderedDict(
                [('airport_code', airport_code),
                 ('city_name', city_name),
                 ('date', datetime(year=year, month=month, day=int(values[0])).date()),
                 ('temp_high', values[1]),
                 ('temp_avg', values[2]),
                 ('temp_low', values[3]),
                 ('dew_point_high', values[4]),
                 ('dew_point_avg', values[5]),
                 ('dew_point_low', values[6]),
                 ('humidity_high', values[7]),
                 ('humidity_avg', values[8]),
                 ('humidity_low', values[9]),
                 ('sea_level_press_high', values[10]),
                 ('sea_level_press_avg', values[11]),
                 ('sea_level_press_low', values[12]),
                 ('visibility_high', values[13]),
                 ('visibility_avg', values[14]),
                 ('visibility_low', values[15]),
                 ('wind_high', values[16]),
                 ('wind_avg', values[17]),
                 ('wind_low', values[18]),
                 ('precip', values[19]),
                 ('events', values[20].replace('\n', '').replace('\t', ''))
            ]))

        return days

    def get_weather(self, airport_code='LKKB', city_name='Prague', year=2017, month=1):
        print('parsing {0} ({1}), month:{2}, year:{3}'.format(city_name, airport_code, month, year))
        html = self._fetch_html(month, year, airport_code)
        found_table = self._find_table(html)
        weather = self._parse_table(airport_code=airport_code, city_name=city_name, table=found_table, month=month, year=year)
        return weather


def save_into_file(rows, airport_code, city_name, year):
    file_name = 'weather_{0}_{1}.csv'.format(airport_code, year)
    print('Saving file for year {0} and city {1} ({2})'.format(year, city_name, airport_code))
    print(file_name)
    with open(file_name, 'w+', encoding='utf-8', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=rows[0].keys(), extrasaction='ignore')
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main(airport_code, city_name, year):
    parser = WundergroundParser()
    weather = []
    for m in range(1, 13):
        response = parser.get_weather(airport_code=airport_code, city_name=city_name, year=year, month=m)
        weather.extend(response)
        time.sleep(0.5)

    save_into_file(rows=weather, airport_code=airport_code, city_name=city_name, year=year)


if __name__ == "__main__":
    city_list = []
    with open('airports_for_weather.txt', 'r') as f:
        reader = csv.reader(f)
        cities = map(tuple, reader)
        for city in cities:
            if not all(city) or city == ():
                continue
            city_list.append(city);

    for city in city_list:
        for year in range(2014, 2018):
            main(airport_code=city[1], city_name=city[0], year=year)
