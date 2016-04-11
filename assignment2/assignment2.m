%% 1.Detecting interest points using Harris algorithm
clearvars;
%load the image
I = squeeze(imread('Img001_diffuse.tif'));

%calculate average image color
I = sum(I,3);
I = I/max(I(:));

%apply Harris feature detection with different parameter settings
corners1 = detectHarrisFeatures(I,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners2 = detectHarrisFeatures(I,'MinQuality', 0.01,'FilterSize', 15, 'ROI', [1,1,1600,1200]);
corners3 = detectHarrisFeatures(I,'MinQuality', 0.01,'FilterSize', 25, 'ROI', [1,1,1600,1200]);
corners4 = detectHarrisFeatures(I,'MinQuality', 0.2,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners5 = detectHarrisFeatures(I,'MinQuality', 0.2,'FilterSize', 15, 'ROI', [1,1,1600,1200]);
corners6 = detectHarrisFeatures(I,'MinQuality', 0.2,'FilterSize', 25, 'ROI', [1,1,1600,1200]);

%display the results
figure;
subplot(3,2,1),imshow(I),hold on, plot(corners1.selectStrongest(100)), hold off,title('corners1');
subplot(3,2,2),imshow(I),hold on, plot(corners2.selectStrongest(100)), hold off,title('corners2');
subplot(3,2,3),imshow(I),hold on, plot(corners3.selectStrongest(100)), hold off,title('corners3');
subplot(3,2,4),imshow(I),hold on, plot(corners4.selectStrongest(100)), hold off,title('corners4');
subplot(3,2,5),imshow(I),hold on, plot(corners5.selectStrongest(100)), hold off,title('corners5');
subplot(3,2,6),imshow(I),hold on, plot(corners6.selectStrongest(100)), hold off,title('corners6');



%% 1.Detecting interest points using minimum eigenvalue algorithm
clearvars;
%load the image
I = squeeze(imread('Img001_diffuse.tif'));

%calculate average image color
I = sum(I,3);
I = I/max(I(:));

%apply minimum eigenvalue feature detection with different parameter settings
corners1 = detectMinEigenFeatures(I,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners2 = detectMinEigenFeatures(I,'MinQuality', 0.01,'FilterSize', 15, 'ROI', [1,1,1600,1200]);
corners3 = detectMinEigenFeatures(I,'MinQuality', 0.01,'FilterSize', 25, 'ROI', [1,1,1600,1200]);
corners4 = detectMinEigenFeatures(I,'MinQuality', 0.2,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners5 = detectMinEigenFeatures(I,'MinQuality', 0.2,'FilterSize', 15, 'ROI', [1,1,1600,1200]);
corners6 = detectMinEigenFeatures(I,'MinQuality', 0.2,'FilterSize', 25, 'ROI', [1,1,1600,1200]);


%display the results
figure;
subplot(3,2,1),imshow(I),hold on, plot(corners1.selectStrongest(100)), hold off,title('corners1');
subplot(3,2,2),imshow(I),hold on, plot(corners2.selectStrongest(100)), hold off,title('corners2');
subplot(3,2,3),imshow(I),hold on, plot(corners3.selectStrongest(100)), hold off,title('corners3');
subplot(3,2,4),imshow(I),hold on, plot(corners4.selectStrongest(100)), hold off,title('corners4');
subplot(3,2,5),imshow(I),hold on, plot(corners5.selectStrongest(100)), hold off,title('corners5');
subplot(3,2,6),imshow(I),hold on, plot(corners6.selectStrongest(100)), hold off,title('corners6');
  
%% 1. Harris vs eigenvalue algorithm apllied on different color channels
clearvars;
%load the image
I = squeeze(imread('Img001_diffuse.tif'));


%split into image for each color channel
I1 =I(:,:,1);
I2 =I(:,:,2);
I3 =I(:,:,3);
I4 = sum(I,3);
I4 = I4/max(I4(:));

%apply both algorithms for feature detection with standard parameters for
%each color
corners1h = detectHarrisFeatures(I1,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners1e = detectMinEigenFeatures(I1,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners2h = detectHarrisFeatures(I2,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners2e = detectMinEigenFeatures(I2,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners3h = detectHarrisFeatures(I3,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners3e = detectMinEigenFeatures(I3,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners4h = detectHarrisFeatures(I3,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
corners4e = detectMinEigenFeatures(I3,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);

%display the results
figure;
subplot(4,2,1),imshow(I1),hold on, plot(corners1h.selectStrongest(100)), hold off,title('Harris color 1');
subplot(4,2,2),imshow(I1),hold on, plot(corners1e.selectStrongest(100)), hold off,title('Eigenvalue color 1');
subplot(4,2,3),imshow(I2),hold on, plot(corners2h.selectStrongest(100)), hold off,title('Harris color 2');
subplot(4,2,4),imshow(I2),hold on, plot(corners2e.selectStrongest(100)), hold off,title('Eigenvalue color 2');
subplot(4,2,5),imshow(I3),hold on, plot(corners3h.selectStrongest(100)), hold off,title('Harris color 3');
subplot(4,2,6),imshow(I3),hold on, plot(corners3e.selectStrongest(100)), hold off,title('Eigenvalue color 3');
subplot(4,2,7),imshow(I4),hold on, plot(corners3h.selectStrongest(100)), hold off,title('Harris average color');
subplot(4,2,8),imshow(I4),hold on, plot(corners3e.selectStrongest(100)), hold off,title('Eigenvalue average color');


%% Feature extraction 
clearvars;
%load the image
I = squeeze(imread('Img001_diffuse.tif'));

%calculate average image color
I = sum(I,3);
I = I/max(I(:));

%harris features
points1 = detectHarrisFeatures(I);
[features, points1] = extractFeatures(I, points1);


points2 = detectSURFFeatures(I);
[features, points2] = extractFeatures(I, points2);

points3 = detectMSERFeatures(I);
[features, points3] = extractFeatures(I,points3,'Upright',true);



%display the results
figure;
subplot(1,3,1),imshow(I),hold on, plot(points1.selectStrongest(100)), hold off,title('Harris features');
subplot(1,3,2),imshow(I),hold on, plot(points2.selectStrongest(100),'showOrientation',true), hold off,title('SURF features');
subplot(1,3,3),imshow(I),hold on, plot(points3.selectStrongest(100),'showOrientation',true), hold off,title('MSERF features');










%% Feature extraction
clearvars;
%load the image
I1 = imread('Img001_diffuse.tif');
I2 = imread('Img002_diffuse.tif');
I9 = imread('Img009_diffuse.tif');

%calculate average image color
gray1 = sum(I1,3);
gray1 = gray1/max(gray1(:));
gray2 = sum(I2,3);
gray2 = gray2/max(gray2(:));
gray9 = sum(I9,3);
gray9 = gray9/max(gray9(:));

%apply Harris feature detection
interestPoint1 = detectHarrisFeatures(gray1,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
interestPoint2 = detectHarrisFeatures(gray2,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);
interestPoint9 = detectHarrisFeatures(gray9,'MinQuality', 0.01,'FilterSize', 5, 'ROI', [1,1,1600,1200]);

% Block will return im image neighbourhood of each interest point default Blocksize = 11 
[Features1, Points1] = extractFeatures(gray1, interestPoint1, 'Method','Block','BlockSize',11);
[Features2, Points2] = extractFeatures(gray2, interestPoint2, 'Method','Block','BlockSize',11);
[Features9, Points9] = extractFeatures(gray9, interestPoint9, 'Method','Block','BlockSize',11);




% feature matching
% Metric match block, SAD or SSD. (Hamming for binary)
Pair1_2 = matchFeatures(Features1, Features2,'Metric','SSD');
Pair1_9 = matchFeatures(Features1, Features9,'Metric','SSD');


Pair1_2a = matchFeatures(Features1, Features2,'Metric','SAD');
Pair1_9a = matchFeatures(Features1, Features9,'Metric','SAD');


% display match 1 2 SSD
matchedIm1 = Points1(Pair1_2(:, 1), :);
matchedIm2 = Points2(Pair1_2(:, 2), :);

figure;
showMatchedFeatures(gray1, gray2, matchedIm1, ...
    matchedIm2, 'montage');
title('Matched Points 1-2 SSD');

% Remove single points and keep conected geometry
[~, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedIm1, matchedIm2, 'affine');

figure;
showMatchedFeatures(gray1, gray2, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Geometric Matched Points 1-2 SSD');





% display match 1 9 SSD
matchedIm1 = Points1(Pair1_9(:, 1), :);
matchedIm9 = Points9(Pair1_9(:, 2), :);
figure;
showMatchedFeatures(gray1, gray9, matchedIm1, ...
    matchedIm9, 'montage');
title('Matched Points 1-9 SSD');


% Remove single points and keep conected geometry
[~, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedIm1, matchedIm9, 'affine');

figure;
showMatchedFeatures(gray1, gray9, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Geometric Matched Points 1-9 SSD');



%%

% display match 1 2 SAD
matchedIm1 = Points1(Pair1_2a(:, 1), :);
matchedIm2 = Points2(Pair1_2a(:, 2), :);

figure;
showMatchedFeatures(gray1, gray2, matchedIm1, ...
    matchedIm2, 'montage');
title('Matched Points 1-2 SAD');



% display match 1 9 SAD
matchedIm1 = Points1(Pair1_9a(:, 1), :);
matchedIm9 = Points9(Pair1_9a(:, 2), :);
figure;
showMatchedFeatures(gray1, gray9, matchedIm1, ...
    matchedIm9, 'montage');
title('Matched Points 1-9 SAD');


