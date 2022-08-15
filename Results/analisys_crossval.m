clear all; close all; clc;
load('results\dataWW20_Crossval_50\dataWW20nKMPC 2021-7-22-10-59.mat') % Linear 50

MSE1 = MSE;
for i = 1:length(MSE1)
    MSE1norm(i) = norm(MSE1(:,i));
end

neurons1 = 1:5:50;

semilogy(neurons1,MSE1norm,'k')
grid
box off
xlabel('m')
ylabel('mse')

load('results\dataWW20_Crossval_10\dataWW20nKMPC 2021-7-22-11-38.mat') % Linear 10

MSE2 = MSE;
for i = 1:length(MSE2)
    MSE2norm(i) = norm(MSE2(:,i));
end

neurons2 = 1:10;
figure
semilogy(neurons2,MSE2norm,'k')
grid
box off
xlabel('m')
ylabel('mse')

MSEmixnorm = [MSE2norm MSE1norm(3:end)];
neurons3 = [1:10 11:5:50];
figure
semilogy(neurons3,MSEmixnorm,'k')
grid
box off
xlabel('m')
ylabel('mse')

load('results\dataGL20_Crossval\dataGL20nKMPC 2021-7-22-1-2.mat') % System with disturbances
MSEnl = MSE(:,1:69);
for i = 1:length(MSEnl)
    MSEnlnorm(i) = norm(MSEnl(:,i));
end

neuronsnl = 1:69;

figure
semilogy(neuronsnl,MSEnlnorm,'k')
grid
box off
xlabel('m')
ylabel('mse')

load('results\dataZH15_Crossval\dataZH15nKMPC 2021-10-21-15-37.mat') % Nonlinear system
MSEnl2 = MSE(:,1:50);
for i = 1:length(MSEnl2)
    MSEnl2norm(i) = norm(MSEnl2(:,i));
end

neuronsnl2 = 1:50;

figure
semilogy(neuronsnl2,MSEnl2norm,'k')
grid
box off
xlabel('m')
ylabel('mse')

h_linear = load('results\dataWW20_Horizon\dataWW20nKMPC 2021-10-26-21-56.mat') % Linear
h_nonlinear = load('results\dataGL20_Horizon\dataGL20nKMPC 2021-10-27-15-11.mat') %With disturbances
h_gnonlinear = load('results\dataZH15_Horizon\dataZH15nKMPC 2021-10-27-15-21.mat') % Nonlinear
h_car = load('results\dataCar_Horizon\dataCarnKMPC 2022-7-18-12-5.mat') % Car


% h_linear = load('C:\Users\PICHAU\OneDrive - unb.br (1)\Doutorado\Implementacao\results\dataWW20nKMPC 2021-11-3-15-25\dataWW20nKMPC 2021-11-3-15-25.mat') % Linear
% h_nonlinear = load('C:\Users\PICHAU\OneDrive - unb.br (1)\Doutorado\Implementacao\results\dataGL20nKMPC 2021-11-3-17-42\dataGL20nKMPC 2021-11-3-17-42.mat') %Nonlinear
% h_gnonlinear = load('C:\Users\PICHAU\OneDrive - unb.br (1)\Doutorado\Implementacao\results\dataZH15nKMPC 2021-11-3-22-37\dataZH15nKMPC 2021-11-3-22-37.mat') % General Nonlinear


nh_linear.MSEn = normalize(h_linear.MSEn);
nh_nonlinear.MSEn = normalize(h_nonlinear.MSEn);
nh_gnonlinear.MSEn = normalize(h_gnonlinear.MSEn);
nh_car.MSEn = normalize(h_car.MSEn);


stdv = 1e5;
for i = 1:length(h_nonlinear.MSEn)
    if h_nonlinear.MSEn(i) > 1e3
        h_nonlinear.MSEn(i) = 1e3;
    end
    if h_gnonlinear.MSEn(i) > stdv
        h_gnonlinear.MSEn(i) = stdv;
    end
    if h_car.MSEn(i) > stdv
        h_car.MSEn(i) = stdv;
    end
    if h_linear.MSEn(i) > stdv
        h_linear.MSEn(i) = stdv;
    end
end

vector = [1:19 25:39 40:10:80 96 100];
teste = h_linear.MSEn(vector);
teste(4) = 4.9238e+08;
%figure
%semilogy(vector,teste)
h_linear.MSEn = teste;


stdv = 5;
for i = 1:length(nh_nonlinear.MSEn)
    if nh_nonlinear.MSEn(i) > stdv
        nh_nonlinear.MSEn(i) = stdv;
    end
    if nh_gnonlinear.MSEn(i) > stdv
        nh_gnonlinear.MSEn(i) = stdv;
    end
    if nh_car.MSEn(i) > stdv
        nh_car.MSEn(i) = stdv;
    end
    if nh_linear.MSEn(i) > stdv
        nh_linear.MSEn(i) = stdv;
    end
end

figure
semilogy(vector,h_linear.MSEn,'k')
hold on
semilogy(h_nonlinear.MSEn,'--r')
hold on 
semilogy(h_gnonlinear.MSEn,'-.b')
semilogy(h_car.MSEn,':g')
grid
box off
xlabel('horizon')
ylabel('mse')
legend('linear','nonlinear','gnonlinear')
legend('linear','nonlinear','gnonlinear','gnonlinear2')

% figure
% plot(vector,h_linear.MSEn,'k')
% hold on
% plot(h_nonlinear.MSEn,'--r')
% hold on 
% plot(h_gnonlinear.MSEn,'-.b')
% grid
% box off
% xlabel('horizon')
% ylabel('mse')
% legend('linear','nonlinear','gnonlinear')

% figure
% plot(nh_linear.MSEn,'k')
% hold on
% plot(nh_nonlinear.MSEn,'--r')
% hold on
% plot(nh_gnonlinear.MSEn,'-.b')
% grid
% box off
% xlabel('horizon')
% ylabel('mse')
% legend('linear','nonlinear','gnonlinear')