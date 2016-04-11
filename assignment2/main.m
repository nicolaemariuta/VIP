clear; close all; clc;

%% read data 
Im1 = imread('Img001_diffuse.ppm');
Im2 = imread('Img002_diffuse.tif');
Im9 = imread('Img009_diffuse.tif');
% data is reduced to one intensity channel
gray1 = sum(Im1,3);
gray2 = sum(Im2,3);
gray9 = sum(Im9,3);
% data is normalized
gray1 = gray1/max(gray1(:));
gray2 = gray2/max(gray2(:));
gray9 = gray9/max(gray9(:));

% gray1 = im2bw(gray1, 0.8);
% gray2 = im2bw(gray2, 0.8);
% gray9 = im2bw(gray9, 0.8);
%% interest point
% detectFASTFeatures / detectMinEigenFeatures / ++ detectHarrisFeatures ++
% detectSURFFeatures / 	detectBRISKFeatures / detectMSERFeatures
interestPoint1 = detectHarrisFeatures(gray1);
interestPoint2 = detectHarrisFeatures(gray2);
interestPoint9 = detectHarrisFeatures(gray9);

%% plot interestPoints
figure;
subplot(3,3,1), imshow(gray1,[]);
hold on;
subplot(3,3,1), plot(selectStrongest(detectFASTFeatures(gray1), 100));

subplot(3,3,2), imshow(gray2,[]);
title('detectFASTFeatures');
hold on;
subplot(3,3,2), plot(selectStrongest(detectFASTFeatures(gray2), 100));

subplot(3,3,3), imshow(gray9,[]);
hold on;
subplot(3,3,3), plot(selectStrongest(detectFASTFeatures(gray9), 100));

subplot(3,3,4), imshow(gray1,[]);
hold on;
subplot(3,3,4), plot(selectStrongest(detectMinEigenFeatures(gray1), 100));

subplot(3,3,5), imshow(gray2,[]);
title('detectMinEigenFeatures');
hold on;
subplot(3,3,5), plot(selectStrongest(detectMinEigenFeatures(gray2), 100));

subplot(3,3,6), imshow(gray9,[]);
hold on;
subplot(3,3,6), plot(selectStrongest(detectMinEigenFeatures(gray9), 100));

subplot(3,3,7), imshow(gray1,[]);
hold on;
subplot(3,3,7), plot(selectStrongest(detectHarrisFeatures(gray1), 100));

subplot(3,3,8), imshow(gray2,[]);
title('detectHarrisFeatures');
hold on;
subplot(3,3,8), plot(selectStrongest(detectHarrisFeatures(gray2), 100));

subplot(3,3,9), imshow(gray9,[]);
hold on;
subplot(3,3,9), plot(selectStrongest(detectHarrisFeatures(gray9), 100));

figure;
subplot(3,3,1), imshow(gray1,[]);
hold on;
subplot(3,3,1), plot(selectStrongest(detectSURFFeatures(gray1), 100));

subplot(3,3,2), imshow(gray2,[]);
title('detectSURFFeatures');
hold on;
subplot(3,3,2), plot(selectStrongest(detectSURFFeatures(gray2), 100));

subplot(3,3,3), imshow(gray9,[]);
hold on;
subplot(3,3,3), plot(selectStrongest(detectSURFFeatures(gray9), 100));

subplot(3,3,4), imshow(gray1,[]);
hold on;
subplot(3,3,4), plot(selectStrongest(detectBRISKFeatures(gray1), 100));

subplot(3,3,5), imshow(gray2,[]);
title('detectBRISKFeatures');
hold on;
subplot(3,3,5), plot(selectStrongest(detectBRISKFeatures(gray2), 100));

subplot(3,3,6), imshow(gray9,[]);
hold on;
subplot(3,3,6), plot(selectStrongest(detectBRISKFeatures(gray9), 100));

subplot(3,3,7), imshow(gray1,[]);
hold on;
subplot(3,3,7), plot(detectMSERFeatures(gray1));

subplot(3,3,8), imshow(gray2,[]);
title('detectMSERFeatures');
hold on;
subplot(3,3,8), plot(detectMSERFeatures(gray2));

subplot(3,3,9), imshow(gray9,[]);
hold on;
subplot(3,3,9), plot(detectMSERFeatures(gray9));


%% feature extraction
% 'Auto' (default) | 'BRISK' | 'FREAK' | 'SURF' | 'Block'
% Block will return im image neighbourhood of each interest point default Blocksize = 11 
[Features1, Points1] = extractFeatures(gray1, interestPoint1, 'Method','Block','BlockSize',11);
[Features2, Points2] = extractFeatures(gray2, interestPoint2, 'Method','Block','BlockSize',11);
[Features9, Points9] = extractFeatures(gray9, interestPoint9, 'Method','Block','BlockSize',11);

%% feature matching
% Metric match block, SAD or SSD. (Hamming for binary)
Pair1_2 = matchFeatures(Features1, Features2,'Metric','SSD');
Pair1_9 = matchFeatures(Features1, Features9,'Metric','SSD');

%% display match 1 2
matchedIm1 = Points1(Pair1_2(:, 1), :);
matchedIm2 = Points2(Pair1_2(:, 2), :);
figure;
showMatchedFeatures(gray1, gray2, matchedIm1, ...
    matchedIm2, 'montage');
title('Matched Points');

%% Remove single points and keep conected geometry
[~, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedIm1, matchedIm2, 'affine');

figure;
showMatchedFeatures(gray1, gray2, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Geometric Matched Points');


%% display match 1 9
matchedIm1 = Points1(Pair1_9(:, 1), :);
matchedIm9 = Points9(Pair1_9(:, 2), :);
figure;
showMatchedFeatures(gray1, gray9, matchedIm1, ...
    matchedIm9, 'montage');
title('Matched Points');

%% Remove single points and keep conected geometry
[~, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedIm1, matchedIm9, 'affine');

figure;
showMatchedFeatures(gray1, gray9, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Geometric Matched Points');