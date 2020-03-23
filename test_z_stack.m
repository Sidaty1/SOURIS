%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Storing the tiff stack in  a 3d mat and displayng a video of it
%    /!\ Requires "Image Processing Toolbox"
close all
clear all
load('config.mat')
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
sI=smooth3(Iraw,'gaussian',3);     %applying a gaussian filter with a 3x3x3 window size with a default sd of 0.65
Isharp = zeros(S);
Iadjust = zeros(S);
%Boundaries
low_in = 0;
high_in = 1;
low_out = 0;
high_out = 0.995;

%adjusting images by subpart
%Iadjust(1:255,1:239,1:69)=imadjustn(sI(1:255,1:239,1:69)); 
Iadjust=imadjustn(sI); 
Iadjust_aux = Iadjust;
%Ifiber_adjust =imadjustn(sI(256:end,240:420,110:end)); %fiber subpart for
%first z_stack
Ifiber_adjust =imadjustn(sI(377:end,300:399,130:end)); %fiber subpart 2nd
%stack
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
%Iadjust(256:end,240:end,90:end)=Ifiber_adjust;%first stack
Iadjust(377:end,300:399,130:end)=Ifiber_adjust; %second stack
Ifiber_adjust=smooth3(Ifiber_adjust,'gaussian',3);
BWfiber = imbinarize(Ifiber_adjust, 0.77);

Mask = 0.5*(1-BWfiber);
%Iadjust(256:end,240:420,110:end)=Iadjust(256:end,240:420,110:end)-Mask;
%%first stack
Iadjust(377:end,300:399,130:end)=Iadjust(377:end,300:399,130:end)-Mask;
Iadjust=smooth3(Iadjust,'gaussian',15);
volshow(Iadjust,config);

%Iadjust(256:end,240:end,70:end) = 1- Iadjust(256:end,240:end,70:end);

%Ifiber=edge3(Ifiber,'Sobel',0.005 );
% Ifiber= imclose(Ifiber,se);

% Ifiber = Ifinal(:,:,70:S(3));


%viewer3d(1-Ifiber)                    %3D rendering
%viewer3d(Iadjust) 
 
%look for the optic fiber between the frames 70 and 130
% for new mouse1 (see mouse_prev for previous mouse studied), fiber is
% locate from frame 130 to 412 along the Z axis
                
            
