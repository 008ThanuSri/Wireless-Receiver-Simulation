% Wireless Receiver Simulation (IEEE 802.11 - Non-HT PHY)
% Includes: Channel Estimation, Time-of-Arrival (ToA) Analysis, Signal Detection

clc;
clear;

%% Step 1: System Configuration
cfg = wlanNonHTConfig;  % Non-HT Wi-Fi configuration (similar to 802.11a)
fs = wlanSampleRate(cfg);  % Sampling rate

%% Step 2: Generate a Random Wi-Fi Packet
numBits = 1000;
dataBits = randi([0 1], numBits, 1);
txSig = wlanWaveformGenerator(dataBits, cfg);

%% Step 3: Apply Wireless Channel Effects (Multipath + AWGN)
chan = comm.RayleighChannel(...
    'SampleRate', fs, ...
    'PathDelays', [0 50e-9 120e-9], ...
    'AveragePathGains', [0 -3 -6], ...
    'MaximumDopplerShift', 5);

rxChanSig = chan(txSig);  % Multipath channel
rxSig = awgn(rxChanSig, 20, 'measured');  % Add white Gaussian noise

%% Step 4: Time-of-Arrival (ToA) Estimation Using Cross-Correlation
ltfRef = wlanLLTF(cfg);  % Ideal L-LTF reference
corr = xcorr(rxSig, ltfRef);
[~, peakIdx] = max(abs(corr));
toaSamples = peakIdx - length(rxSig);  % ToA in samples
toaSeconds = toaSamples / fs;

fprintf('Estimated Time-of-Arrival (ToA): %.2f microseconds\n', toaSeconds * 1e6);

% Optional: Plot cross-correlation result
figure;
plot(abs(corr));
xlabel('Samples');
ylabel('Correlation Magnitude');
title('ToA Estimation via Cross-Correlation');
grid on;

%% Step 5: Channel Estimation Using L-LTF
ltfIndices = wlanFieldIndices(cfg, 'L-LTF');
ltfRx = rxSig(ltfIndices.LLTF(1):ltfIndices.LLTF(2));
ltfDemod = wlanLLTFDemodulate(ltfRx);
chanEst = wlanLLTFChannelEstimate(ltfDemod);

%% Step 6: Signal Detection (Recover Transmitted Data)
% Data field index
dataInd = wlanFieldIndices(cfg, 'NonHT-Data');
rxData = rxSig(dataInd.NonHTData(1):dataInd.NonHTData(2));

% Recover data using estimated channel
[rxBits, ~] = wlanNonHTDataRecover(rxData, chanEst, cfg);

%% Step 7: Bit Error Rate (Optional Check)
rxBits = rxBits(1:length(dataBits));  % Match length for comparison
numErrors = sum(rxBits ~= dataBits);
ber = numErrors / length(dataBits);
fprintf('Bit Error Rate (BER): %.4f\n', ber);
