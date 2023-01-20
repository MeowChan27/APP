% Ouvrir le fichier .wav
[x,fe] = audioread('100.wav');

x = x - mean(x);

% Calculer la longueur du signal
N = length(x);

nbrS = (N/fe) - mod((N/fe),3);

tiledlayout(2,1)

% Liste des temps
temps = [];

for i = 1:N
    temps(i) = i/fe;
end

nexttile

plot(temps,x)

% Ajouter un titre à l'axe des abscisses
xlabel('Temps (s)')

%Affichage 

% Ajouter un titre à l'axe des ordonnées
ylabel('Amplitude')

% Ajouter une légende à la figure
legend('Signal reçu')

% Afficher une grille sur la figure
grid on

% Ajouter un titre à la figure
title('Analyse temporelle')

% ANALYSE FREQUENCIELLE

%abscSTFT = 0:fe/N:fe-(fe/N);

inte = 0;

tblAll = [];

for k = 1:3*fe:fe*(nbrS-3)+1
    lstTempsSample = temps(k:k+3*fe);
    lstxSample = x(k:k+3*fe);
    X = abs(fft(lstxSample));
    inte = inte + 1;
    tblAll = [tblAll X];
end

lstFrequence = [];
Nt = fe*3;
absiceTronque = 0:fe/Nt:fe;

for i = 1:length(tblAll(:,1))
    lstFrequence(i) = i*fe/length(tblAll(:,1));
end

nexttile

for i = 1:inte
    plot(absiceTronque, tblAll(:,i));
    hold on;
end

% Ajouter un titre à l'axe des abscisses
xlabel('Fréquence (Hz)')

% Ajouter un titre à l'axe des ordonnées
ylabel('Amplitude')

% Afficher une grille sur la figure
grid on

% Ajouter un titre à la figure
title('Analyse fréquence')

% Définir les limites sur l'axe des abscisses et des ordonnées
axis([0 2 0 6])

