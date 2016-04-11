% function to read all images in folder and extract the SIFT descriptors
function [trainDescriptors, testDescriptors] = descriptorsImagesFolder(folderName, tag, trainDescriptors, testDescriptors, nrTrain, nrTest)
    % folderName is the path to the folder containing the set of images
    % tag is the index of images category
    %     
    %trainDescriptors, testDescriptors are the arrays where new
    % descriptores are stored for all images in folder
    % 
    % nrTrain,nrTest number of train and test images to be read from folder
    

    folder =  dir(folderName);
    
    for i = 1:(2 + nrTrain + nrTest)
    if i < 3
        %nothing first 2 files are dummy files
        file = folder(i).name;
    elseif i < (3 + nrTrain)        
        %train images descritors extraction
        file = folder(i).name;
        Im = imread(strcat(folderName,file));
        
        if(size(size(Im),2) == 3)
            Im = rgb2gray(Im);
        end
        Im = single(Im);
        
        [f,d] = vl_sift(Im) ;
        tagRow = ones(size(d,2),1)*tag;
        d = [d' , tagRow];
        trainDescriptors = [trainDescriptors ; d];       
        
    else
        %test images descritors extraction
        file = folder(i).name;
        Im = imread(strcat(folderName,file));
        
        if(size(size(Im),2) == 3)
            Im = rgb2gray(Im);
        end
        Im = single(Im);
        
        [f,d] = vl_sift(Im) ;
        tagRow = ones(size(d,2),1)*tag;
        d = [d' , tagRow];
        testDescriptors = [testDescriptors ; d]; 
        
    end
    
   end 




end