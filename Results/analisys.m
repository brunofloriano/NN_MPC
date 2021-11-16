clear; close all; clc;
addpath 'functions'
SS16 = load('WW20_Fig1\SS16\SS16originaldata.mat');
GL20 = load('GL20_Fig3\GL20originaldata.mat');

%PMPCNN{5} = load('C:\Users\PICHAU\OneDrive - unb.br (1)\Doutorado\Implementacao\results\dataSS16nKMPC 2021-4-7-17-54\dataSS16nKMPC 2021-4-7-17-54.mat');
PMPCNN{1} = load('results\dataWW20_Linear_Pi_1\dataWW20nKMPC 2021-9-23-14-41.mat'); %Pi_1
PMPCNN{2} = load('results\dataWW20_Linear_Pi_2\dataWW20nKMPC 2021-9-23-14-48.mat'); %Pi_2
PMPCNN{3} = load('results\dataWW20_Linear_Pi_3\dataWW20nKMPC 2021-9-23-14-54.mat'); %Pi_3
PMPCNN{4} = load('results\dataWW20_Linear_Pi_4\dataWW20nKMPC 2021-9-23-15-10.mat'); %Pi_4
MPCNN = PMPCNN{1};

PMPCNNGL20{1} = load('results\dataGL20_Nonlinear_Pi_1\dataGL20nKMPC 2021-10-6-15-11.mat'); %Pi_1
PMPCNNGL20{2} = load('results\dataGL20_Nonlinear_Pi_2\dataGL20nKMPC 2021-9-23-10-53.mat'); %Pi_2
PMPCNNGL20{3} = load('results\dataGL20_Nonlinear_Pi_3\dataGL20nKMPC 2021-9-23-11-0.mat'); %Pi_3
PMPCNNGL20{4} = load('results\dataGL20_Nonlinear_Pi_4\dataGL20nKMPC 2021-9-23-11-4.mat'); %Pi_4
MPCNNGL20 = PMPCNNGL20{1};

MPCNNZH15{1} = load('results\dataZH15_General_Nonlinear_Pi_1\dataZH15nKMPC 2021-10-25-10-52.mat'); %Pi_1
MPCNNZH15{2} = load('results\dataZH15_General_Nonlinear_Pi_2\dataZH15nKMPC 2021-10-21-15-2.mat'); %Pi_2
MPCNNZH15{3} = load('results\dataZH15_General_Nonlinear_Pi_3\dataZH15nKMPC 2021-10-25-10-56.mat'); %Pi_3
MPCNNZH15{4} = load('results\dataZH15_General_Nonlinear_Pi_4\dataZH15nKMPC 2021-10-25-10-57.mat'); %Pi_4

% SISTEMA LINEAR
for i = 1:SS16.N*SS16.n
    SSS16 = stepinfo(SS16.state(i,:),SS16.t);
    settling_timeSS16(i) = SSS16.SettlingTime;
    overshootSS16(i) = SSS16.Overshoot;
    mse_SS16(i) = sum( (SS16.state(i,:) - SS16.state(i,end)).^2 )/length(SS16.state(i,:));
    
    SMPCNN = stepinfo(MPCNN.state(i,:),MPCNN.t);
    settling_timeMPCNN(i) = SMPCNN.SettlingTime;
    overshootMPCNN(i) = SMPCNN.Overshoot;
    mse_MPCNN(i) = sum( (MPCNN.state(i,:) - MPCNN.state(i,end)).^2 )/length(MPCNN.state(i,:));

end

dataPMPCNN = [];
for j = 1:4
    for i = 1:SS16.N*SS16.n
        SPMPCNN{j} = stepinfo(PMPCNN{j}.state(i,:),PMPCNN{j}.t);
        settling_timePMPCNN{j}(i) = SPMPCNN{j}.SettlingTime;
        overshootPMPCNN{j}(i) = SPMPCNN{j}.Overshoot;
        mse_PMPCNN{j}(i) = sum( (PMPCNN{j}.state(i,:) - PMPCNN{j}.state(i,end)).^2 )/length(PMPCNN{j}.state(i,:));

    end
    dataPMPCNN = [dataPMPCNN [settling_timePMPCNN{j}'; mse_PMPCNN{j}'] ];
end

% SISTEMA NONLINEAR
for i = 1:GL20.N*GL20.n    
    SGL20 = stepinfo(GL20.state(i,:),GL20.t);
    settling_timeGL20(i) = SGL20.SettlingTime;
    overshootGL20(i) = SGL20.Overshoot;
    mse_GL20(i) = sum( (GL20.state(i,:) - GL20.state(i,end)).^2 )/length(GL20.state(i,:));
    
    SMPCNNGL20 = stepinfo(MPCNNGL20.state(i,:),MPCNNGL20.t);
    settling_timeMPCNNGL20(i) = SMPCNNGL20.SettlingTime;
    overshootMPCNNGL20(i) = SMPCNNGL20.Overshoot;
    mse_MPCNNGL20(i) = sum( (MPCNNGL20.state(i,:) - MPCNNGL20.state(i,end)).^2 )/length(MPCNNGL20.state(i,:));
