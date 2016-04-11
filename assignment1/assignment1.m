%% 1.Gaussian filtering by using Matlab built-in functions
clearvars;
%load the image
I = imread('lenna.jpg');

%generate the gaussian filters
Is1 = fspecial('gaussian', size(I), 1);
Is2 = fspecial('gaussian', size(I), 2);
Is4 = fspecial('gaussian', size(I), 4);
Is8 = fspecial('gaussian', size(I), 8);

%apply gaussian filtering using filters with different values for sigma
I1 = imfilter(I,Is1,'conv');
I2 = imfilter(I,Is2,'conv');
I4 = imfilter(I,Is4,'conv');
I8 = imfilter(I,Is8,'conv');

%display the results
figure;
subplot(3,2,1),imagesc(I),colormap(gray),title('original image');
subplot(3,2,2),imagesc(I1),colormap(gray),title('sigma = 1');
subplot(3,2,3),imagesc(I2),colormap(gray),title('sigma = 2');
subplot(3,2,4),imagesc(I4),colormap(gray),title('sigma = 4');
subplot(3,2,5),imagesc(I8),colormap(gray),title('sigma = 8');

%% 1.Gaussian filtering by using multiplication with filter in fourier domain
clearvars;
%load the image
I = imread('lenna.jpg');

%generate the gaussian filters
Is1 = fspecial('gaussian', size(I), 1);
Is2 = fspecial('gaussian', size(I), 2);
Is4 = fspecial('gaussian', size(I), 4);
Is8 = fspecial('gaussian', size(I), 8);



%multiplication in Fourier domain for applying the convolution
Ic1fft = (fft2(I)).*(fft2(Is1));
Ic2fft = (fft2(I)).*(fft2(Is2));
Ic4fft = (fft2(I)).*(fft2(Is4));
Ic8fft = (fft2(I)).*(fft2(Is8));

%calculate inverse fourier transform of the filtered images
Ic1 =fftshift(real(ifft2((Ic1fft))));
Ic2 =fftshift(real(ifft2(Ic2fft)));
Ic4 =fftshift(real(ifft2(Ic4fft)));
Ic8 =fftshift(real(ifft2(Ic8fft)));


%display the results
figure;
subplot(3,2,1),imagesc(I),colormap(gray),title('original image');
subplot(3,2,2),imagesc(Ic1),colormap(gray),title('sigma = 1');
subplot(3,2,3),imagesc(Ic2),colormap(gray),title('sigma = 2');
subplot(3,2,4),imagesc(Ic4),colormap(gray),title('sigma = 4');
subplot(3,2,5),imagesc(Ic8),colormap(gray),title('sigma = 8');


%% 2. Gradient magnitude using Matlab operators
clearvars;
%load the image
I = imread('lenna.jpg');



%calculate gradient magnitude and direction using different methods
[Gmag1,Gdir1] = imgradient(I,'Sobel');
[Gmag2,Gdir2] = imgradient(I,'Prewitt');
[Gmag3,Gdir3] = imgradient(I,'CentralDifference');
[Gmag4,Gdir4] = imgradient(I,'IntermediateDifference');
[Gmag5,Gdir5] = imgradient(I,'Roberts');


%display the results
figure;
subplot(2,3,1),imagesc(I),colormap(gray),title('original image');
subplot(2,3,2),imagesc(Gmag1),colormap(gray),title('Sobel');
subplot(2,3,3),imagesc(Gmag2),colormap(gray),title('Prewitt');
subplot(2,3,4),imagesc(Gmag3),colormap(gray),title('CentralDifference');
subplot(2,3,5),imagesc(Gmag4),colormap(gray),title('IntermediateDifference');
subplot(2,3,6),imagesc(Gmag5),colormap(gray),title('Roberts');


%% 2. Gradient magnitude using Gaussian derivatives
clearvars;
%load the image
I = imread('lenna.jpg');
%I = imread('coins.png');

%generate the gaussian filters
sigma = 8;
G1 = fspecial('gaussian', size(I), sigma);


%calculate the first order gaussian derivatives
[Gx,Gy] = gradient(G1);
%calculate second order derivatives
[Gxx,Gxy] = gradient(Gx);
[Gyx,Gyy] = gradient(Gy);

%Calculate gradients for first order Gaussian derivatives
Dx = conv2(double(I),double(Gx),'same');
Dy = conv2(double(I),double(Gy),'same');
%Calculate gradiient for second order Gaussian derivatives
Dxx = conv2(double(I),double(Gxx),'same');
Dxy = conv2(double(I),double(Gxy),'same');
Dyx = conv2(double(I),double(Gyx),'same');
Dyy = conv2(double(I),double(Gyy),'same');


%display the results
figure;
subplot(2,4,1),imagesc(I),colormap(gray),title('original image');
subplot(2,4,2),imagesc(Dx),colormap(gray),title('I*Gx');
subplot(2,4,3),imagesc(Dy),colormap(gray),title('I*Gy');
subplot(2,4,4),imagesc(Dxx),colormap(gray),title('I*Gxx');
subplot(2,4,5),imagesc(Dxy),colormap(gray),title('I*Gxy');
subplot(2,4,6),imagesc(Dyx),colormap(gray),title('I*Gyx');
subplot(2,4,7),imagesc(Dyy),colormap(gray),title('I*Gyy');




