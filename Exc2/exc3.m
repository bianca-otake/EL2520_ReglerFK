%% Lab 2
clear all, close all
% Exc 3

s = tf('s');

mp = minphase;
mp_min = minreal(mp);

nonmp = nonminphase;
nonmp_min = minreal(nonmp);



G_mp = minreal(mp.C*inv(eye(4)*s-mp.A)*mp.B);

G_nonmp = minreal(nonmp.C*inv(eye(4)*s-nonmp.A)*nonmp.B);

%% 3.1.1 Calculate the transfer matrix G(s). Investigate each element of the
% matrix (Hint: G(1,1) extracts element (1,1)). Calculate the poles and zeros of the
% elements.
poles_mp = [pole(G_mp(1,1)); pole(G_mp(1,2)) ; pole(G_mp(2,1)); pole(G_mp(2,2))]
zeros_mp = [tzero(G_mp(1,1)); tzero(G_mp(1,2)) ; tzero(G_mp(2,1)); tzero(G_mp(2,2))] 
% 
poles_nonmp = [pole(G_nonmp(1,1)); pole(G_nonmp(1,2)) ; pole(G_nonmp(2,1)); pole(G_nonmp(2,2))] % poles
zeros_nonmp = [tzero(G_nonmp(1,1)); tzero(G_nonmp(1,2)) ; tzero(G_nonmp(2,1)); tzero(G_nonmp(2,2))] % zeros


%% 3.1.2 Calculate the poles and zeros of the multivariable system. Do these
% imply any constraint on the achievable control performance?

%minreal sys
sysPoles = pole(G_mp)
sysZeros = tzero(G_mp)

% But here all zeros and poles are in LHP --> stable! interesting.
% Also same poles as in 3.1.1 which feels reassuring

% nonminphase 
sysPoles_nonmin = pole(G_nonmp)
sysZeros_nonmin = tzero(G_nonmp)


%% 3.1.3 Investigate the largest and smallest singular values for the system
% at different frequencies. Calculate the H-inf norm of the system.

figure(1); clf; sigma(G_mp);
hinfvalue = hinfnorm(mp_min); % different scales but the values are the same


%% testing: shouldnt a_test1 == a_test_2 ????

a_test1 = mp.A;
[A B C D] = ssdata(G_mp);
A; % t�nker att de inte n�d�ndigtvis beh�ver vara samma i och med att man kan
% v�lja olika state space representations beroende p� vilken form man vill
% ha det p� men �r inte s�ker....

[num,den] = tfdata(G_mp);  % useful, maybe?

%% 3.1.4: Investigate the RGA of the system at frequency 0. What conclusions
% can we draw about the possibility of using decentralized control? 

bodeopts = bodeoptions();
bodeopts.MagUnits = 'abs';

RGA = G_mp .* inv(G_mp)';
h = figure(4); clf
subplot(1,2,1);
bodemag(RGA(1,1),'r',RGA(1,2),RGA(2,1),'k--',RGA(2,2),'y--');
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end
hold on; bodemag(tf(3),'k--'); bodemag(tf(0.5),'k--'); legend('RGA(1,1)','RGA(1,2)','RGA(2,1)','RGA(2,2)','suitable range')
grid on;
% as all of the RGA(i,j)(0) > 0 we can use decentralized control. Negative
% values would switch sign of the gain which would have been very bad but
% as we don't it's ok!
% RGA(1,1) and RGA(2,2) always within suitable pairing range, 
% diagonal elements only suitable for pairing during low frequencies
title('RGA of minphase')
subplot(1,2,2); % non-minphase

RGA_nonmin = G_nonmp .* inv(G_nonmp)';
bodemag(RGA_nonmin(1,1),'r',RGA_nonmin(1,2),RGA_nonmin(2,1),'k--',RGA_nonmin(2,2),'y--');
% bodemag(RGA)    
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end
hold on; bodemag(tf(3),'k--'); bodemag(tf(0.5),'k--'); legend('RGA(1,1)','RGA(1,2)','RGA(2,1)','RGA(2,2)','suitable range')
grid on;

title('RGA of non-minphase')

%% 3.1.5 Plot the step response for one input at the time. Investigate the
% outputs: Is the system coupled? Is this in line with the properties of RGA?
figure(5); clf;
subplot(1,2,1);
step(G_mp(1,1),'r',G_mp(1,2),G_mp(2,1),'k--',G_mp(2,2),'y--'); legend('G_mp(1,1)','G_mp(1,2)','G_mp(2,1)','G_mp(2,2)')
grid on; title('Step response minphase system')
% it seems like the diagonal elements are copuled and the anti-diagonal
% elements are cupled as the have similar responses. The bodemag(RGA(i,j)) 
% of those pairs are also identical. The step response goes to very large
% values

subplot(1,2,2); %nonminphase
(step(G_nonmp(1,1),'r',G_nonmp(1,2),G_nonmp(2,1),'k--',G_nonmp(2,2),'y--'));
legend('G_nonmp(1,1)','G_nonmp(1,2)','G_nonmp(2,1)','G_nonmp(2,2)')
grid on; title('Step Response non-minphase system')

%
%% 3.1.6. Describe the most important differences between the two cases and
% discuss how it affects the control performance.





