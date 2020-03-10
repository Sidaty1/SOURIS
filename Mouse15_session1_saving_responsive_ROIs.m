%% Selecting regions from MESc files and saving them in .txt
% As a prerequisite, set the desired ROI color for the given measurement in
% MESC, and save the ROIs as .mescroi. These are in reality .txt files, and can be
% loaded as such in Matlab.
%HINT: The different subgroups saved by this script can be loaded to the
%same measurement in mesc by using ROI append. 

% Created by: Attila Kaszas, 21-11-2019 %%

clear all
close all

%% Setting groups for different intensities, in cells(x) where x=[1, 2, 3, 4], for x*mV:
gr = [300 400 500 600];

cells(1).roi(:) = [19	28	63	78	103	107	133	155	201	206	224	227	229	257	272	283	289];
cells_out(1).roi(:) = [61	99	268];

cells(2).roi(:) = [1	2	8	10	12	14	15	17	18	19	23	26	29	31	32	33	35	36	57	59	60	63	72	73	74	77	80	81	84	89	90	91	92	93	95	96	102	104	105	115	117	120	121	130	132	136	142	162	163	165	166	167	168	174	176	177	179	183	202	217	218	221	223	232	234	239	241	243	245	246	250	254	255	257	261	264	278	282	286	287	288];
cells_out(2).roi(:) = [78	260];

cells(3).roi(:) = [0	2	3	7	8	11	14	15	16	18	22	23	25	26	27	29	30	31	32	34	35	36	37	38	40	45	47	49	55	58	63	68	72	74	75	76	77	79	80	81	82	83	84	85	86	87	89	91	92	93	95	96	97	98	100	101	103	104	105	107	110	112	114	116	121	125	126	127	130	132	135	137	140	162	163	164	165	166	167	169	174	175	176	177	180	183	188	190	192	194	196	216	218	220	227	234	241	246	248	249	250	254	255	257	258	260	261	262	270	272	277	278	281	286	287	290	292	293];
cells_out(3).roi(:) = [10	12	28	61	102	263];

cells(4).roi(:) = [0	1	2	4	5	9	10	11	14	15	17	23	27	29	30	32	34	35	36	37	38	45	49	52	54	58	72	75	77	79	80	81	82	83	84	85	90	91	92	93	95	97	98	100	101	103	104	105	106	107	113	115	120	123	124	125	132	135	162	163	164	165	166	167	168	169	170	174	175	176	177	180	183	196	216	220	227	232	233	234	239	241	242	243	244	245	246	250	253	254	255	256	257	259	261	262	263	272	277	278	279	283	285	286	288	289	292	293];
cells_out(4).roi(:) = [12	28	31	47	96	102	260];


%% Opening the file:
filename = 'C:\Users\david.moreau\Documents\IR STIM in vivo femtonics oct 2019\mouse15ROIs.mescroi';
% filename_out = 'C:\Users\david.moreau\Documents\IR STIM in vivo femtonics oct 2019\mouse15ROIsaftertreatment.mescroi';
regions = importdata(filename);
% regions_out = importdata(filename_out);

%% Limiters for grabbing single ROI data from mescroi txt file:
polyg = {'        </Polygon>'};
beforeend1 = {'    </ROIs>'};
beforeend2 = {'</MESconfig>'};

for i = 1:4
    nb(i) = length(cells(i).roi);
    nb_out(i) = length(cells_out(i).roi);
end

%% Getting the responsive regions - loading from file (region colour preset to white in MESC):

fid(1) = fopen('Mouse15_session1_300mV_resp.mescroi','wt');
fid(2) = fopen('Mouse15_session1_400mV_resp.mescroi','wt');
fid(3) = fopen('Mouse15_session1_500mV_resp.mescroi','wt');
fid(4) = fopen('Mouse15_session1_600mV_resp.mescroi','wt');

d= 0;

for i = 1:4
    row = 3;
    cells(i).text(1:2,1) = regions(1:2, 1);
    tic
    for k = 1:nb(i)
        a = num2str(cells(i).roi(1,k));
        roi = ['label="' a '"'];
        found = strfind(regions, roi, 'ForceCellOutput',true);
        roiend = strfind(regions, polyg, 'ForceCellOutput',true);
        for j = 1:(length(regions)-10)
            if found{j, 1} >= 1
                d = 0;
                while isempty(roiend{j+d, 1})
                    cells(i).text(row,1) = regions(j+d,1);
                    cells(i).text(row+1,1) = polyg;
                    cells(i).text(row+2,1) = beforeend1;
                    cells(i).text(row+3,1) = beforeend2;
                    row = row+1;
                    d = d+1;
                end
                row = row + 1;
            end
        end
    end
    f = string(cells(i).text(:));
    fprintf(fid(i), '%s\n', f);
    fclose(fid(i));    
    toc
end

%% Getting the outlier regions - loading from file with region colour set to magenta:

% fid(1) = fopen('Mouse15_session1_300mV_outliers.mescroi','wt');
% fid(2) = fopen('Mouse15_session1_400mV_outliers.mescroi','wt');
% fid(3) = fopen('Mouse15_session1_500mV_outliers.mescroi','wt');
% fid(4) = fopen('Mouse15_session1_600mV_outliers.mescroi','wt');
% 
% d= 0;
% 
% for i = 1:4
%     row = 3;
%     cells_out(i).text(1:2,1) = regions_out(1:2, 1);         
%     tic
%     for k = 1:nb_out(i)
%         a = num2str(cells_out(i).roi(1,k));
%         roi = ['label="' a '"'];
%         found = strfind(regions_out, roi, 'ForceCellOutput',true);
%         roiend = strfind(regions_out, polyg, 'ForceCellOutput',true);
%         for j = 1:(length(regions_out)-10)
%             if found{j, 1} >= 1
%                 d = 0;
%                 while isempty(roiend{j+d, 1})
%                     cells_out(i).text(row,1) = regions_out(j+d,1);
%                     cells_out(i).text(row+1,1) = polyg;
%                     cells_out(i).text(row+2,1) = beforeend1;
%                     cells_out(i).text(row+3,1) = beforeend2;
%                     row = row+1;
%                     d = d+1;
%                 end
%                 row = row + 1;
%             end
%         end
%     end
%     f = string(cells_out(i).text(:));
%     fprintf(fid(i), '%s\n', f);
%     fclose(fid(i));
%     toc
% end
% 




        
        






