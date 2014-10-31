EvolvingImages
==============

Evolving Images Using Transparent Overlapping Polygons

Linyu Dong, Chao Li, Xing Chen, William Tarimo
February 28, 2013

Our project attempted to use machine learning to recreate or
redefine features of an image using an arrangement of transparent
overlapping polygons. From genetic algorithm and
hill climbing, we came up an implementation that starts
by generating a random sequence of polygons then iteratively
mutating the sequence (slightly modifying a random attribute
of a random polygon), incrementally building on mutations
that yield results that are closer to a target image. In the
context of evolving images using polygons, we learned and
explored the balance between visual appeal of the generated
images and the efficiency of the implementation.

See 'Project Paper.pdf' for complete report.

To evolve an image run: evolve(number_of_vertices,number_of_polygons,number_of_generations)

The target image(changeable) is set to mona_lida_crop.jpg in evolve.m