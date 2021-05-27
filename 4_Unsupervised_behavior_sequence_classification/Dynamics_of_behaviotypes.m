%% Dynamics of behaviotypes analysis used in Hernandez-Nunez et al 2021 Science Advances
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
setupDirectories('utility functions')
addpath('C:\Program Files\MATLAB\R2016b\toolbox\stats');
clear all; close all; clc;
%% Input arguments
Analysis_name            = 'Thermotaxis_Dataset';
Type_of_stimulus         = 'Periodic_Activation';        %   periodic signal = Periodic_Activation  white noise = Random_Activation
Type_of_experiment       = 'Thermotaxis';                %   Phototaxis_Yellow Phototaxis_Violet Phototaxis_White Thermotaxis Thermotaxis_with_optogenetics Chemotaxis Chemotaxis_with_optogenetics
Stimulus_period          = 96;                           %   in number of frames
Movie_duration           = 4800;                         %   in number of frames
Frame_rate               = 4;                            %   in Hz
Leafs_file               = 'Thermotaxis_Leafs.txt';
%% LOAD file with leafs and read the leafs
fig_dir           =     ['\\LABNAS100\Luis\2018\',Type_of_experiment,'\_Results\',Analysis_name,'\'];
curr_dir          =     pwd;
cd(fig_dir)
fid1 = fopen(Leafs_file,'r');
cd(curr_dir)
%% Get number of leaves
fseek(fid1, 0, 'eof');
fileSize = ftell(fid1);
frewind(fid1);
% Read the whole file.
data = fread(fid1, fileSize, 'uint8');
% Count number of line-feeds and increase by one.
numLeaves = sum(data == 10)/4;
fclose(fid1);
%% Get leave names and content
cd(fig_dir)
fid1 = fopen(Leafs_file,'r');
cd(curr_dir)
Leaves_names    = cell(numLeaves,1);
Leaves_content  = cell(numLeaves,1);
Leaves_level    = zeros(numLeaves,1);
isLeaf          = cell(numLeaves,1);
for i=1:numLeaves
    line = fgets(fid1);
    Leaves_level(i) = sscanf(line, '%i');
    line = fgets(fid1);
    Leaves_names{i} = sscanf(line, '%i');
    line = fgets(fid1);
    Leaves_content{i} = sscanf(line, '%i');
    line = fgets(fid1);
    isLeaf{i} = sscanf(line, '%s');
end
fclose(fid1);
%% Load 8 metrics
cd(fig_dir)
load('Eight_metrics.mat')
cd(curr_dir)
%% Get the metrics for each cluster
tree_spine_vec = ones(max(Leaves_level),1);
for i=2:length(tree_spine_vec)
    tree_spine_vec(i)=2*tree_spine_vec(i-1);
end
% Get total branches in the tree, assuming no more than 1 level imbalance
max_possible_branches= 0;
for i=1:max(Leaves_level)
    if(any((Leaves_level<i)))
      max_possible_branches = max_possible_branches+tree_spine_vec(i)-sum(Leaves_level<i)*2;  
    else
      max_possible_branches = max_possible_branches+tree_spine_vec(i);
    end
end
% Initialize parameters for each branch
B_speed             = cell(max_possible_branches,1);
B_CrabSpeed         = cell(max_possible_branches,1);   
B_HeadTurn          = cell(max_possible_branches,1); 
B_HeadAngSpeed      = cell(max_possible_branches,1); 
B_MotDir            = cell(max_possible_branches,1); 
B_area              = cell(max_possible_branches,1); 
B_length            = cell(max_possible_branches,1); 
B_CrawlBias         = cell(max_possible_branches,1); 
% Fill matrixes for each branch
B_counter = 1;
curr_branch = 1; prev_branch = 1;
lnames = Leaves_names;
for j=1:max(Leaves_level)-1     
    for i=1:numLeaves
        curr_branch = floor(lnames{i}/10^(Leaves_level(i)-j));
        if(j==max(Leaves_level)-1)&&(j==Leaves_level(i))
            B_counter=B_counter+1;
        else
            B_counter = B_counter+(curr_branch~=prev_branch);
        end
        B_speed{B_counter} = [B_speed{B_counter}; sync_speed(Leaves_content{i},:)];
        B_CrabSpeed{B_counter} = [B_CrabSpeed{B_counter}; sync_CrabSpeed(Leaves_content{i},:)];
        B_HeadTurn{B_counter} = [B_HeadTurn{B_counter}; sync_HeadTurn(Leaves_content{i},:)];
        B_HeadAngSpeed{B_counter} = [B_HeadAngSpeed{B_counter}; sync_HeadAngSpeed(Leaves_content{i},:)];
        B_MotDir{B_counter} = [B_MotDir{B_counter}; sync_MotDir(Leaves_content{i},:)];
        B_area{B_counter} = [B_area{B_counter}; sync_area(Leaves_content{i},:)];
        B_length{B_counter} = [B_length{B_counter}; sync_length(Leaves_content{i},:)];
        B_CrawlBias{B_counter} = [B_CrawlBias{B_counter}; sync_CrawlBias(Leaves_content{i},:)];
        lnames{i} = lnames{i} - floor(lnames{i}/10^(Leaves_level(i)-j))*10^(Leaves_level(i)-j);
        prev_branch = curr_branch;
    end
    if(curr_branch==floor(lnames{1}/10^(Leaves_level(1)-j-1)))
        B_counter = B_counter+1;
    end
end
   
for i =1:length(Leaves_level)
    if(Leaves_level(i)==max(Leaves_level))
        B_counter = B_counter+1;
        B_speed{B_counter} = sync_speed(Leaves_content{i},:);
        B_CrabSpeed{B_counter} = sync_CrabSpeed(Leaves_content{i},:);
        B_HeadTurn{B_counter} = sync_HeadTurn(Leaves_content{i},:);
        B_HeadAngSpeed{B_counter} = sync_HeadAngSpeed(Leaves_content{i},:);
        B_MotDir{B_counter} = sync_MotDir(Leaves_content{i},:);
        B_area{B_counter} = sync_area(Leaves_content{i},:);
        B_length{B_counter} = sync_length(Leaves_content{i},:);
        B_CrawlBias{B_counter} = sync_CrawlBias(Leaves_content{i},:);
    end
end       

%% Obtain mean and SEM for each branch
num_branches = B_counter;

mean_speed = zeros(num_branches,size(B_speed{1},2));
mean_CrabSpeed =zeros(num_branches,size(B_speed{1},2));
mean_HeadTurn =zeros(num_branches,size(B_speed{1},2));
mean_HeadAngSpeed =zeros(num_branches,size(B_speed{1},2));
mean_MotDir =zeros(num_branches,size(B_speed{1},2));
mean_area =zeros(num_branches,size(B_speed{1},2));
mean_length =zeros(num_branches,size(B_speed{1},2));
mean_CrawlBias =zeros(num_branches,size(B_speed{1},2));

sem_speed = zeros(num_branches,size(B_speed{1},2));
sem_CrabSpeed =zeros(num_branches,size(B_speed{1},2));
sem_HeadTurn =zeros(num_branches,size(B_speed{1},2));
sem_HeadAngSpeed =zeros(num_branches,size(B_speed{1},2));
sem_MotDir =zeros(num_branches,size(B_speed{1},2));
sem_area =zeros(num_branches,size(B_speed{1},2));
sem_length =zeros(num_branches,size(B_speed{1},2));
sem_CrawlBias =zeros(num_branches,size(B_speed{1},2));

for i =1:num_branches
    mean_speed(i,:)       = nanmean(B_speed{i});
    mean_CrabSpeed(i,:)   = nanmean(B_CrabSpeed{i});
    mean_HeadTurn(i,:)    = nanmean(B_HeadTurn{i});
    mean_HeadAngSpeed(i,:)= nanmean(B_HeadAngSpeed{i});
    mean_MotDir(i,:)      = nanmean(B_MotDir{i});
    mean_area(i,:)        = nanmean(B_area{i});
    mean_length(i,:)      = nanmean(B_length{i});
    mean_CrawlBias(i,:)   = nanmean(B_CrawlBias{i});
    
    sem_speed(i,:)           = nanstd(B_speed{i})./sqrt(size(B_speed{i},1));
    sem_CrabSpeed(i,:)       = nanstd(B_CrabSpeed{i})./sqrt(size(B_CrabSpeed{i},1));
    sem_HeadTurn(i,:)        = nanstd(B_HeadTurn{i})./sqrt(size(B_HeadTurn{i},1));
    sem_HeadAngSpeed(i,:)    = nanstd(B_HeadAngSpeed{i})./sqrt(size(B_HeadAngSpeed{i},1));
    sem_MotDir(i,:)          = nanstd(B_MotDir{i})./sqrt(size(B_MotDir{i},1));
    sem_area(i,:)            = nanstd(B_area{i})./sqrt(size(B_area{i},1));
    sem_length(i,:)          = nanstd(B_length{i})./sqrt(size(B_length{i},1));
    sem_CrawlBias(i,:)       = nanstd(B_CrawlBias{i})./sqrt(size(B_CrawlBias{i},1));   
end        
time_points = 0.25:0.25:24;
%% Plot the mean and SEM of the 8 metrics of pairs of branches to compare
% These figures are not shown in the paper but in the github page
for i =num_branches-15:num_branches
    f=figure(i);
    set(gcf,'color','white')
    set(gca,'FontSize',14)
    subplot(4,2,1)
    shadedErrorBar(time_points,mean_speed(i,:),sem_speed(i,:),'b')
    xlabel('Time(s)')
    ylabel('Normalized speed')
    subplot(4,2,2)
    shadedErrorBar(time_points,mean_CrabSpeed(i,:),sem_CrabSpeed(i,:),'g')
    xlabel('Time(s)')
    ylabel('Normalized Crab speed')
    subplot(4,2,3)
    shadedErrorBar(time_points,mean_HeadTurn(i,:),sem_HeadTurn(i,:),'k')
    xlabel('Time(s)')
    ylabel('Head Turn')
    subplot(4,2,4)
    shadedErrorBar(time_points,mean_HeadAngSpeed(i,:),sem_HeadAngSpeed(i,:),'c')
    xlabel('Time(s)')
    ylabel('Head Angular Speed')
    subplot(4,2,5)
    shadedErrorBar(time_points,mean_MotDir(i,:),sem_MotDir(i,:),'m')
    xlabel('Time(s)')
    ylabel('Motion Direction')
    subplot(4,2,6)
    shadedErrorBar(time_points,mean_CrawlBias(i,:),sem_CrawlBias(i,:),'r')
    xlabel('Time(s)')
    ylabel('Crawl Bias')
    subplot(4,2,7)
    shadedErrorBar(time_points,mean_area(i,:),sem_area(i,:),'g')
    xlabel('Time(s)')
    ylabel('Normalized area')
    subplot(4,2,8)
    shadedErrorBar(time_points,mean_length(i,:),sem_length(i,:),'k');
    xlabel('Time(s)')
    ylabel('Normalized length')   
    title(['Branch ', num2str(i),' has ',num2str(size(B_CrawlBias{i},1)),' larvae'])
    cd(fig_dir);
    saveas(f,['8_metrics_',num2str(i),'_branch'],'fig');
    saveas(f,['8_metrics_',num2str(i),'_branch'],'pdf');
    saveas(f,['8_metrics_',num2str(i),'_branch'],'ai');
    cd(curr_dir);
end
    
%% Make tree plot for Supp Fig. 7

f=figure(1);
set(gcf,'color','white')
set(gca,'FontSize',14);
hold on
plot([330 330],[180 200],'LineWidth',50);
%First layer
branch_content = zeros(1,2);
for i=num_branches-29:num_branches-28
    branch_content(i-1) = size(B_CrawlBias{i},1);
end
for i=1:2
    if(mod(i,2)==0)
        BranchPointsX = [450+(i-2)*240 450+(i-2)*240 330+(i-2)*240];
        BranchPointsY = [160 180 180];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    else
        BranchPointsX = [210+(i-1)*240 210+(i-1)*240 330+(i-1)*240];
        BranchPointsY = [160 180 180];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    end
end

%Second layer
branch_content = zeros(1,4);
for i=num_branches-27:num_branches-24
    branch_content(i-3) = size(B_CrawlBias{i},1);
end
for i=1:4
    if(mod(i,2)==0)
        BranchPointsX = [270+(i-2)*120 270+(i-2)*120 210+(i-2)*120];
        BranchPointsY = [140 160 160];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    else
        BranchPointsX = [150+(i-1)*120 150+(i-1)*120 210+(i-1)*120];
        BranchPointsY = [140 160 160];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    end
end

%Third layer
branch_content = zeros(1,8);
for i=num_branches-23:num_branches-16
    branch_content(i-7) = size(B_CrawlBias{i},1);
end
for i=1:8
    if(mod(i,2)==0)
        BranchPointsX = [180+(i-2)*60 180+(i-2)*60 150+(i-2)*60];
        BranchPointsY = [120 140 140];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    else
        BranchPointsX = [120+(i-1)*60 120+(i-1)*60 150+(i-1)*60];
        BranchPointsY = [120 140 140];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    end
end

% Last layer
branch_content = zeros(1,16);
for i=num_branches-15:num_branches
    branch_content(i-15) = size(B_CrawlBias{i},1);
end
for i=1:16
    if(mod(i,2)==0)
        BranchPointsX = [140+(i-2)*30 140+(i-2)*30 120+(i-2)*30];
        BranchPointsY = [100 120 120];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    else
        BranchPointsX = [100+(i-1)*30 100+(i-1)*30 120+(i-1)*30];
        BranchPointsY = [100 120 120];
        plot(BranchPointsX,BranchPointsY,'LineWidth',50*branch_content(i)/sum(branch_content));
    end
end
    
axis([80 580 90 210])

cd(fig_dir);
saveas(f,'Tree','fig');
saveas(f,'Tree','pdf');
saveas(f,'Tree','ai');
cd(curr_dir);


