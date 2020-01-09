import argparse
import requests

def get_info(isbn):
    return requests.get('https://openlibrary.org/api/books?bibkeys=ISBN:' + isbn + '&jscmd=data&format=json').json()

def print_info(json_result, isbn):
    print(json_result)
    title = json_result['ISBN:' + isbn]['title']
    author = json_result['ISBN:' + isbn]['authors'][0]['name']
    print(title + '\t' + author + '\t\t' + isbn + '\t')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i')
    args = parser.parse_args()
    isbn = args.i
    if isbn != None:
        json_result = get_info(isbn)
        print_info(json_result, isbn)
    else:
        print('Must provide ISBN')
