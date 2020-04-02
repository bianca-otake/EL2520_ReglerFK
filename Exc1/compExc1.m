%% Exercise 4.1.1. 
% Use the procedure introduced in the basic course to construct a leadlag
% controller which eliminates the static control error for a step response in the reference
% signal.
clear all
close all
s = tf('s');
G = 3*(1-s)/((5*s + 1)*(10*s+1));
figure; subplot(1,2,2);
bode(G); grid on; title('Original system G')
subplot(1,2,1); step(feedback(G,1)); title(''); grid on

% The phase margin should be 30deg at the cross-over frequency wc = 0.4 rad/s.

[m,p] = bode(G,0.4); %% vi vill att detta ska returnera 1 och 30 deg = 0.5235987756 rad

wc = 0.4;
K = 1/m;
%% Lead-lag parameters

% figure; 
% bode(G*K); grid on; title('G/m0') 
beta  = 0.455;
tauD = 1/(wc*sqrt(beta));

Flead = K*(tauD*s + 1)/(beta*tauD*s + 1);
[m,p] =bode(Flead*G,0.4)
K1 = K/m
Flead = K1*(tauD*s + 1)/(beta*tauD*s + 1);

[Gm,Pm,wp,wc] = margin(Flead*G);
%%
tauI = 5/wc;

T = minreal(feedback(G*Flead,1));
figure; step(T); grid on; title('30 deg \phi_m lead lag compensated')
S = feedback(1,G*Flead);
gamma = 0.05;

% lead-lag link
Flag = (tauI*s + 1)/(tauI*s + gamma);

[m,p] =bode(Flead*Flag*G,0.4)
L30 = Flead*Flag*G/m;

S30 = feedback(1,L30);
T30 = minreal(feedback(L30,1));
figure; subplot(1,2,1); 
step(T30); grid on; title('30 deg \phi_m lead lag compensated')
subplot(1,2,2)
bode(Flead*Flag*G/m); grid on
[Gm,Pm,wp,wc] = margin(L30);

%% Task 4.1.2 bandwidth

bw = bandwidth(T); % of closed loop sys [rad/s]
figure; bode(T)

%% Task 4.1.3 new lead lag

% The phase margin should be 30deg at the cross-over frequency wc = 0.4 rad/s.

[m,p] = bode(G,0.195); %% vi vill att detta ska returnera 1 och 30 deg = 0.5235987756 rad

wc = 0.195;
K0 = 1/m;

% Lead-lag parameters
beta  = 0.20;
tauD = 1/(wc*sqrt(beta));

Flead = K0*(tauD*s + 1)/(beta*tauD*s + 1);
[m,p] =bode(Flead*G,0.4)
K1 = K0/m
Flead = K1*(tauD*s + 1)/(beta*tauD*s + 1);

[Gm,Pm,wp,wc] = margin(Flead*G);

tauI = 5/wc;

T = minreal(feedback(G*Flead,1));
% figure; step(T); grid on
S = feedback(1,G*Flead);
gamma = 0.05;

% lead-lag link
Flag = (tauI*s + 1)/(tauI*s + gamma);

[m,p] =bode(Flead*Flag*G,0.4)
L50 = Flead*Flag*G/m;

S50 = feedback(1,L50);
T50 = minreal(feedback(L50,1));
figure; subplot(1,2,1); 
step(T50); grid on; title('50 deg \phi_m lead lag compensated')
subplot(1,2,2)
bode(Flead*Flag*G/m); grid on
[Gm,Pm,wp,wc] = margin(L50)
bw50 = bandwidth(T50);
figure; bode(T50); title('50 deg \phi_m'); grid on


bode(T30,T50)
figure;
step(T30,T50); grid on
