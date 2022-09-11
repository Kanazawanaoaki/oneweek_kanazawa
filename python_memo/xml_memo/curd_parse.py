from xml.etree import ElementTree
import argparse

def dump_node(node, indent=0):
    # print("{}{} {} {}".format('    ' * indent, node.tag, node.attrib, node.text))
    if node.tag == 'originaltext':
        print(node.text)
    for child in node:
        dump_node(child, indent + 1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='parser for xml')

    parser.add_argument('-f', '--file', default='books.xml')
    args = parser.parse_args()
    file_name = args.file

    tree = ElementTree.parse(file_name)
    dump_node(tree.getroot())
