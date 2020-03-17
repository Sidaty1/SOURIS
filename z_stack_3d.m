function []= z_stack_3d (MouseNo,x,y,z)
% Storing the tiff stack in  a 3d mat and displayng a video of it
%    /!\ Requires "Image Processing Toolbox"
if (size(x)(1)~=1 || size(y)(1)~=1 size(z)(1)~=1)
    

end
switch MouseNo
    case 1
        mouse = 'mouse1';
    case 2
        mouse = 'mouse2';
    otherwise
        mouse = 'mouse1';
end

filename='Z_stack_'+mouse+'.tiff';
tiff_info = imfinfo(filename); % return tiff structure, one element per image
stack = imread(filename, 1) ; % read in first image
%concatenate each successive tiff to tiff_stack
for ii = 2 : size(tiff_info, 1)
    temp_tiff = imread(filename, ii);
    stack = cat(3 , stack, temp_tiff);
end

%%%%%%%%%%%%%%%% Viewer3D toolbox is necessary : https://fr.mathworks.com/matlabcentral/fileexchange/21993-viewer3d

Iraw=double(stack);
Iraw=Iraw./max(max(max(Iraw)));          %Image normalization
S = size(Iraw);
sI=smooth3(Iraw,'gaussian',3);     %applying a gaussian filter with a 3x3x3 window size with a default sd of 0.65


Iadjust=imadjustn(sI); 
Ifiber_adjust =imadjustn(sI(256:end,240:420,110:end)); %fiber subpart

Ifiber_adjust=smooth3(Ifiber_adjust,'gaussian',3);
BWfiber = imbinarize(Ifiber_adjust, 0.77);

Mask = 0.5*(1-BWfiber);
Iadjust(256:end,240:420,110:end)=Iadjust(256:end,240:420,110:end)-Mask;


end