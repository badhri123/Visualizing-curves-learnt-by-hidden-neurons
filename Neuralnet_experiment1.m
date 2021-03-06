%% Neural network - Curves learnt by the the hidden neurons

clear;
clc;
% data1=randi([1 150],150,1);
% data2=randi([1 22500],150,1);
% data1=data1/max(data1);
% data2=data2/max(data2);
% data=[data1,data2];
% c=data(:,2)>=data(:,1).^2;         % y=x^2 is the decision boundary
load('c.mat');
load('data.mat');
data_train=data(1:120,:);
data_test=data(121:150,:);
ytrain=c(1:120);
ytest=c(121:150);
 
figure;
gscatter(data_train(:,1),data_train(:,2),c(1:120));
hold on;
te=[0:0.01:1]';
plot(te,te.^2,'g');
data_train=data_train';
data_test=data_test';
% saveas(gcf,'Data and ideal decesion boundary.jpg');
% Neural network classifier

% Initialization

[n,m]=size(data_train);
[nt,mt]=size(data_test);
w1=rand(3,2);
w2=rand(1,3);
b1=zeros(3,1);
b2=0;
alpha=0.9;
iter=3000;
i=0;
cost=[];

while i<=iter
    
    % Forward Propogation
    
    z1=w1*data_train + repmat(b1,1,m);
    a1=sigmoid(z1);
    z2=w2*a1 + repmat(b2,1,m);
    h=sigmoid(z2);
    
    % Backpropogation
    
    dz2=h-ytrain';
    dw2=(1/m)*dz2*a1';
    db2=(1/m)*sum(dz2);
    dz1=(w2'*dz2).*(a1.*(1-a1));
    dw1=(1/m)*dz1*data_train';
    db1=(1/m)*sum(dz1,2);
    
    % Weight update
    
    w1=w1-alpha*dw1;
    w2=w2-alpha*dw2;
    b1=b1-alpha*db1;
    b2=b2-alpha*db2;
    
    temp=(-1/m)*( ytrain'*log(h') + (1-ytrain')*log(1-h') );
    cost=[cost;temp];
    i=i+1;
end
% figure;
% plot(cost);
% Testing

zt1=w1*data_test+b1;
at1=sigmoid(zt1);
zt2=w2*at1+b2;
ht=sigmoid(zt2);
ypred=ht>=0.5;
ypred=ypred';


% Misclassification error

error=abs(ypred-ytest);
error=error~=0;
er=sum(error);
accuracy=(1-(er/mt))*100

% Plotting the lines learnt by hidden neurons

r=rand(2,3);
z1=w1(1,:)*r + [b1(1) b1(1) b1(1)];
z2=w1(2,:)*r + [b1(2) b1(2) b1(2)];
z3=w1(3,:)*r + [b1(3) b1(3) b1(3)];
figure;
patch([r(1,1) r(2,1) z1(1)],[r(1,2) r(2,2) z1(2)],[r(1,3) r(2,3) z1(3)],'green');
view(2);
%saveas(gcf,'Curve learnt - 1st Hidden neuron.jpg');
figure;
patch([r(1,1) r(2,1) z2(1)],[r(1,2) r(2,2) z2(2)],[r(1,3) r(2,3) z2(3)],'red');
view(2);
%saveas(gcf,'Curve learnt - 2nd Hidden neuron.jpg');
figure;
patch([r(1,1) r(2,1) z3(1)],[r(1,2) r(2,2) z3(2)],[r(1,3) r(2,3) z3(3)],'blue');
view(2);
%saveas(gcf,'Curve learnt - 3rd Hidden neuron.jpg');




    
