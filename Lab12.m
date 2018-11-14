[Y, FS]=audioread('SSSSSSS.wav');
y = Y(:,1);

%t = [0:length(Y)-1]/(FS*length(Y));
t = linspace(0, (length(y)-1)/FS, length(y));

figure; plot(t, y, '-k');grid on;
title('Recording.wav');
xlabel('t, Time, s');ylabel('Probably volts?');

fqs = fftshift(fft(y));
f = fftaxisshift(fftaxis(t));

figure;cxplot(f/1e3,fqs);grid on;
title('Pulse');
xzoom(0, 10);
xlabel('f, Freq, kHz');ylabel('v, Volts/Hz');

stft_sound_plot(y, length(y)/10, FS);
