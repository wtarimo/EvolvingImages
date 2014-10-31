%Script: Implements the genome structure and methods
%Project: Evolving Images Using Transparent Overlapping Polygons
%Team: Linyu Dong, Chao Li, Xing Chen, William Tarimo
%Spring 2013

function pop = population()
pop.generate_genome = @generate_genome;
pop.generate_color = @generate_color;
pop.generate_alpha = @generate_alpha;
pop.generate_coordinate = @generate_coordinates;
pop.medium_mutate = @medium_mutate;
pop.soft_mutate = @soft_mutate;
pop.hybrid_mutate = @hybrid_mutate;

function genome = generate_genome()
%Generates and returns a random genome object
global polygons;
gene = cell(1,polygons);
for i=1:polygons
    gene{i} = {generate_color() generate_alpha() generate_coordinates()};
end
genome = gene;

function color = generate_color()
%Generates and returns a random color
% color = floor(rand*256);
color=rand(3,1);

function alpha = generate_alpha()
%Generates and returns a random alpha/transparency value
alpha = rand;

function xy = generate_coordinates()
%Generates and returns random vectors {[x] [y]} coordinate inside the [x_dim,y_dim]
%image size
global y_dim; global x_dim; global vertices;
xy = {ceil(rand(1,vertices)*(y_dim)),ceil(rand(1,vertices)*(x_dim))};
% xy{1}
% xy{2}

function genome = medium_mutate(genome)
%Modifies a genome by picking a random polygon, then picks a random
%attribute then changes the attribute to a new random value
global polygons; global vertices; global x_dim; global y_dim;
index = ceil(rand*polygons);
gene = genome{index};
trait = ceil(rand*3);
switch trait
    case 1
        genome{index} = {generate_color() gene{2} gene{3}};
    case 2
        genome{index} = {gene{1} generate_alpha() gene{3}};
    case 3
        c_index = ceil(rand*vertices);
        gene{3}{1}(c_index)=ceil(rand*y_dim); gene{3}{2}(c_index)=ceil(rand*x_dim);
        genome{index} = gene;
end

function genome = soft_mutate(genome)
%Modifies a genome by picking a random polygon, then picks a random
%attribute then changes the attribute by adding +/-10% of its initial value
global polygons; global vertices; global y_dim; global x_dim;
index = ceil(rand*polygons);
gene = genome{index};
trait = ceil(rand*3);
switch trait
    case 1
        genome{index} = {soft_mutate_color(gene{1}) gene{2} gene{3}};
    case 2
        genome{index} = {gene{1} soft_mutate_alpha(gene{2}) gene{3}};
    case 3
        c_index = ceil(rand*vertices);
        gene{3}{1}(c_index)=soft_mutate_coordinate(gene{3}{1}(c_index),y_dim); 
        gene{3}{2}(c_index)=soft_mutate_coordinate(gene{3}{2}(c_index),x_dim);
        genome{index} = gene;
end

function genome = hybrid_mutate(genome)
%Modifies a genome by picking a random polygon, then picks a random
%attribute then changes the attribute by appying soft or medium mutation 
%with chances 2:1
global polygons; global vertices; global y_dim; global x_dim;
index = ceil(rand*polygons);
gene = genome{index};
trait = ceil(rand*9);
switch trait
    case {1,2}
        genome{index} = {soft_mutate_color(gene{1}) gene{2} gene{3}};
    case 3
        genome{index} = {generate_color() gene{2} gene{3}};
        
    case {4,5}
        genome{index} = {gene{1} soft_mutate_alpha(gene{2}) gene{3}};
    case 6
        genome{index} = {gene{1} generate_alpha() gene{3}};
        
    case {7,8}
        c_index = ceil(rand*vertices);
        gene{3}{1}(c_index)=soft_mutate_coordinate(gene{3}{1}(c_index),y_dim); 
        gene{3}{2}(c_index)=soft_mutate_coordinate(gene{3}{2}(c_index),x_dim);
        genome{index} = gene;
    case 9
        c_index = ceil(rand*vertices);
        gene{3}{1}(c_index)=ceil(rand*y_dim); gene{3}{2}(c_index)=ceil(rand*x_dim);
        genome{index} = gene;
end

function alpha = soft_mutate_alpha(a)
%Randomly adds +/-10% to the alpha value
change = [0.1 -0.1];
a = a + change(ceil(rand*2));
if a > 1.0
    alpha = 1;
elseif a < 0
    alpha = 0;
else
    alpha = a;
end

function color = soft_mutate_color(c)
%Randomly adds +/-10% to each color channel
color=zeros(1,3);
for i=1:3
    change = [0.2 -0.2];
    c(i) = c(i) + change(ceil(rand*2));
    if c(i) > 1
        color(i) = 1;
    elseif c(i) < 0
        color(i) = 0;
    else
        color(i) = c(i);
    end
end
function coordinate = soft_mutate_coordinate(c,dim)
%Randomly adds +/-10% to the coordinate value
change = [floor(dim/10) -floor(dim/10)];
c = c + change(ceil(rand*2));
if c > dim
    coordinate = dim;
elseif c < 1
    coordinate = 1;
else
    coordinate = c;
end


