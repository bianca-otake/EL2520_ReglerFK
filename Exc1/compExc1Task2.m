%% Task 4.2.1
% for which frew is control action needed? 
clear all
close all
s = tf('s');
G = 20/((s + 1)*((s/20)^2+s/20 + 1));
figure; bode(G); grid on 
Gd = 10/(s + 1);
figure;  bode(Gd); title('G_d'); grid on
wc = 9.95; % rad/s avlest fran bode av G

Fy = 1/G*wc/s

p0 = 100*wc;
p1 = 1000*wc;

Fy0 = p0*p0*Fy/((s+p0)^2);
Fy1 = p1*p1*Fy/((s+p1)^2);


figure; bode(Fy*G,Fy0*G,Fy1*G); grid on; 
legend('Improper','p = 100 \omegac','p = 1000 \omegac'); 
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

figure(3); step(1/(1+Fy*G)*Gd, 1/(1+Fy0*G)*Gd,1/(1+Fy1*G)*Gd);
legend('Improper','p = 100 \omegac','p = 1000 \omegac'); 
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end
%%
% we want abs(1/(1+Fy*G)*Gd) < 1
figure(4); bodemag( 1/(1+Fy0*G)*Gd,1/(1+Fy1*G)*Gd); legend('p = 100 \omegac','p = 1000 \omegac'); title('Closed loop < 1')
% we want |L|>|G_d| at frec in 0<wc
figure(5); bodemag(Fy0*G,Fy1*G,'r-.',Gd,'k.-.',[1,wc])
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end
legend('L p = 100 \omegac','L p = 1000 \omegac', 'G_d'); title('abs(L) > abs(Gd) ');

%% 
wi = 8; % best performance! compared to 7 and 10 
figure(6); clf; hold on
for wi = [10,12,14]
    Fy = (s + wi)/s*1/G*Gd %% which is improper so we add two poles
    Fy2 = (s + wi)/s*1/G*Gd/((s+p1)^2)*p1^2
    step(1/(1+Fy2*G)*Gd);
end
legend('\omega_I = 10','\omega_I = 12','\omega_I = 14'); grid on;
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end