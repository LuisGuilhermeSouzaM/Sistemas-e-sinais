%% Análise de Fourier de sinais de aúdio - aúdio gaita
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Boas práticas

clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - leitura de arquivo .wav - audioread

% audioread Read audio files
%    [Y, FS] = audioread(FILENAME) reads an audio file specified by the
%    character vector or string scalar FILENAME, returning the sampled data
%    in Y and the sample rate FS, in Hertz.
[g_k , Fs] = audioread("audio2.wav"); % abertura do arquivo wave

%%%%% reduzir o tamanho de g_k
g_k = g_k(1:1000);
N = length(g_k);
Ts = 1/Fs;                            % tempo de amostragem
Tfinal = N*Ts;                        % VALOR FINAL NO TEMPO
t = linspace(0,Tfinal, N);        % gera o vetor tempo

figure(1)
plot(t, g_k, 'LineWidth',2)
xlabel('tempo em segundos')
ylabel('amplitude do sinal')
title('som de uma gaita blues')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 - Implementar a série de Fourier usando estrutura <for?.
% variavel computacional p -> variavel matemática n
% variavel computacional q -> variavel matemática k

% tic                              % inicia contador
% for p=1:N
%     somatoria = 0;               % valor inicial da somatoria para cada n
%     n = p-1;                     % determina n dado p
%     for q = 1:N
%         k = q-1;                 % determina k dado q
%         %%% determina o valor da somatória
%         somatoria  = somatoria + g_k(q)*exp(-j*2*pi*n*k/N);
%     end
%     X_for(p) = somatoria; % guarda o valor no vetor X[n]
% end
% tempo_for = toc;  % para o contador e grava o valor do tempo de execução
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Implementação matricial
%

tic                                      % inicia contador de tempo
%%%% Criando uma função para o cálculo de WN
WN = @(N) exp(-j*2*pi/N);
W = WN(N);                               % determina a matriz para N pontos
MatrizFourier = W*ones(N,N);             % matriz de fourier

%%%% Criando os vetores n e k

Vetor_n = [0:1:N-1]';
Vetor_k = [0:1:N-1]';

%%%% Criando a matriz nk

Matriz_nk = Vetor_n * Vetor_k';

X_matriz = (MatrizFourier.^Matriz_nk)*g_k*(1/N);
tempoMatriz = toc    % para o contador e grava o valor do tempo de execução
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
