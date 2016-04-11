function [Albedo , Nx, Ny, Nz] = photometric_stereo(data,pseudo_inverse)
    
    % data is the .mat file
    % pseduo_inverse = 0 then use inverse, otherwise use the pseudo inverse

    %data that is needed
    Im = data.I;
    mask = data.mask;
    Ms = data.S;

    %build the J array of size (nr images ,nz)
    J = [];
    for i = 1:size(Im,3)
      Imi = Im(:,:,i);
      Imi = reshape(Imi,[],1)';  
      J = [J ; Imi];
    end
    
    %use M = S^(-1)*J or M = pseudoinverse(S*J)
    if pseudo_inverse == 0
        m = Ms'*J;
    else 
        Mspinv = pinv(Ms);
        m = Mspinv*J;
    end
    
    
    %normal and extract albedo within the mask
    msk = reshape(mask,[],1)';

    albedo = zeros(size(msk));

    for i = 1:size(m,2)
        if msk(1,i)
            albedo(1,i) = sum(m(:,i).^2);
        else
            albedo(1,i) = 0;
        end
   
    end
    
    Albedo = reshape(albedo,size(Im(:,:,1)));
    
    %calculate normals
    nx = zeros(size(msk));
    ny = zeros(size(msk));
    nz = zeros(size(msk));

    for i = 1:size(m,2)
        if msk(1,i)
            nx(1,i) = m(1,i)/albedo(1,i);
            ny(1,i) = m(2,i)/albedo(1,i);
            nz(1,i) = m(3,i)/albedo(1,i);
        else
            nx(1,i) = 0;
            ny(1,i) = 0;
            nz(1,i) = 0;
        end
    end
    
    %surface recovery
    Nx = reshape(nx,size(Im(:,:,1)));
    Ny = reshape(ny,size(Im(:,:,1)));
    Nz = reshape(nz,size(Im(:,:,1)));
    
end