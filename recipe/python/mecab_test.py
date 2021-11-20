#! /usr/bin/python2
# -*- coding: utf-8 -*-

import MeCab
t = MeCab.Tagger()
sentence = "太郎はこの本を女性に渡した。"
res = t.parse(sentence)
print(res)

sentence = "太郎はこの本を女性に渡した。"
n = t.parseToNode(sentence)
while n:
    print(n.surface, "\t", n.feature)
    n = n.next
