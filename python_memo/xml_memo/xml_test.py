from xml.etree import ElementTree
import argparse

parser = argparse.ArgumentParser(description='parser for xml')

parser.add_argument('-f', '--file', default='input.xml')
args = parser.parse_args()
file_name = args.file

# XML ファイルから ElementTree オブジェクトを生成
tree = ElementTree.parse(file_name)

# 先頭要素を表す Element オブジェクトを取得
elem = tree.getroot()
print(elem.tag)     #=> tree
print(elem.attrib)  #=> {'name': 'hello'}
