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

p10     = 10*wc;
p100    = 100*wc;
p1000   = 1000*wc;

Fy0 = p10*p10*Fy/((s+p10)^2);
Fy1 = p100*p100*Fy/((s+p100)^2);
Fy2 = p1000*p1000*Fy/((s+p1000)^2);

figure(1); bode(Fy*G,Fy0*G,Fy1*G,Fy2*G); grid on; 
legend('Improper','p = 10 \omegac','p = 100 \omegac', 'p = 1000 \omegac'); 
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

figure(3); step(1/(1+Fy*G)*Gd, 1/(1+Fy0*G)*Gd , 1/(1+Fy1*G)*G);
legend('Improper','p = 10 \omegac','p = 100 \omegac'); 
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


%% q 4.2.3

% first add lead action to F_y to reduce overshoot
wi = 6; 
p1 = 10 * wc; 
Fy = (s + wi)/s*1/G*Gd;
Fy2 = Fy /((s+p1)^2)*p1^2;

% How do we tune these paramters!?
wc = 10
% desired wc = 1 rad/s
[m,p] =bode(Fy2*G,wc)
K1 = 1/m
% figure; bode(Fy2*G*K1)
Beta = 0.4903;
Tau_d = 1/(wc*sqrt(Beta));
% K1 = 1.0517

lead = K1 * (Tau_d * s + 1) / ( Beta * Tau_d  * s +1); 

% check if Fy3 reduces overshoot: 
Fy3 = Fy2 * lead;
closed_2 = 1/(1+Fy2*G)*Fy2*G;
closed_3 = 1/(1+Fy3*G)*Fy3*G;
figure(9);clf
hold on
step(closed_2);
step(closed_3);
legend('without lead-link','with lead-link')
grid on 
hold off
stepinfo(closed_3) % overshoot is < 10%!

% Designing Fr filter
% design Fr: WIP
L = Fy3*G;
S = 1/(1 + L);
T = L/(1+L);
Tau = 0.5; 
Fr = 1 / (1 + Tau * s); 

figure(3); clf; hold on; 
step(Fy3*Fr*S); step(Fy3*Gd*S); step(Fy3*Fr*S-Fy3*Gd*S)
title('Magnitude of u signals')

%% Checking _ALL_ coonditions!!!!!!!!!!!!!!!!!!!!!!!!!
figure(11);
subplot(1,3,1); step(closed_3); title('step r -> y'); grid on
subplot(1,3,2); step(1/(1+Fy*G)*Gd); grid on; title('step d -> y')
subplot(1,3,3); hold on; 
step(Fy3*Fr*S); step(Fy3*Gd*S); step(Fy3*Fr*S-Fy3*Gd*S);legend('Fr*Fy*S','Fy*Gd*S','Fr*Fy*S-Fy*Gd*S'); grid on
title('|u|')

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end

figure(12);
subplot(1,2,1);
bodemag(S); title('S(i\omega)'); grid on
subplot(1,2,2);
bodemag(T); title('T(i\omega)'); grid on



lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end

