%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Storing the tiff stack in  a 3d mat and displayng a video of it
%    /!\ Requires "Image Processing Toolbox"

tiff_info = imfinfo('Z_stack_mouse1.tiff'); % return tiff structure, one element per image
tiff_stack = imread('Z_stack_mouse1.tiff', 1) ; % read in first image
%concatenate each successive tiff to tiff_stack
for ii = 2 : size(tiff_info, 1)
    temp_tiff = imread('Z_stack_mouse1.tiff', ii);
    tiff_stack = cat(3 , tiff_stack, temp_tiff);
end
%implay(tiff_stack) % playing a video of the stack

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% permuted_stack = permute(tiff_stack,[3 1 2]);
% viewer3d(permuted_stack);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù%

% hf2 = figure ;
% hs = slice(tiff_stack,[],[],1:4) ;
% shading interp
% set(hs,'FaceAlpha',0.8);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Generate sample image
% [x,y,z,v] = flow; %// x,y,z and v are all of size [25x50x25]
% 
% im1 = v(:,:,5);  %// extract the slice at Z=5.  im1 size is [25x50]
% im2 = v(:,:,10); %// extract the slice at Z=10. im2 size is [25x50]
% im3 = v(:,:,15); %// extract the slice at Z=15. im3 size is [25x50]
% im4 = v(:,:,20); %// extract the slice at Z=20. im4 size is [25x50]
% 
% hf = figure ;
% subplot(221);imagesc(im1);title('Z=5');
% subplot(222);imagesc(im2);title('Z=10');
% subplot(223);imagesc(im3);title('Z=15');
% subplot(224);imagesc(im4);title('Z=20');
% 
% %// This is just how I generated sample images, it is not part of the "answer" !
% 
% 
% M(:,:,1) = im1 ;
% M(:,:,2) = im2 ;
% M(:,:,3) = im3 ;
% M(:,:,4) = im4 ;
% 
% hf2 = figure ;
% hs = slice(M,[],[],1:4) ;
% shading interp
% set(hs,'FaceAlpha',0.8);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [X,Y,Z] = sphere(16);
% x = [0.5*X(:); 0.75*X(:); X(:)];
% y = [0.5*Y(:); 0.75*Y(:); Y(:)];
% z = [0.5*Z(:); 0.75*Z(:); Z(:)];
%  
% S = repmat([70,50,20],numel(X),1);
% C = repmat([1,2,3],numel(X),1);
% s = S(:);
% c = C(:);
% 
% h = scatter3(x,y,z,s,c);
%%%%%%%%%%%%%%%% Viewer3D toolbox is necessary : https://fr.mathworks.com/matlabcentral/fileexchange/21993-viewer3d

I=double(tiff_stack);
I=I./max(max(max(I)));          %Image normalization
I=imadjustn(I);                 %histogram equalization
viewer3d(I)                     %3D rendering
 
                
            
