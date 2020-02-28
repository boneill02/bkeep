import sys

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

if __name__ == '__main__':
    print(isbn13to10(sys.argv[1]))
