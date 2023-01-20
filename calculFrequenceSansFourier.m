% Ouvrir le fichier .wav
[x,fe] = audioread('101.wav');

%Prise du signal utile
x = x(x >0.01);

x = x-mean(x);

% Calculer la longueur du signal
N = length(x);
dureeEnSeconde = N / fe;
abscTemp = 0:1/fe:dureeEnSeconde - (1/fe);


maxSeuil = max(x)*0.95;

TempMaxLoc = [];
tempIndexs = [];
Pics = [];
for i = 2:N
    if x(i) > maxSeuil
        TempMaxLoc(end + 1) = x(i);
        tempIndexs(end +1) = i;
    end

    if x(i-1) > maxSeuil && x(i) <= maxSeuil
        [val, idx] = max(TempMaxLoc);
        Pics(end+1) = tempIndexs(idx);
        TempMaxLoc = [];
        tempIndexs = [];
    end
end

PicsEnS = Pics./fe;

freqByPeriod = [];

for i = 2:length(PicsEnS)
    freqByPeriod(end + 1) = (1/(PicsEnS(i)- PicsEnS(i-1)))*60;
   
end

r = xcorr(x);

%abscTempR = 0:(1/fe)/2:dureeEnSeconde - (1/fe);
Nxcorr = length(r);

y = r(ceil(Nxcorr/2):Nxcorr);

%Seconde dans un interval
sEch = 3;
k3Index = find(abscTemp == sEch) -1;
k1Index = find(abscTemp == 1) -1;

autoCorrPeaks = [];
tempMeanFreq = [];
[pks, indxs] = findpeaks(y,'MinPeakDistance',k1Index/2);
for i =1:length(indxs)-3
    tempMeanFreq = [];
    tempMeanFreq(end + 1) = (1/((indxs(i+1)- indxs(i))/fe))*60;
    tempMeanFreq(end + 1) = (1/((indxs(i+2)- indxs(i+1))/fe))*60;

    autoCorrPeaks(end +1) = mean(tempMeanFreq);
end



% Afficher le signal brut
plot(abscTemp,y)

% Ajouter un titre à la figure
title('Autocorelation')

% Ajouter un titre à l'axe des abscisses
xlabel('Temps')

% Ajouter un titre à l'axe des ordonnées
ylabel('Amplitude')

% Afficher une grille sur la figure
grid on 

% % Afficher le signal brut
% plot(abscTemp, x)
% 
% % Ajouter un titre à la figure
% title('Signal sonore sur le temps')
% 
% % Ajouter un titre à l'axe des abscisses
% xlabel('Temps')
% 
% % Ajouter un titre à l'axe des ordonnées
% ylabel('Amplitude')
% 
% % Afficher une grille sur la figure
% grid on 







