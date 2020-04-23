%% LAB 3 intro: 


s = tf('s'); 
G = 1e4 * (s+2) / (s+3) / (s+100)^2; 
Hinf(G)

%% find weights for |S|w
% set at -0.01 +- 314i for now. Export to workspace and plot. 
Fsim=F; Gsim=G ;

macro



%% 4.2 Robustness 
% del i: 
G0 = G * (s-1)/(s+2);


Fsim = F;
Gsim = G0;
% del iii:

T = F * G/(1 + F*G);
T0 = F * G0/(1 + F*G0);

deltaG = G0/G -1;
deltaGinv = 1/deltaG;

% is the the condition fulfilled?
figure(5); 
bodemag(T0, deltaGinv); legend()

    
% add a pole to W_t -0.01 +- 10

%% 4.3
Fsim = F;
Gsim = G0;

macro 



