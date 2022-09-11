from xml.etree import ElementTree
import argparse

recipe_text_lists = []
action_lists = []

def dump_node(node, indent=0):
    # print("{}{} {} {}".format('    ' * indent, node.tag, node.attrib, node.text))
    if node.tag == 'originaltext' and not (node.text in recipe_text_lists):
        recipe_text_lists.append(node.text)
    if node.tag == 'annotation':
        action_lists.append(node.text)
    for child in node:
        dump_node(child, indent + 1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='parser for xml')

    parser.add_argument('-f', '--file', default='books.xml')
    args = parser.parse_args()
    file_name = args.file

    tree = ElementTree.parse(file_name)
    dump_node(tree.getroot())
    print("[original recipe texts]")
    for text in recipe_text_lists:
        print(text)
    print("[MILK action texts]")
    for text in action_lists:
        print(text)
