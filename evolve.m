%Project: Evolving Images Using Transparent Overlapping Polygons
%Team: Linyu Dong, Chao Li, Xing Chen, William Tarimo
%Spring 2013
%Script: Implements the high-level image evolution loop

function output = evolve(verts,poly,gens)
%Takes in the number of vertices, number of polygons and the number of
%generations. Then evolves the recreates a given target image for that many
%generations. Returns the new image genome sequence

pop = population(); %genome/population class
fit = fitness(); %fitness class

%Initialization of global variables
global image; image=imread('mona_lisa_crop.jpg'); %target image
global y_dim; global x_dim; global color_num; [y_dim,x_dim,color_num] = size(image);
global vertices; global polygons; vertices = verts; polygons = poly;
evolution = fopen('output/evolution.txt','wt');
fits = fopen('output/fits.txt','wt');

genome = pop.generate_genome(); %Generate a new random genome
mutations = 0;

while gens >= 0 %Image evolution, loops for the given generations gens
    parent_fitness = fit.get_fitness(genome);
    child_genome = pop.hybrid_mutate(genome);
    child_fitness = fit.get_fitness(child_genome);
    
    fprintf(evolution,'%s\n',num2str(child_fitness));
    if child_fitness <= parent_fitness
        fprintf(fits,'%s\n',num2str(child_fitness));
        genome = child_genome; %Child genome replaces the parent
        mutations = mutations+1;
        if mod(mutations,5)==0
            imwrite(I,sprintf('output/out%d.jpg',mutations))
        end
    end
    gens = gens - 1;
    
end
fclose(evolution); fclose(fits);
output = genome;