%% 3. Mexican hat filtering
clearvars;
%load the image
I = imread('lenna.jpg');
%I = imread('sunflower.tiff');
%Generate shifted coordinate for calculating the Laplacian
[X Y] = meshgrid(1:size(I,2),1:size(I,1));
X = X - size(I,2)/2;
Y = Y - size(I,1)/2;
%Create the filter
sigma = 8;
LG = (1/(2*pi*power(sigma,2))) .* ...
            ((power(X,2)+power(Y,2)-2*power(sigma,2))/power(sigma,4)) .* ...
            exp(-(power(X,2)+power(Y,2))/(2*power(sigma,2)));
%Convolve to detect blobs        
Ib = conv2(double(LG),double(I),'same');        
        
%display the results
figure;
subplot(1,3,1),imagesc(I),colormap(gray),title('original image');
subplot(1,3,2),imagesc(Ib),colormap(gray),title('Blob detection');
subplot(1,3,3),imagesc(LG),colormap(gray),title('Laplacian filter');        


%% 4. Canny edge detection
clearvars;
%load the image
I = imread('lenna.jpg');


% apply canny edge detection with various parameters
Ic1 = edge(I,'Canny',[0.05,0.1],'both',1);
Ic2 = edge(I,'Canny',[0.01,0.05],'both',1);
Ic3 = edge(I,'Canny',[0.05,0.1],'both',2);
Ic4 = edge(I,'Canny',[0.01,0.05],'both',2);
Ic5 = edge(I,'Canny',[0.1,0.5],'both',4);
Ic6 = edge(I,'Canny',[0.05,0.1],'both',4);
Ic7 = edge(I,'Canny',[0.01,0.05],'both',4);
Ic8 = edge(I,'Canny',[0.05,0.1],'both',8);
Ic9 = edge(I,'Canny',[0.01,0.05],'both',8);


%display the results
figure;
subplot(2,5,1),imagesc(I),colormap(gray),title('original image');
subplot(2,5,2),imagesc(Ic1),colormap(gray),title('t=[0.05,0.1];s=1');
subplot(2,5,3),imagesc(Ic2),colormap(gray),title('t=[0.01,0.05];s=1');
subplot(2,5,4),imagesc(Ic3),colormap(gray),title('t=[0.05,0.1];s=2');
subplot(2,5,5),imagesc(Ic4),colormap(gray),title('t=[0.01,0.05];s=2');
subplot(2,5,6),imagesc(Ic5),colormap(gray),title('t=[0.1,0.5];s=4');
subplot(2,5,7),imagesc(Ic6),colormap(gray),title('t=[0.05,0.1];s=4');
subplot(2,5,8),imagesc(Ic7),colormap(gray),title('t=[0.01,0.05];s=4');
subplot(2,5,9),imagesc(Ic8),colormap(gray),title('t=[0.05,0.1];s=8');
subplot(2,5,10),imagesc(Ic9),colormap(gray),title('t=[0.01,0.05];s=8');

%% 4. Canny edge detection different parameters
clearvars;
%load the image
I = imread('lenna.jpg');


% apply canny edge detection with various parameters
Ic1 = edge(I,'Canny',[0.05,0.1],'both',1);
Ic2 = edge(I,'Canny',[0.01,0.5],'both',1);
Ic3 = edge(I,'Canny',[0.05,0.1],'both',2);
Ic4 = edge(I,'Canny',[0.01,0.5],'both',2);
Ic5 = edge(I,'Canny',[0.01,0.5],'both',4);
Ic6 = edge(I,'Canny',[0.01,0.5],'both',4);
Ic7 = edge(I,'Canny',[0.01,0.015],'both',4);
Ic8 = edge(I,'Canny',[0.05,0.1],'both',8);
Ic9 = edge(I,'Canny',[0.01,0.5],'both',8);


%display the results
figure;
subplot(2,5,1),imagesc(I),colormap(gray),title('original image');
subplot(2,5,2),imagesc(Ic1),colormap(gray),title('t=[0.05,0.1];s=1');
subplot(2,5,3),imagesc(Ic2),colormap(gray),title('t=[0.01,0.5];s=1');
subplot(2,5,4),imagesc(Ic3),colormap(gray),title('t=[0.05,0.1];s=2');
subplot(2,5,5),imagesc(Ic4),colormap(gray),title('t=[0.01,0.5];s=2');
subplot(2,5,6),imagesc(Ic5),colormap(gray),title('t=[0.01,0.5];s=4');
subplot(2,5,7),imagesc(Ic6),colormap(gray),title('t=[0.01,0.5];s=4');
subplot(2,5,8),imagesc(Ic7),colormap(gray),title('t=[0.01,0.015];s=4');
subplot(2,5,9),imagesc(Ic8),colormap(gray),title('t=[0.05,0.1];s=8');
subplot(2,5,10),imagesc(Ic9),colormap(gray),title('t=[0.01,0.5];s=8');


