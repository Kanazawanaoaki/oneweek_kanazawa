#! /usr/bin/python3
# -*- coding: utf-8 -*-

import sys
import MeCab


if __name__ == "__main__":
    t = MeCab.Tagger()
    sentence = "太郎はこの本を女性に渡した。"
    if len(sys.argv)>=2:
        sentence = sys.argv[1]

    n = t.parseToNode(sentence)
    while n:
        print(n.surface, "\t", n.feature)
        n = n.next
        
