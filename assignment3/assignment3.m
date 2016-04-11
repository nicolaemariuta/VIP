%% Testing the VL_SIFT library
clear;
% load VLFeat’s sift
run('vlfeat-0.9.20/toolbox/vl_setup');

%load images
Ia = imread('101_ObjectCategories/crab/image_0001.jpg');
Ia = single(rgb2gray(Ia));

Ib = imread('101_ObjectCategories/crab/image_0002.jpg');
Ib = single(rgb2gray(Ib));


[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;

%%
clear;


%extract SIFT features
trainDescriptors = [];
testDescriptors = [];
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/accordion/', 1, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/airplanes/', 2, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/bass/', 3, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/anchor/', 4, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/ant/', 5, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/barrel/', 6, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/beaver/', 7, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/bonsai/', 8, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/brontosaurus/', 9, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/brain/', 10, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/buddha/', 11, trainDescriptors, testDescriptors, 30, 10);
[trainDescriptors, testDescriptors] = descriptorsImagesFolder('101_ObjectCategories/butterfly/', 12, trainDescriptors, testDescriptors, 30, 10);

trainDescriptors = double(trainDescriptors);
testDescriptors = double(testDescriptors);

csvwrite('trainDescriptors.csv',trainDescriptors);
csvwrite('testDescriptors.csv',testDescriptors);



%%
%clustering
% idx is the cluster for each descriptor
% C are the centroids 
% D are distances to each centroid
clear;
trainDescriptors = double(importdata('trainDescriptors.csv'));
testDescriptors = double(importdata('testDescriptors.csv'));




%[idx, C, sumd, D] = kmeans(trainDescriptors(:,1:128),30, 'MaxIter',10);
kmeansData = trainDescriptors(:,1:128)';

 [C,A]= vl_kmeans(kmeansData, 128, 'verbose', 'distance', 'l1', 'algorithm', 'ANN', 'MaxNumIterations', 50) ;
 
 Centers = C';
 Assignments = A';
 trainDescriptorsCluster = [trainDescriptors,Assignments];
 
 %%
 
 % classify each training descriptor to the closest cluster center
 closestCentroid = knnsearch(Centers,kmeansData');
 
%Bag of Words
database = [];
nrTrain = 30;
nrTest = 10;

database = folderToDatabase(database, '101_ObjectCategories/accordion/', Centers, 'accordion', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/airplanes/', Centers, 'airplanes', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/bass/', Centers, 'bass', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/anchor/', Centers, 'anchor', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/ant/', Centers, 'ant', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/barrel/', Centers, 'barrel', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/beaver/', Centers, 'beaver', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/bonsai/', Centers, 'bonsai', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/brontosaurus/', Centers, 'brontosaurus', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/brain/', Centers, 'brain', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/buddha/', Centers, 'buddha', nrTrain, nrTest);
database = folderToDatabase(database, '101_ObjectCategories/butterfly/', Centers, 'butterfly', nrTrain, nrTest);


%%

% Retrieving
barrel = database(221);
edistances = [];

for i = 1:480
   dist = sqrt(sum((barrel.BagOfWords - database(i).BagOfWords) .^ 2));
    
    edistances = [edistances ; dist,(floor((i-1)/40)+1)];
    
end



[B,I]= sort(edistances(:,1));
sortedistances = edistances(I,:);
