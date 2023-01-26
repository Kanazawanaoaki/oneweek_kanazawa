#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import graphviz


dot = graphviz.Digraph(comment='A-Very-Intense-Fruit-Smoothie')

# create_ing(ing18, "1 (10 ounce) package frozen mixed berries")
dot.node('ing18', '1 (10 ounce) package frozen mixed berries')

# create_ing(ing19, "1 (15 ounce) can sliced peaches, drained")
dot.node('ing19', '1 (15 ounce) can sliced peaches, drained')

# create_ing(ing20, "2 tablespoons honey")
dot.node('ing20', '2 tablespoons honey')

# create_tool(t4, "blender")

# combine({ing18, ing19, ing20}, ing21, "fruit and honey", "")
dot.node('ing21', 'fruit and honey')
dot.edge('ing18', 'ing21', label="combine()")
dot.edge('ing19', 'ing21', label="combine()")
dot.edge('ing20', 'ing21', label="combine()")

# put(ing21, t4)

# mix(ing21, t4, ing22, "smoothie", "blend")
dot.node('ing22', 'smoothie')
dot.edge('ing21', 'ing22', label="mix(blend)")

# chefcheck(ing22,"smooth")

print(dot.source)

dot.view()
# dot.render('doctest-output/A-Very-Intense-Fruit-Smoothie.gv', view=True) 
# import ipdb
# ipdb.set_trace()
