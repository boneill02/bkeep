#!/usr/bin/env python3

import argparse
from xml.etree import ElementTree
import requests

ns = {'loc': 'http://www.loc.gov/MARC21/slim', 'oasis': 'http://docs.oasis-open.org/ns/search-ws/sruResponse'}

def get_info(isbn):
    req_url = "http://lx2.loc.gov:210/LCDB?operation=searchRetrieve&query=bath.isbn=[" + isbn + "]&maximumRecords=1"
    response = requests.get(req_url).content
    return ElementTree.fromstring(response)

def print_info(root, isbn):
    title = ''
    author = ''

    record = root.find('oasis:records/oasis:record/oasis:recordData/loc:record', ns)
    for data in record.findall('loc:datafield', ns):
        if data.attrib['tag'] == '245':
            for subfield in data.findall('loc:subfield', ns):
                if subfield.attrib['code'] == 'a':
                    title = subfield.text
                if subfield.attrib['code'] == 'c':
                    author = subfield.text

    title = title[:len(title)-2]
    author = author[:len(author)-1]
    print(title + '\t' + author + '\t\t' + isbn + '\t')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i')
    args = parser.parse_args()
    isbn = args.i
    if isbn != None:
        xml_result = get_info(isbn)
        print_info(xml_result, isbn)
    else:
        print('Must provide ISBN')
