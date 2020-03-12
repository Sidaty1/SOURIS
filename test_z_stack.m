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

%%%%%%%%%%%%%%%% Viewer3D toolbox is necessary : https://fr.mathworks.com/matlabcentral/fileexchange/21993-viewer3d

Iraw=double(tiff_stack);
Iraw=Iraw./max(max(max(Iraw)));          %Image normalization
S = size(Iraw);
%I=imadjustn(Iraw);                 %histogram equalization
sI=smooth3(I,'gaussian',3);     %applying a gaussian filter with a 3x3x3 window size with a default sd of 0.65
Isharp = zeros(S);
Iadjust = zeros(S);
low_in = 0;
high_in = 1;
low_out = 0;
high_out = 0.995;

Iadjust(1:255,1:239,1:69)=imadjustn(sI(1:255,1:239,1:69)); %adjusting images by subpart
Iadjust(256:end,240:end,70:end)=imadjustn(sI(256:end,240:end,70:end));
se = strel('sphere',3);

% for i = 1:69
%     %Isharp(:,:,i) = imsharpen(sI(:,:,i));
%     Iadjust(:,:,i) = imadjust(sI(:,:,i),[low_in high_in],[low_out high_out]);
% end 
%  for i = 70:S(3)
%      Iadjust(:,:,i) = imsharpen(sI(:,:,i));
%      Iadjust(:,:,i) = imadjust(sI(:,:,i),[low_in high_in],[low_out high_out]);
%      Iadjust(:,:,i)=edge(Iadjust(:,:,i),'Prewitt');
%      
%  end
Iadjust(256:end,240:end,70:end)=smooth3(Iadjust(256:end,240:end,70:end),'gaussian',3);
BWfiber = imbinarize(Iadjust(256:end,240:end,70:end), 0.77);

Mask = zeros(S);
Mask(256:end,240:end,70:end) = 1-BWfiber;
Iadjust = Iadjust + 0.5*Mask;
%Iadjust(256:end,240:end,70:end) = 1- Iadjust(256:end,240:end,70:end);

%Ifiber=edge3(Ifiber,'Sobel',0.005 );
% Ifiber= imclose(Ifiber,se);

% Ifiber = Ifinal(:,:,70:S(3));

%volshow(Ifiber);
%viewer3d(1-Ifiber)                    %3D rendering
viewer3d(Iadjust) 
 
%look for the optic fiber between the frames 70 and 130
                
            
