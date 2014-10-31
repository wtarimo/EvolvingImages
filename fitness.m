%Script: Implements the precise evaluation
%Project: Evolving Images Using Transparent Overlapping Polygons
%Team: Linyu Dong, Chao Li, Chen Xing, William Tarimo
%Spring 2013

function fit = fitness()
fit.get_fitness = @get_fitness;

function fits = get_fitness(genome)
%Renders the given genome into an image, then calculates its diffence from
%the global target image, this is the fitness that's returnedglobal image;

global image;

I=zeros(size(image)); %Create a new black image canvas same size as target

for i=1:length(genome) %This loop plots each genome polygon onto the canvas
    color = genome{i}{1};
    alpha = genome{i}{2};

    %plot the polygon to image
    I=bitmapplot(genome{i}{3}{1},genome{i}{3}{2},I,struct('FillColor',[color(1) color(2) color(3) alpha],'Color',[color(1) color(2) color(3) alpha]));
end

fits = abs(I-im2double(image)); %Get the pixel-by-pixel absolute difference
fits = sum(fits(:)); %Fitness  = sum of the difference matrix





