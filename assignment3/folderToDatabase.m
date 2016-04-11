%function to add all files from folder to the database with Bag of Words
function database = folderToDatabase(database,folderName, centroids, category, nrTrain, nrTest )
    % folderName is the path to the folder containing the set of images
    % centroids are obtained from kmeans clustering
    % category of images from the folder    
    % nrTrain,nrTest number of train and test images to be read from folder
    



folder =  dir(folderName);
 
for i = 1:(2 + nrTrain + nrTest)
    if i < 3
        %nothing first 2 files are dummy files
        file = folder(i).name;
    elseif i < (3 + nrTrain)    
        %train images
        file = folder(i).name;
        Im = imread(strcat(folderName,file));
        
        if(size(size(Im),2) == 3)
            Im = rgb2gray(Im);
        end
        Im = single(Im);
        % SIFT features
        [f,d] = vl_sift(Im) ;
        d = d';
        
        % make Bag of Words histogram
        closestWord = knnsearch(centroids,d);
        [counts, centers]= hist(closestWord,0:256);
        
        
        entry = struct('filename',file,'category',category,'set','train','BagOfWords',counts);
        database = [database , entry];
   
    else  
         %test images
        file = folder(i).name;
        Im = imread(strcat(folderName,file));
        
        if(size(size(Im),2) == 3)
            Im = rgb2gray(Im);
        end
        Im = single(Im);
        
        [f,d] = vl_sift(Im) ;
        d = d';
        closestWord = knnsearch(centroids,d);
        [counts, centers]= hist(closestWord,0:256);
        
        
        entry = struct('filename',file,'category',category,'set','test','BagOfWords',counts);
        database = [database , entry];
   
    end 
    
end









end