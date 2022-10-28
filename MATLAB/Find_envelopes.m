clc; clear; close all;
    
path = '/mnt/HDD04/ICASSP_2023/Data/microDoppler_sim/';
savepath = '/mnt/HDD04/ICASSP_2023/Data/envelopes_sim/';

files = dir([path '*png']);
imax = numel(files);

for i = 1:imax
   msg = strcat(['Processing file ', int2str(i), '/', int2str(imax)]);   % loading message
   disp(msg);
   fname = fullfile(files(i).folder, files(i).name);
   savename = [savepath files(i).name(1:end-4) '.txt'];
   
   if exist(savename, 'file')
       disp('skipping since exists ...');
       continue
   end
   im = imread(fname);
   [up,cent,low] = env_find(fname);
   
   final_env(1,:) = size(im,1) - up; % envelopes come reverse in y axis
   final_env(2,:) = size(im,1) - cent;
   final_env(3,:) = size(im,1) - low;
   final_env(final_env>320) = min(final_env(1,:));
   final_env(final_env<20) = max(final_env(3,:));
   
   margin = final_env(1,:)-final_env(3,:);
   
   dlmwrite(savename, margin,'delimiter',' ');
   clear final_env
end
% outnames = {'Upper_env.txt', 'Central_env.txt', 'Lower_env.txt'};
% 
% upper_env(upper_env>750) = min(upper_env(:));
% lower_env(lower_env<100) = max(lower_env(:));
% 
% fOut1 = strcat(savepath, outnames{1});
% fOut2 = strcat(savepath, outnames{2});
% fOut3 = strcat(savepath, outnames{3});
% 
% dlmwrite(fOut1, upper_env,'delimiter',' ');
% dlmwrite(fOut2, central_env,'delimiter',' ');
% dlmwrite(fOut3, lower_env,'delimiter',' ');
% 
% readenvup = textread(fOut1);
% readenvcent = textread(fOut2);
% readenvlow = textread(fOut3);
% 
% figure
% hold on
% plot(final_env(1,:))
% plot(final_env(2,:))
% plot(final_env(3,:))

