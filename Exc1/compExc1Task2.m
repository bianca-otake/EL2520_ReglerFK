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

Fy = 1/G*wc/s;

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
figure(4); 
bodemag( 1/(1+Fy0*G)*Gd,1/(1+Fy1*G)*Gd); legend('p = 100 \omegac','p = 1000 \omegac'); title('Closed loop < 1')
% we want |L|>|G_d| at frec in 0<wc
figure(5); 
bodemag(Fy0*G,Fy1*G,'r-.',Gd,'k.-.',[1,wc])
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end
legend('L p = 100 \omegac','L p = 1000 \omegac', 'G_d'); title('abs(L) > abs(Gd) ');

%% 
wi = 6; % best performance! compared to 7 and 10 
figure(6); clf; hold on

% Fy = (s + wi)/s*1/G*Gd; %% which is improper so we add two poles
Fy2 = (s + wi)/s*1/G*Gd/((s+p1)^2)*p1^2;
subplot(2,1,1); hold on; step(1/(1+Fy2*G)*Gd);
subplot(2,1,2); hold on; bodemag(Fy2,inv(G)*Gd,[0.0001,10]);legend('Fy','1/G*Gd'); grid on;

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end
figure(8); step(Fy2*G/(1+Fy*G))
%%  4.2.2 check r --> y 

figure(8); step(Fy2*G/(1+Fy*G))

%%

wi = 6; 
p1 = 100 * wc; 
Fy = (s + wi)/s*1/G*Gd;
Fy2 = Fy /((s+p1)^2)*p1^2;

Beta = 0.4903;
Tau_d =0.0896;
K = 1.0517;
lead = K *(Tau_d * s + 1) / ( Beta * Tau_d  * s +1); 

Fy3 = Fy2 * lead;
figure;

step(1/(1+Fy3*G)*Fy3*G)

legend('Fy2','Fy3')
grid on
