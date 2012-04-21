function [fullgabor] = normalizeTrainFeatures(fullgabor)

% load gabfeat;
[m,n] = size(fullgabor)

% Normalize features(exclude first column)

% ind = 1:m;
% sub = normr(all_classesfeaturematrix(ind,2:end));
% all_classesfeaturematrix = cat(2,all_classesfeaturematrix(:,1),sub);
% size(all_classesfeaturematrix)


% Normalize features using mean and variance

feature_mean = mean(fullgabor(:,2:end));
%%save normalizing factors for test data
savefile = 'F:\MTECH\3rdsem\Project\featExtrNW_project\Gabor_new\normFactor\feat_mean.mat';
 
save(savefile, 'feature_mean');
feature_variance = std(fullgabor(:,2:end));
savefile = 'F:\MTECH\3rdsem\Project\featExtrNW_project\Gabor_new\normFactor\feat_var.mat';
 
save(savefile, 'feature_variance');

i = 2:n;

% x-mean / variance^2
fullgabor(:,2:end) = (fullgabor (:,2:end)- (feature_mean(i-1)'*ones(1,m))')./((feature_variance(i-1)'*ones(1,m))'.^2);

%% creating dat file for train data
 
 fid = fopen('train_svm_gab.dat','wt');
[m,n] = size(fullgabor);
for i= 1:m
    fprintf(fid,'%d',fullgabor(i,1));
        for j= 2:n
            if(fullgabor(i,j)~=0)
                fprintf(fid,' %d:%f',j-1,fullgabor(i,j));
            end
        end
        fprintf(fid,'\n');
end
fclose(fid)



