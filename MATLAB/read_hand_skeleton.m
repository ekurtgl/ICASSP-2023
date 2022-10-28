clc; clear; close all;

datapath = '/mnt/HDD04/ICASSP_2023/Data/skeletons/';
savepath = '/mnt/HDD04/ICASSP_2023/Data/skeletons_mat/';
folders = dir(datapath);
folders = folders(3:end);

for f = 1:length(folders)
    tic
    disp(['Processing ' int2str(f) '/' int2str(length(folders))]);
    files = dir([folders(f).folder '/' folders(f).name '/*txt']);
    hands = zeros(42, 3, length(files));
    for i = 1:length(files)
%         figure(1);
%         clf;
%         hold on; 

        fid = fopen([files(i).folder '/' files(i).name]);
        content = cell(1);
        content{1} = fgetl(fid);
        cnt = 2;
        while ischar(content{cnt-1})
            content{cnt} = fgetl(fid);
            cnt = cnt + 1;
        end
        fclose(fid);

        if isempty(content)
            continue
        end
        content = content(1:end-1);
        [first_hand_data, second_hand_data, connections] = get_hand_data(content);
        hands(1:21, :, i) = first_hand_data.';
        hands(22:42, :, i) = second_hand_data.';
        
%         plot3D_hand(first_hand_data, second_hand_data, connections);
    end
    save([savepath folders(f).name '.mat'], 'hands');
    toc
end




