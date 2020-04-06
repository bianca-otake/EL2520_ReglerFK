%% Lab 2
clear all, close all
% Exc 3

s = tf('s');

mp = minphase;
mp_min = minreal(mp);

nonmp = nonminphase;
nonmp_min = (nonmp);



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
% hinfvalue = hinfnorm(mp_min); % different scales but the values are the same


%% testing: shouldnt a_test1 == a_test_2 ????

a_test1 = mp.A;
[A B C D] = ssdata(G_mp);
A; % tänker att de inte nödändigtvis behöver vara samma i och med att man kan
% välja olika state space representations beroende på vilken form man vill
% ha det på men är inte säker....

[num,den] = tfdata(G_mp);  % useful, maybe?

%% 3.1.4: Investigate the RGA of the system at frequency 0. What conclusions
% can we draw about the possibility of using decentralized control? 

% minphase
RGA = G_mp .* inv(G_mp)';
% diagonal pairing suitable
evalfr(RGA,0)

% non-minphase

RGA_nonmin = G_nonmp .* inv(G_nonmp)';
evalfr(RGA_nonmin,0)
% off-diagonal pairing suitable

%% 3.1.5 Plot the step response for one input at the time. Investigate the
% outputs: Is the system coupled? Is this in line with the properties of RGA?
figure(5); clf;
subplot(1,2,1);
step(G_mp);% legend('G_mp(1,1)','G_mp(1,2)','G_mp(2,1)','G_mp(2,2)')
grid on; title('Step response minphase system')
% it seems like the diagonal elements are copuled and the anti-diagonal
% elements are cupled as the have similar responses. The bodemag(RGA(i,j)) 
% of those pairs are also identical. The step response goes to very large
% values

subplot(1,2,2); %nonminphase
step(G_nonmp);
grid on; title('Step Response non-minphase system')

%
%% 3.1.6. Describe the most important differences between the two cases and
% discuss how it affects the control performance.

% the coupling changes!

%% Exercise 3.2.1. Design a decentralized controller by pairing inputs and outputs according
% to the RGA analysis. The intended phase margin is phi_m =pi/3 = 60 deg and the crossover
% frequency wc is 0.1 rad/s for the minimum phase case and 0.02 rad/s for the
% non-minimum phase case. (To make sure that the problem is correctly solved, investigate
% the Bode diagram of L.)

wc = 0.1; phi_m = 60;


K1 = 1;
T1 = 1;
f1 = K1*(1+1/(s*T1));
% we want |g11(iwc)f1(iwc)| = 1
% and 
% arg g11(iwc) + arctan(wc*Ti1) ? pi/2 ? phim = ?pi

[m p] = bode(G_mp(1,1),wc);

arctanParameter = -180 + phi_m + 90 - p;

T1 = tand(arctanParameter)/wc;

f1 = K1*(1+1/(s*T1));

[m p] = bode(f1*G_mp(1,1),wc);
K1 = K1/m; f1 = K1*(1+1/(s*T1));
figure(31); bode(f1*G_mp(1,1));  grid on

K2 = 1; 
T2 = 1;
f2 = K2*(1+1/(s*T2));

[m p] = bode(G_mp(2,2),wc);

arctanParameter = -180 + phi_m + 90 - p;

T2 = tand(arctanParameter)/wc;

f2 = K2*(1+1/(s*T2));

[m p] = bode(f2*G_mp(2,2),wc);
K2 = K2/m; f2 = K2*(1+1/(s*T2));
figure(32); bode(f2*G_mp(2,2));  grid on

F = [f1 0; 0 f2];

%% 3.2.3

figure(33); clf;
S = inv(eye(2) + G_mp*F);
sigma(S);
hold on
T = inv(eye(2) + G_mp*F)*G_mp*F
sigma(T)
xlim([0.001,10]); grid on; legend()

%% Exercise 3.2.2. Calculate the singular values of the sensitivity function
% and the complementary sensitivity function. Is the design good with respect
% to sensitivity and robustness?


