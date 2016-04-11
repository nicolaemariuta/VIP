%% Beethoven Dataset

clear;

%load data
Beethoven = load('Beethoven.mat');

[Albedo , Nx, Ny, Nz] = photometric_stereo(Beethoven,1);


z = unbiased_integrate(Nx,Ny,Nz,Beethoven.mask);
display_depth(z);


figure;
imagesc(Albedo),colormap(gray);

%% Buddha Dataset

clear;

%load data
Buddha = load('Buddha.mat');


[Albedo , Nx, Ny, Nz] = photometric_stereo(Buddha,1);

figure;
z = unbiased_integrate(Nx,Ny,Nz,Buddha.mask);
display_depth(z);


figure;
imagesc(Albedo),colormap(gray);




