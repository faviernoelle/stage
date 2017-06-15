clear all
close all
clc 

%% 

u1 = zeros(10,1);
u2 = zeros(10,1);
u3 = zeros(10,1);
u4 = zeros(10,1);
u5 = zeros(10,1);
u6 = zeros(10,1);
u7 = zeros(10,1);

for i=1:10
    u1(i) = 10 * rand ;
    u2(i) = 10 * rand ; 
    u3(i) = 10 * rand ; 
    u4(i) = 10 * rand ; 
    u5(i) = 10 * rand ; 
    u6(i) = 10 * rand ; 
    u7(i) = 10 * rand ; 
end

stem(u1); shg
hold on 
stem(u2)
stem(u3)
stem(u4)
stem(u5)
stem(u6)
stem(u7)
hold off
legend('u1','u2','u3','u4','u5','u6','u7')

u=[u1 u2 u3 u4 u5 u6 u7];

% writetable(u, 'test')





