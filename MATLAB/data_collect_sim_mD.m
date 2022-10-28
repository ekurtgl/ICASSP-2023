clc; clear; close all;

datapath = '/mnt/HDD04/WASL Dataset/Scripts/skeletons_mat/';
savepath = '/mnt/HDD04/ICASSP_2023/Data/microDoppler_sim/';
files = dir([datapath '*mat']);


for i = 1286:length(files)
    tic
    disp(['Processing ' int2str(i) '/' int2str(length(files))]);
    fname = [files(i).folder '/' files(i).name];
    load(fname);
    if isempty(hands)
        continue
    end
    fout = [savepath files(i).name(1:end-3) 'png'];
    FMCW_sim_hand(hands, fout);
    toc
end

