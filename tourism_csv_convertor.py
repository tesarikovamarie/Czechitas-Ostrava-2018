import csv

def text_to_category_id (text):
    if (text[:3] == 'all'):
        return 1
    if (text[:7] == 'leisure'):
        return 2
    if (text[:8] == 'meetings'):
        return 3
    return 4

with open('brussel_tourism.csv') as csvfile:
    spamreader = enumerate(csv.reader(csvfile, delimiter=';', quotechar='"'))
    header1 = []
    header2 = []
    for i, row in spamreader:
        if i == 1:
            header1 = row
        if i == 2:
            header2 = row
        if i > 2:
            rowx = enumerate(row)
            date = ''
            for c, col in rowx:
                if c == 0:
                    date = col
                if c > 0:
                    if header1[c] == '11':
                        continue
                    print ("{year},{month},{city_id},{category_id},{country_code},{number}".format(
                        year=date[:4],
                        month=date[-2:],
                        city_id=1,
                        category_id=text_to_category_id(header2[c]),
                        country_code=header1[c],
                        number=col
                    ))