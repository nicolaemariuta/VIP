function z = unbiased_integrate(n1, n2, n3 ,mask, order)
    % Slight modif of Yvain's code to make integration
    % more "black-box"
    % It is assumed that n3 is never 0
    
    
    if nargin == 4
        order = 2;
    end
    
    p = -n1./n3;
    q = -n2./n3;
    
	% Calculate some usefuk masks
	Omega = zeros(size(mask,1),size(mask,2),4);
	Omega_padded = padarray(mask,[1 1],0);
	Omega(:,:,1) = Omega_padded(3:end,2:end-1).*mask;	
	Omega(:,:,2) = Omega_padded(1:end-2,2:end-1).*mask; 
	Omega(:,:,3) = Omega_padded(2:end-1,3:end).*mask;	
	Omega(:,:,4) = Omega_padded(2:end-1,1:end-2).*mask; 
	clear Omega_padded 	

	% Mapping
	indices_mask = find(mask>0);
	mapping_matrix = zeros(size(p));
	mapping_matrix(indices_mask)=1:length(indices_mask);
	if(order==1)
		pbar = p;
		qbar = q;
	elseif(order==2)
		pbar = 0.5*(p+p([2:end end],:));
		qbar = 0.5*(q+q(:,[2:end end]));
	end
	
	% System
	I = [];
	J = [];
	K = [];
	B = zeros(length(indices_mask),1);

	% In mask, right neighbor in mask
	set = Omega(:,:,3);
	[X,Y]=find(set>0);
	indices_centre=sub2ind(size(mask),X,Y);
	I_centre = mapping_matrix(indices_centre);
	indices_voisins=sub2ind(size(mask),X,Y+1);
	I_voisins = mapping_matrix(indices_voisins);
	A_centre = ones(length(indices_centre),1);
	A_voisin = -ones(length(indices_centre),1);	
	K=[K;A_centre(:);A_voisin(:)]; % Which values ?
	I=[I;I_centre(:);I_centre(:)]; % Which values ?
	J=[J;I_centre(:);I_voisins(:)]; % Which values ?
	B(I_centre) = B(I_centre)-qbar(indices_centre);
	
	
	% In mask, left neighbor in mask
	set = Omega(:,:,4);
	[X,Y]=find(set>0);
	indices_centre=sub2ind(size(mask),X,Y);
	I_centre = mapping_matrix(indices_centre);
	indices_voisins=sub2ind(size(mask),X,Y-1);
	I_voisins = mapping_matrix(indices_voisins);
	A_centre = ones(length(indices_centre),1);
	A_voisin = -ones(length(indices_centre),1);	
	K=[K;A_centre(:);A_voisin(:)]; % Which values ?
	I=[I;I_centre(:);I_centre(:)]; % Which values ?
	J=[J;I_centre(:);I_voisins(:)]; % Which values ?
	B(I_centre) = B(I_centre)+qbar(indices_voisins);
	
	% In mask, top neighbor in mask
	set = Omega(:,:,2);
	[X,Y]=find(set>0);
	indices_centre=sub2ind(size(mask),X,Y);
	I_centre = mapping_matrix(indices_centre);
	indices_voisins=sub2ind(size(mask),X-1,Y);
	I_voisins = mapping_matrix(indices_voisins);
	A_centre = ones(length(indices_centre),1);
	A_voisin = -ones(length(indices_centre),1);		
	K=[K;A_centre(:);A_voisin(:)]; % Which values ?
	I=[I;I_centre(:);I_centre(:)]; % Which values ?
	J=[J;I_centre(:);I_voisins(:)]; % Which values ?
	B(I_centre) = B(I_centre)+pbar(indices_voisins);	
		
	% In mask, bottom neighbor in mask
	set = Omega(:,:,1);
	[X,Y]=find(set>0);
	indices_centre=sub2ind(size(mask),X,Y);
	I_centre = mapping_matrix(indices_centre);
	indices_voisins=sub2ind(size(mask),X+1,Y);
	I_voisins = mapping_matrix(indices_voisins);
	A_centre = ones(length(indices_centre),1);
	A_voisin = -ones(length(indices_centre),1);	
	K=[K;A_centre(:);A_voisin(:)]; % Which values ?
	I=[I;I_centre(:);I_centre(:)]; % Which values ?
	J=[J;I_centre(:);I_voisins(:)]; % Which values ?
	B(I_centre) = B(I_centre)-pbar(indices_centre);	
	
	% Construction de A and resolution of the system
	A = sparse(I,J,K);
    A = A + 1e-9*speye(size(A));
    Z = A\B;
    % back to image!
    z = nan*ones(size(mask));
    z(indices_mask) = Z;
end