end

dataPMPCNNGL20 = [];
for j = 1:4
    for i = 1:GL20.N*GL20.n    
        SPMPCNNGL20{j} = stepinfo(PMPCNNGL20{j}.state(i,:),PMPCNNGL20{j}.t);
        settling_timePMPCNNGL20{j}(i) = SPMPCNNGL20{j}.SettlingTime;
        overshootPMPCNNGL20{j}(i) = SPMPCNNGL20{j}.Overshoot;
        mse_PMPCNNGL20{j}(i) = sum( (PMPCNNGL20{j}.state(i,:) - PMPCNNGL20{j}.state(i,end)).^2 )/length(PMPCNNGL20{j}.state(i,:));
    end
    dataPMPCNNGL20 = [dataPMPCNNGL20 [settling_timePMPCNNGL20{j}'; mse_PMPCNNGL20{j}'] ];
end

% SISTEMA GENERAL NONLINEAR
dataZH15 = [];
for j = 1:4
    for i = 1:MPCNNZH15{j}.N*MPCNNZH15{j}.n    
        SMPCNNZH15{j} = stepinfo(MPCNNZH15{j}.state(i,:),MPCNNZH15{j}.t);
        settling_timeMPCNNZH15{j}(i) = SMPCNNZH15{j}.SettlingTime;
        overshootMPCNNZH15{j}(i) = SMPCNNZH15{j}.Overshoot;
        mse_MPCNNZH15{j}(i) = sum( (MPCNNZH15{j}.state(i,:) - MPCNNZH15{j}.state(i,end)).^2 )/length(MPCNNZH15{j}.state(i,:));
    end
    dataZH15 = [dataZH15 [settling_timeMPCNNZH15{j}'; mse_MPCNNZH15{j}'] ];
end


percent_decreaseSS16 = -(settling_timeMPCNN - settling_timeSS16)./settling_timeSS16*100;
percent_decreaseGL20 = -(settling_timeMPCNNGL20 - settling_timeGL20)./settling_timeGL20*100;

% overshoot talvez nao faca sentido
overshoot_decreaseSS16 = -(overshootMPCNN - overshootSS16)./overshootSS16*100;
overshoot_decreaseGL20 = -(overshootMPCNNGL20 - overshootGL20)./overshootGL20*100;

mse_decreaseSS16 = -(mse_MPCNN - mse_SS16)./mse_SS16*100;
mse_decreaseGL20 = -(mse_MPCNNGL20 - mse_GL20)./mse_GL20*100;


dataSS16 = [settling_timeSS16' settling_timeMPCNN' percent_decreaseSS16'; mse_SS16' mse_MPCNN' mse_decreaseSS16'];
dataPMPCNN;
dataGL20 = [settling_timeGL20' settling_timeMPCNNGL20' percent_decreaseGL20'; mse_GL20' mse_MPCNNGL20' mse_decreaseGL20'];
dataPMPCNNGL20;
dataZH15;

data = dataPMPCNNGL20;
fileID = fopen('latextext2.txt','w');
latextext = data2latex(data,2)
fprintf(fileID,latextext);
fclose(fileID);

figure
subplot(2,1,1)
p1 = plot(SS16.t,SS16.state([1:2:SS16.N*2-1],:) +SS16.alpha','r--');
hold on
p2 = plot(MPCNN.t,MPCNN.state([1:2:MPCNN.N*2-1],:) +MPCNN.alpha','k');
xlabel('t')
%ylabel('\phi_i')
ylabel('p')
legend([p1(1) p2(1)],{'SS16','NNMPCCC'})
subplot(2,1,2)
p3 = plot(SS16.t,SS16.state([2:2:SS16.N*2],:),'r--');
hold on
p4 = plot(MPCNN.t,MPCNN.state([2:2:MPCNN.N*2],:),'k');
%ylabel('\phi`_i')
ylabel('v')
xlabel('t')
%legend([p3(1) p4(1)],{'SS16','NNMPC'})

figure
subplot(2,1,1)
p1 = plot(GL20.t,GL20.state([1:2:GL20.N*2-1],:) +GL20.alpha','r--');
hold on
p2 = plot(MPCNNGL20.t,MPCNNGL20.state([1:2:MPCNNGL20.N*2-1],:) +MPCNNGL20.alpha','k');
xlabel('t')
%ylabel('\phi_i')
ylabel('p')
legend([p1(1) p2(1)],{'GL20','NNMPCCC'})
subplot(2,1,2)
p3 = plot(GL20.t,GL20.state([2:2:GL20.N*2],:),'r--');
hold on
p4 = plot(MPCNNGL20.t,MPCNNGL20.state([2:2:MPCNNGL20.N*2],:),'k');
%ylabel('\phi`_i')
ylabel('v')
xlabel('t')
%legend([p3(1) p4(1)],{'GL20','NNMPCCC'})
