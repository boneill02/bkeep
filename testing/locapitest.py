#!/usr/bin/env python3

import argparse
from xml.etree import ElementTree
import requests

ns = {'loc': 'http://www.loc.gov/MARC21/slim', 'oasis': 'http://docs.oasis-open.org/ns/search-ws/sruResponse'}

def isbn13to10(isbn):
    isbn = isbn[3:len(isbn) - 1]
    chkchr = 0
    index = 1
    for c in isbn:
        chkchr += int(c) * index
        index += 1
    chkchr %= 11

    if chkchr == 10:
        chkchr = 'X'

    isbn += str(chkchr)
    return isbn

def get_info(isbn):
    req_url = "http://lx2.loc.gov:210/LCDB?operation=searchRetrieve&query=bath.isbn=[" + isbn + "]&maximumRecords=1"
    response = requests.get(req_url).content
    return ElementTree.fromstring(response)

def print_info(root, isbn):
    title = ''
    author = ''
    record = root.find('oasis:records/oasis:record/oasis:recordData/loc:record', ns)
    if record == None:
        print("Record not found")
        return
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
        if len(isbn) == 13:
            isbn = isbn13to10(isbn)
        if len(isbn) != 10:
            print("Invalid ISBN. Try removing dashes.")
            exit(-1)
        xml_result = get_info(isbn)
        print_info(xml_result, isbn)
    else:
        print('Must provide ISBN')
